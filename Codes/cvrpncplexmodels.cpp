#include "cvrpninstance.hpp"

#include <ilcplex/ilocplex.h>

#include <ctime>
#include <filesystem>
#include <iomanip>
#include <iostream>

// ============================================================
// CPLEX model for the CVRPN.
//
// The instance is read following the file format specified in
// "cvrpninstance.hpp". The nonconvex polygons are decomposed
// into convex parts with CGAL (optimal convex partition).
//
// The model is built with the coordinates translated and scaled (see
// scaleVertices in "cvrpninstance.hpp"). The log of CPLEX is in these
// coordinates; the results printed after it are in the original
// units of the instance.
//
// There are two big-M constants. M1, of the constraints that link the
// distances with the arcs, is the diagonal of the smallest rectangle
// that contains the depot and all the polygons. M2, of the constraints
// of the convex parts of the nonconvex polygons, can be computed in
// two ways, both described in the paper (see use_tight_bigm below): a
// single constant computed from that rectangle, or a tight constant
// for each constraint, computed from the polygon of the client.
//
// Two formulations are available:
// - Model (2)--(20)
// - Model (2)--(26), with additional constraints
//
// Optionally, the best solution between the ones computed by the
// constructive heuristics CW and NN of the method (Fortran code,
// see cvrpncplexinitsol.f90) is used in one of two ways:
// - as an initial solution (MIP start) that CPLEX may modify, or
// - to fix the routes, so that only the visit points are optimized.
//
// When the routes are fixed, the model is built only with what is
// needed to compute the visit points: the arcs of the routes, the
// variables that model the distances between consecutive visit points
// and the constraints that say that each visit point belongs to its
// polygon. The routing variables x, the load flow variables z and the
// constraints related to them (degree, capacity, subtour elimination
// and the big-M constraints that link the distances with x) are not
// part of the model in this case.
//
// Usage: ./cvrpncplexmodels instance.dat [--model 20|26] [--start none|warm|fixed]
//
// --model 20     Model (2)--(20)
// --model 26     Model (2)--(26)
// --start none   the solution of the constructive heuristics is not used
// --start warm   it is given to CPLEX as an initial solution (MIP start)
// --start fixed  its routes are fixed
//
// When an option is not given, the default value defined below is used.
//
// If savefigure (below) is true, a MetaPost file with a figure of the
// solution found is saved in folder figures_cplex.
// ============================================================

// Default value of option --model (20 or 26)
const int default_model = 20;

// Default value of option --start ("none", "warm" or "fixed")
const std::string default_start = "none";

// Big-M constant of the constraints that say that the visit point of a
// nonconvex client belongs to one of the convex parts of its polygon.
// If true, each constraint uses its own (tight) constant, computed from
// the polygon of the client. If false, all the constraints use a
// single constant, computed from the rectangle that contains the
// depot and all the polygons. Both are described in the paper. The
// optimal solutions are the same in both cases; the tight constants
// make the continuous relaxation of the model stronger. It applies to
// all the values of --start.
const bool use_tight_bigm = true;

// If true, a MetaPost file with a figure of the solution found is
// saved in folder figdir. If false, no file is created.
const bool savefigure = true;

// Folder in which the figures of the solutions (.mp files) are saved
const std::string figdir = "figures_cplex";

// CPU time limit in seconds
const double tlim = 3600.0;

// Number of threads used by CPLEX
const int nthreads = 1;

typedef IloArray<IloNumVarArray> NumVarMatrix;
typedef IloArray<IloBoolVarArray> BoolVarMatrix;

int main(int argc,char **argv)
{
  const std::string usage = "Usage: ./cvrpncplexmodels instance.dat [--model 20|26] [--start none|warm|fixed]";

  if ( argc < 2 ) {
    std::cerr << usage << std::endl;
    return 1;
  }

  const std::string filename = argv[1];

  // ====================
  // Command-line options
  // ====================

  std::string model_option = std::to_string(default_model);
  std::string start_option = default_start;

  for ( int k = 2; k < argc; k += 2 ) {
    const std::string option = argv[k];
    if ( k + 1 >= argc || ( option != "--model" && option != "--start" ) ) {
      std::cerr << "ERROR: Invalid option " << option << std::endl;
      std::cerr << usage << std::endl;
      return 1;
    }

    if ( option == "--model" ) {
      model_option = argv[k + 1];
    } else {
      start_option = argv[k + 1];
    }
  }

  if ( model_option != "20" && model_option != "26" ) {
    std::cerr << "ERROR: Invalid value for --model: " << model_option << std::endl;
    std::cerr << usage << std::endl;
    return 1;
  }

  if ( start_option != "none" && start_option != "warm" && start_option != "fixed" ) {
    std::cerr << "ERROR: Invalid value for --start: " << start_option << std::endl;
    std::cerr << usage << std::endl;
    return 1;
  }

  // false: Model (2)--(20); true: Model (2)--(26)
  const bool use_additional_constraints = ( model_option == "26" );

  // If true, the solution of the constructive heuristics is given to
  // CPLEX as an initial solution (MIP start). CPLEX is free to modify it.
  const bool use_initial_solution = ( start_option == "warm" );

  // If true, the routes of the solution of the constructive heuristics
  // are fixed and CPLEX optimizes the visit points only.
  const bool use_fixed_initial_routes = ( start_option == "fixed" );

  // ==================================================
  // Read the instance and compute the convex partition
  // ==================================================

  Instance inst;
  InitialSolution inisol;
  double scalefactor;
  std::vector<double> xs,ys;

  try {
    inst = readInstance(filename);
    convexPartition(inst);
    scaleVertices(inst,scalefactor,xs,ys);

    // Solution of the constructive heuristics (CW or NN), in the original coordinates of the instance
    if ( use_initial_solution || use_fixed_initial_routes ) {
      inisol = initialSolution(inst,filename);
    }
  } catch ( const std::exception& e ) {
    std::cerr << "ERROR: " << e.what() << std::endl;
    return 1;
  }

  const int m = inst.m;

  // h[i] is the number of convex parts of client i, i = 1,...,m
  std::vector<int> h(m + 1,0);
  for ( int i = 1; i <= m; i++ ) {
    h[i] = (int) inst.U[i - 1].size();
  }

  double totaldem = 0.0;
  for ( int i = 0; i < m; i++ ) {
    totaldem += inst.dem[i];
  }

  // ================
  // Big-M constants
  // ================

  // Smallest rectangle [xmin,xmax] x [ymin,ymax] that contains the
  // depot (which is at the origin) and all the polygons
  double xmin = 0.0,xmax = 0.0,ymin = 0.0,ymax = 0.0;
  for ( int j = 0; j < inst.n; j++ ) {
    xmin = std::min(xmin,xs[j]);
    xmax = std::max(xmax,xs[j]);
    ymin = std::min(ymin,ys[j]);
    ymax = std::max(ymax,ys[j]);
  }

  // M1 is the length of the diagonal of the rectangle, which is an
  // upper bound on the distance between any two visit points
  const double M1 = std::sqrt( ( xmax - xmin ) * ( xmax - xmin ) + ( ymax - ymin ) * ( ymax - ymin ) );

  // M2 is the maximum of a x + b y + c over the rectangle and over
  // all the half-planes that define the convex parts of the nonconvex
  // polygons. Since the function is linear, its maximum over the
  // rectangle is attained at one of the four corners.
  //
  // If use_tight_bigm is true, M2 is not used: each constraint of a
  // convex part of a nonconvex polygon has its own (tight) big-M
  // constant, computed where the constraint is built.
  double M2 = 0.0;
  for ( int i = 1; i <= m; i++ ) {
    if ( h[i] > 1 ) {
      for ( int l = 0; l < h[i]; l++ ) {
        for ( const HalfPlane& e : partHalfPlanes(inst.U[i - 1][l],xs,ys) ) {
          M2 = std::max(M2,e.a * xmin + e.b * ymin + e.c);
          M2 = std::max(M2,e.a * xmin + e.b * ymax + e.c);
          M2 = std::max(M2,e.a * xmax + e.b * ymin + e.c);
          M2 = std::max(M2,e.a * xmax + e.b * ymax + e.c);
        }
      }
    }
  }

  IloEnv env;
  int status = 0;

  try {
    IloModel model(env);

    // ==================
    // Decision variables
    // ==================

    // Node 0 is the depot and nodes 1,...,m are the clients. The
    // variables associated with arcs are defined for i != j only.

    // usearc[i][j] indicates whether arc (i,j) is part of the model.
    // All the arcs are part of the model, unless the routes are fixed.
    // In that case, only the arcs of the fixed routes are considered.
    std::vector<std::vector<char>> usearc(m + 1,std::vector<char>(m + 1,0));

    if ( use_fixed_initial_routes ) {
      for ( const std::vector<int>& route : inisol.routes ) {
        int prev = 0;
        for ( int i : route ) {
          usearc[prev][i] = 1;
          prev = i;
        }
        usearc[prev][0] = 1;
      }
    } else {
      for ( int i = 0; i <= m; i++ ) {
        for ( int j = 0; j <= m; j++ ) {
          if ( i != j ) usearc[i][j] = 1;
        }
      }
    }

    BoolVarMatrix x(env,m + 1);                  // 1 if arc (i,j) is used, 0 otherwise
    NumVarMatrix z(env,m + 1);                   // load flow on arc (i,j)
    NumVarMatrix gama(env,m + 1);                // Euclidean distance associated with arc (i,j)
    NumVarMatrix y(env,m + 1);                   // auxiliary variable for the norm (\xi)
    NumVarMatrix qx(env,m + 1),qy(env,m + 1);    // auxiliary variables \xi_x and \xi_y

    for ( int i = 0; i <= m; i++ ) {
      x[i] = IloBoolVarArray(env,m + 1);
      z[i] = IloNumVarArray(env,m + 1,0.0,IloInfinity);
      gama[i] = IloNumVarArray(env,m + 1,0.0,IloInfinity);
      y[i] = IloNumVarArray(env,m + 1,0.0,IloInfinity);
      qx[i] = IloNumVarArray(env,m + 1,0.0,IloInfinity);
      qy[i] = IloNumVarArray(env,m + 1,0.0,IloInfinity);

      for ( int j = 0; j <= m; j++ ) {
        const std::string ij = "_" + std::to_string(i) + "_" + std::to_string(j);
        x[i][j].setName(( "x" + ij ).c_str());
        z[i][j].setName(( "z" + ij ).c_str());
        gama[i][j].setName(( "gama" + ij ).c_str());
        y[i][j].setName(( "y" + ij ).c_str());
        qx[i][j].setName(( "qx" + ij ).c_str());
        qy[i][j].setName(( "qy" + ij ).c_str());
      }
    }

    // Coordinates of the visit point of client i (position 0 is not used)
    IloNumVarArray px(env,m + 1,-IloInfinity,IloInfinity);
    IloNumVarArray py(env,m + 1,-IloInfinity,IloInfinity);
    for ( int i = 1; i <= m; i++ ) {
      px[i].setName(( "px_" + std::to_string(i) ).c_str());
      py[i].setName(( "py_" + std::to_string(i) ).c_str());
    }

    // w[i][l] = 1 if the visit point of the nonconvex client i lies in
    // its l-th convex part (defined only if h[i] > 1)
    BoolVarMatrix w(env,m + 1);
    for ( int i = 1; i <= m; i++ ) {
      if ( h[i] > 1 ) {
        w[i] = IloBoolVarArray(env,h[i]);
        for ( int l = 0; l < h[i]; l++ ) {
          w[i][l].setName(( "w_" + std::to_string(i) + "_" + std::to_string(l + 1) ).c_str());
        }
      }
    }

    // ==================
    // Objective function
    // ==================

    // With fixed routes, the distance associated with each arc of the
    // routes is given directly by y, since all these arcs are used.
    IloExpr obj(env);
    for ( int i = 0; i <= m; i++ ) {
      for ( int j = 0; j <= m; j++ ) {
        if ( usearc[i][j] ) {
          if ( use_fixed_initial_routes ) {
            obj += y[i][j];
          } else {
            obj += gama[i][j];
          }
        }
      }
    }
    model.add(IloMinimize(env,obj));
    obj.end();

    // ===========
    // Constraints
    // ===========

    // Routing constraints (degree, load flow and capacity). They are not needed when the routes are fixed.
    if ( !use_fixed_initial_routes ) {

      // The number of arcs leaving the depot is equal to the number of arcs entering the depot
      {
        IloExpr expr(env);
        for ( int j = 1; j <= m; j++ ) {
          expr += x[0][j] - x[j][0];
        }
        model.add(expr == 0);
        expr.end();
      }

      // In-degree and out-degree constraints for each client
      for ( int i = 1; i <= m; i++ ) {
        IloExpr in(env),out(env);
        for ( int j = 0; j <= m; j++ ) {
          if ( j != i ) {
            in += x[j][i];
            out += x[i][j];
          }
        }
        model.add(in == 1);
        model.add(out == 1);
        in.end();
        out.end();
      }

      // Load flow balance constraints at each client
      for ( int k = 1; k <= m; k++ ) {
        IloExpr expr(env);
        for ( int i = 0; i <= m; i++ ) {
          if ( i != k ) expr += z[i][k] - z[k][i];
        }
        model.add(expr == inst.dem[k - 1]);
        expr.end();
      }

      // Capacity limit on each arc
      for ( int i = 0; i <= m; i++ ) {
        for ( int j = 0; j <= m; j++ ) {
          if ( i != j ) model.add(z[i][j] <= inst.maxcap * x[i][j]);
        }
      }

      // The load flow leaving the depot is equal to the total demand and no load flow enters the depot
      {
        IloExpr out(env),in(env);
        for ( int j = 1; j <= m; j++ ) {
          out += z[0][j];
          in += z[j][0];
        }
        model.add(out == totaldem);
        model.add(in == 0);
        out.end();
        in.end();
      }
    }

    // Euclidean distance constraints and linking constraints with y and gama.
    // The depot is at the origin, so its coordinates do not appear in the constraints.
    for ( int i = 0; i <= m; i++ ) {
      for ( int j = 0; j <= m; j++ ) {
        if ( !usearc[i][j] ) continue;

        // y[i][j]^2 >= ( px[i] - px[j] )^2 + ( py[i] - py[j] )^2
        IloExpr quad(env);
        if ( i != 0 ) quad += px[i] * px[i] + py[i] * py[i];
        if ( j != 0 ) quad += px[j] * px[j] + py[j] * py[j];
        if ( i != 0 && j != 0 ) quad += - 2.0 * px[i] * px[j] - 2.0 * py[i] * py[j];
        quad += - y[i][j] * y[i][j];
        model.add(quad <= 0);
        quad.end();

        if ( !use_fixed_initial_routes ) {
          model.add(gama[i][j] <= M1 * x[i][j]);
          model.add(gama[i][j] - y[i][j] - M1 * x[i][j] >= - M1);
        }

        // Additional constraints of Model (2)--(26)
        if ( use_additional_constraints ) {
          IloExpr dx(env),dy(env);
          if ( i != 0 ) {
            dx += px[i];
            dy += py[i];
          }
          if ( j != 0 ) {
            dx -= px[j];
            dy -= py[j];
          }

          model.add(dx - qx[i][j] <= 0);
          model.add(dx + qx[i][j] >= 0);

          model.add(dy - qy[i][j] <= 0);
          model.add(dy + qy[i][j] >= 0);

          dx.end();
          dy.end();

          model.add(y[i][j] - qx[i][j] >= 0);
          model.add(y[i][j] - qy[i][j] >= 0);
          model.add(y[i][j] - qx[i][j] - qy[i][j] <= 0);
        }
      }
    }

    // Smallest, largest and sum of the tight big-M constants (used if
    // use_tight_bigm is true), and number of constraints that use them
    double tightmin = IloInfinity,tightmax = 0.0,tightsum = 0.0;
    int ntight = 0;

    // Geometric constraints: the visit point of each client belongs to its polygon
    for ( int i = 1; i <= m; i++ ) {
      if ( h[i] == 1 ) {
        // Convex polygon
        const std::vector<HalfPlane> hp = partHalfPlanes(inst.U[i - 1][0],xs,ys);
        for ( const HalfPlane& e : hp ) {
          model.add(e.a * px[i] + e.b * py[i] <= - e.c);
        }

      } else {
        // Nonconvex polygon: the visit point belongs to exactly one of its convex parts
        IloExpr sum(env);
        for ( int l = 0; l < h[i]; l++ ) {
          sum += w[i][l];
        }
        model.add(sum == 1);
        sum.end();

        for ( int l = 0; l < h[i]; l++ ) {
          const std::vector<HalfPlane> hp = partHalfPlanes(inst.U[i - 1][l],xs,ys);
          for ( const HalfPlane& e : hp ) {
            // Big-M constant of the constraint
            double bigM = M2;

            if ( use_tight_bigm ) {
              // Tight value: the maximum of a x + b y + c over the polygon of client i.
	      // The visit point of client i always belongs to its polygon and, since
	      // the function is linear, the maximum is attained at one of the vertices
              // of the polygon. If the maximum is zero, the whole polygon satisfies the
	      // constraint, which is then valid whichever the convex part chosen.
              bigM = 0.0;
              for ( int j = inst.first[i - 1]; j < inst.first[i]; j++ ) {
                bigM = std::max(bigM,e.a * xs[j] + e.b * ys[j] + e.c);
              }

              tightmin = std::min(tightmin,bigM);
              tightmax = std::max(tightmax,bigM);
              tightsum += bigM;
              ntight++;
            }

            model.add(e.a * px[i] + e.b * py[i] + bigM * w[i][l] <= bigM - e.c);
          }
        }
      }
    }

    // ===============
    // Solve the model
    // ===============

    IloCplex cplex(model);

    cplex.setParam(IloCplex::Param::TimeLimit,tlim);
    cplex.setParam(IloCplex::Param::Threads,nthreads);

    // The time limit is in CPU time (1 = CPU time, 2 = wall clock time)
    cplex.setParam(IloCplex::Param::ClockType,1);

    // ================
    // Initial solution
    // ================

    // Only the values of the binary variables are given to CPLEX: x
    // (arcs of the routes) and w (convex part that contains the visit
    // point of each nonconvex client).  CPLEX computes the values of
    // the continuous variables by solving the problem with the binary
    // variables fixed.
    if ( use_initial_solution ) {
      std::vector<std::vector<int>> arc(m + 1,std::vector<int>(m + 1,0));
      std::vector<int> part(m + 1,0);

      for ( size_t r = 0; r < inisol.routes.size(); r++ ) {
        int prev = 0;
        for ( size_t j = 0; j < inisol.routes[r].size(); j++ ) {
          const int i = inisol.routes[r][j];
          arc[prev][i] = 1;
          prev = i;

          if ( h[i] > 1 ) {
            double depth;
            part[i] = convexPartOfPoint(inst,i,inisol.points[r][j].first,inisol.points[r][j].second,depth);
          }
        }
        arc[prev][0] = 1;
      }

      IloNumVarArray startvar(env);
      IloNumArray startval(env);

      for ( int i = 0; i <= m; i++ ) {
        for ( int j = 0; j <= m; j++ ) {
          if ( i != j ) {
            startvar.add(x[i][j]);
            startval.add(arc[i][j]);
          }
        }
      }

      for ( int i = 1; i <= m; i++ ) {
        if ( h[i] > 1 ) {
          for ( int l = 0; l < h[i]; l++ ) {
            startvar.add(w[i][l]);
            startval.add(l == part[i] ? 1 : 0);
          }
        }
      }

      cplex.addMIPStart(startvar,startval,IloCplex::MIPStartAuto,"initial_solution");

      startvar.end();
      startval.end();
    }

    std::cout << "=====================================" << std::endl;
    std::cout << "Problem: CVRPN" << std::endl;
    std::cout << "Model type: " << ( cplex.isMIP() ? "MI" : "" ) << ( cplex.isQC() ? "QCP" : "LP" ) << std::endl;
    if ( use_additional_constraints ) {
      std::cout << "Formulation: Model (2)--(26)" << std::endl;
    } else {
      std::cout << "Formulation: Model (2)--(20)" << std::endl;
    }
    std::cout << std::setprecision(15);
    std::cout << "scalefactor= " << scalefactor << std::endl;
    std::cout << "Instance: " << filename << std::endl;
    std::cout << "Times: CPU time (seconds)" << std::endl;
    // M1 is not used when the routes are fixed
    if ( !use_fixed_initial_routes ) {
      std::cout << "M1 = " << M1 << std::endl;
    }
    if ( !use_tight_bigm ) {
      std::cout << "M2 = " << M2 << std::endl;
    } else if ( ntight > 0 ) {
      // Tight big-M constants, one for each constraint of the convex
      // parts of the nonconvex polygons
      std::cout << "M2 (tight, one per constraint): min = " << tightmin << ", mean = " << tightsum / ntight
                << ", max = " << tightmax << " (" << ntight << " constraints)" << std::endl;
      std::cout << "M2 of the paper (not used) = " << M2 << std::endl;
    }
    if ( use_initial_solution ) {
      std::cout << "USING initial solution (warm start)" << std::endl;
    }
    if ( use_fixed_initial_routes ) {
      std::cout << "USING initial solution with FIXED routes: only optimizing visit points" << std::endl;
      std::cout << "Reduced model: only the arcs of the fixed routes (no x, no z, no routing constraints)" << std::endl;
    }
    std::cout << "=====================================" << std::endl;
    std::cout << std::endl;

    // The time reported is the CPU time of the process, as in the
    // Fortran method (routine cpu_time)
    const std::clock_t start = std::clock();
    const bool solved = cplex.solve();
    const double elapsed = (double) ( std::clock() - start ) / CLOCKS_PER_SEC;

    // A continuous problem (no binary variables) is solved without
    // branch and bound: if it is solved, the bound is the optimal value
    // and the gap is zero
    const bool hasbound = cplex.getStatus() != IloAlgorithm::Infeasible &&
      cplex.getStatus() != IloAlgorithm::InfeasibleOrUnbounded && ( cplex.isMIP() || solved );

    double bestbound = 0.0;
    double gap = 0.0;
    if ( cplex.isMIP() ) {
      if ( hasbound ) bestbound = cplex.getBestObjValue();
      if ( solved ) gap = cplex.getMIPRelativeGap();
    } else if ( solved ) {
      bestbound = cplex.getObjValue();
    }

    std::cout << std::endl;
    std::cout << "===========================================================" << std::endl;
    std::cout << std::endl;

    std::cout << std::fixed << std::setprecision(12);

    if ( solved ) {
      std::cout << "Solution found (scaled): " << cplex.getObjValue() << std::endl;
    } else {
      std::cout << "No solution found." << std::endl;
    }

    std::cout << std::endl;
    std::cout << "-------- SOLUTION STATUS --------" << std::endl;
    std::cout << "Status: " << cplex.getCplexStatus() << std::endl;
    std::cout << "Total time (s): " << elapsed << std::endl;
    if ( hasbound ) {
      std::cout << "Best bound (scaled): " << bestbound << std::endl;
    } else {
      std::cout << "Best bound (scaled): -" << std::endl;
    }
    if ( solved ) {
      std::cout << "Gap: " << gap << std::endl;
    } else {
      std::cout << "Gap: -" << std::endl;
    }

    std::cout << std::endl;
    std::cout << "===========================================================" << std::endl;
    std::cout << std::endl;

    std::cout << std::endl;
    std::cout << "********** POST-PROCESSING **********" << std::endl;
    std::cout << std::endl;
    std::cout << "All the values below are in the original scale of the instance." << std::endl;

    // Solution of the constructive heuristics that was given to CPLEX
    // as an initial solution or whose routes were fixed, in the
    // original scale
    if ( use_initial_solution || use_fixed_initial_routes ) {
      std::cout << std::endl;
      if ( use_fixed_initial_routes ) {
        std::cout << "Fixed routes: only the visit points were optimized" << std::endl;
      } else {
        std::cout << "Warm start: initial solution given to CPLEX" << std::endl;
      }
      std::cout << "Heuristic: " << inisol.heuristic << std::endl;
      if ( use_fixed_initial_routes ) {
        // Lengths of the fixed routes with the barycenters of the
	// polygons as visit points and with the visit points computed
	// by BCD starting from the barycenters
        std::cout << "Initial objective value (barycenters): " << inisol.barycenters << std::endl;
        std::cout << "BCD objective value: " << inisol.objective << std::endl;
      } else {
        std::cout << "Initial objective value: " << inisol.objective << std::endl;
      }
      std::cout << "Initial number of routes: " << inisol.routes.size() << std::endl;

      // Each fixed route, from the depot (0) through its clients in
      // the order of the visits and back to the depot
      if ( use_fixed_initial_routes ) {
        for ( size_t r = 0; r < inisol.routes.size(); r++ ) {
          std::cout << "Route " << r + 1 << ": 0";
          for ( int i : inisol.routes[r] ) {
            std::cout << " - " << i;
          }
          std::cout << " - 0" << std::endl;
        }
      }
    }

    if ( solved ) {
      // arcsol[i][j] indicates whether arc (i,j) is used in the solution
      // and arclen[i][j] is the distance associated with it (in the
      // scale of the model). With fixed routes, the arcs used are the
      // arcs of the model and the distance is given by y.
      std::vector<std::vector<char>> arcsol(m + 1,std::vector<char>(m + 1,0));
      std::vector<std::vector<double>> arclen(m + 1,std::vector<double>(m + 1,0.0));

      for ( int i = 0; i <= m; i++ ) {
        for ( int j = 0; j <= m; j++ ) {
          if ( usearc[i][j] ) {
            if ( use_fixed_initial_routes ) {
              arcsol[i][j] = 1;
              arclen[i][j] = cplex.getValue(y[i][j]);
            } else if ( cplex.getValue(x[i][j]) > 0.5 ) {
              arcsol[i][j] = 1;
              arclen[i][j] = cplex.getValue(gama[i][j]);
            }
          }
        }
      }

      // succ[i] is the successor of client i in its route
      std::vector<int> succ(m + 1,0);
      for ( int i = 1; i <= m; i++ ) {
        for ( int j = 0; j <= m; j++ ) {
          if ( arcsol[i][j] ) succ[i] = j;
        }
      }

      int nroutes = 0;
      for ( int j = 1; j <= m; j++ ) {
        if ( arcsol[0][j] ) nroutes++;
      }

      std::cout << std::endl;
      std::cout << "1. Solution data:" << std::endl;
      std::cout << std::endl;
      std::cout << "Objective value: " << scalefactor * cplex.getObjValue() << std::endl;
      std::cout << "Best bound: " << scalefactor * bestbound << std::endl;
      std::cout << "Gap_percent: " << 100.0 * gap << std::endl;
      std::cout << "Elapsed_time: " << elapsed << std::endl;
      std::cout << "Number of iterations: " << cplex.getNiterations() << std::endl;
      std::cout << "Total number of B&B nodes: " << cplex.getNnodes() << std::endl;
      std::cout << "Number of routes: " << nroutes << std::endl;

      std::cout << std::endl;
      std::cout << "2. Instance data:" << std::endl;
      std::cout << std::endl;
      std::cout << "Total number of variables: " << cplex.getNcols() << std::endl;
      std::cout << "Binary variables: " << cplex.getNbinVars() << std::endl;
      std::cout << "Integer variables: " << cplex.getNintVars() << std::endl;
      std::cout << "Continuous variables: " << cplex.getNcols() - cplex.getNbinVars() - cplex.getNintVars() << std::endl;
      std::cout << "Linear constraints: " << cplex.getNrows() << std::endl;
      std::cout << "Quadratic constraints: " << cplex.getNQCs() << std::endl;

      // For each route: its length, its total demand and, for each client in the order of the visits,
      // the visit point (in the original coordinates of the instance) and the demand
      std::cout << std::endl;
      std::cout << "3. Route(s) found:" << std::endl;
      std::cout << std::endl;
      // Routes and visit points of the solution, used to draw the figure
      std::vector<std::vector<int>> solroutes;
      std::vector<double> vx(m + 1,0.0),vy(m + 1,0.0);

      int r = 0;
      for ( int j = 1; j <= m; j++ ) {
        if ( arcsol[0][j] ) {
          r++;

          std::vector<int> route;
          double length = arclen[0][j];
          double demand = 0.0;
          int current = j;
          while ( current != 0 && (int) route.size() <= m ) {
            route.push_back(current);
            demand += inst.dem[current - 1];
            length += arclen[current][succ[current]];
            current = succ[current];
          }

          std::cout << "Route " << r << ":" << std::endl;
          std::cout << "Length:" << std::setprecision(12) << scalefactor * length << std::endl;
          std::cout << "Total demand:" << std::setprecision(1) << demand << std::endl;
          std::cout << std::setw(8) << "Client" << std::setw(20) << "px" << std::setw(20) << "py"
                    << std::setw(12) << "demand" << std::endl;
          for ( int i : route ) {
            std::cout << std::setw(8) << i
                      << std::setw(20) << std::setprecision(12) << inst.depx + scalefactor * cplex.getValue(px[i])
                      << std::setw(20) << std::setprecision(12) << inst.depy + scalefactor * cplex.getValue(py[i])
                      << std::setw(12) << std::setprecision(1) << inst.dem[i - 1] << std::endl;
            vx[i] = inst.depx + scalefactor * cplex.getValue(px[i]);
            vy[i] = inst.depy + scalefactor * cplex.getValue(py[i]);
          }
          std::cout << std::endl;

          solroutes.push_back(route);
        }
      }

      // Figure of the solution (MetaPost file). Its name is the name of
      // the instance followed by the model and the value of --start.
      if ( savefigure ) {
        std::string base = filename.substr(filename.find_last_of('/') + 1);
        if ( base.rfind('.') != std::string::npos ) base = base.substr(0,base.rfind('.'));
        const std::string figname = figdir + "/" + base + "_model" + model_option + "_" + start_option + ".mp";

        std::filesystem::create_directories(figdir);
        drawSolution(inst,solroutes,vx,vy,figname);

        std::cout << "Figure of the solution saved in: " << figname << std::endl;
        std::cout << std::endl;
      }

      std::cout << "*************** END OF POST-PROCESSING ***************" << std::endl;
      std::cout << std::endl;

    } else {
      std::cout << "The model did not find an optimal or feasible solution, or the time limit was reached." << std::endl;
    }

  } catch ( IloException& e ) {
    std::cerr << "CPLEX ERROR: " << e << std::endl;
    status = 1;
  } catch ( const std::exception& e ) {
    std::cerr << "ERROR: " << e.what() << std::endl;
    status = 1;
  }

  env.end();

  return status;
}
