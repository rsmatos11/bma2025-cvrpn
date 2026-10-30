#ifndef CVRPN_INSTANCE_HPP
#define CVRPN_INSTANCE_HPP

#include <CGAL/Exact_predicates_exact_constructions_kernel.h>
#include <CGAL/Partition_traits_2.h>
#include <CGAL/partition_2.h>
#include <CGAL/convexity_check_2.h>

#include <algorithm>
#include <cmath>
#include <cstdio>
#include <fstream>
#include <iterator>
#include <list>
#include <map>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

// =============================================================================
// Reading of CVRPN instances in the file format:
// (the same file read by the Fortran method)
//   -----------------------------------------
//   <maxcap>                                 (Vehicle capacity)
//   <nclients>                               (Number of clients)
//   <npmax>                                  (Max vertices per polygon)
//   <dem_1> ... <dem_nclients>               (Client demands - one per line)
//   -----------------------------------------
//   For each entity k = 0 to nclients:
//     - k = 0 (Depot):
//         <np(0) = 1>                        (Vertex count = 1)
//         <x_depot>  <y_depot>               (Depot coordinates)
//     - k = 1..nclients (Clients):
//         <np(k)>                            (Vertex count for client k)
//         <x_1>      <y_1>                   (Vertex coordinates)
//         <x_2>      <y_2>
//           ...
//         <x_np>     <y_np>
//   -----------------------------------------
// and decomposition of the nonconvex polygons into convex parts using CGAL.
//
// The decomposition is the optimal convex partition (minimum number of convex parts)
// computed by CGAL::optimal_convex_partition_2 with an exact kernel.
// A polygon that is already convex is kept as a single part.
// =============================================================================

struct Instance {
  int m = 0;          // number of clients (polygons)
  int npmax = 0;      // maximum number of vertices per client
  int n = 0;          // total number of vertices of all clients
  double maxcap = 0;  // vehicle capacity
  double depx = 0;    // depot coordinates
  double depy = 0;

  // dem[i] is the demand of client i+1, for i = 0,...,m-1
  std::vector<double> dem;

  // The vertices of all clients are numbered from 0 to n-1, in the
  // order they appear in the file. The vertices of client i+1 are
  // first[i],...,first[i+1]-1, in counterclockwise order.
  std::vector<int> first;
  std::vector<double> xp,yp;

  // U[i][k] contains the vertices (in increasing order, which is also
  // counterclockwise order) of the k-th convex part of client i+1.
  // U[i].size() is the number of convex parts of client i+1.
  std::vector<std::vector<std::vector<int>>> U;
};

// *****************************************************************
// *****************************************************************

inline Instance readInstance(const std::string& filename)
{
  std::ifstream file(filename);
  if ( !file ) {
    throw std::runtime_error("Cannot open instance file " + filename);
  }

  Instance inst;

  file >> inst.maxcap >> inst.m >> inst.npmax;
  if ( !file || inst.m <= 0 || inst.npmax <= 0 ) {
    throw std::runtime_error("Error reading the header of " + filename);
  }

  inst.dem.resize(inst.m);
  for ( int i = 0; i < inst.m; i++ ) {
    file >> inst.dem[i];
  }

  // Depot: by definition it has a single point
  int np;
  file >> np;
  if ( !file || np != 1 ) {
    throw std::runtime_error("The depot must have exactly one point in " + filename);
  }
  file >> inst.depx >> inst.depy;

  inst.first.assign(inst.m + 1,0);
  for ( int i = 0; i < inst.m; i++ ) {
    file >> np;
    if ( !file || np < 3 || np > inst.npmax ) {
      throw std::runtime_error("Invalid number of points for client " + std::to_string(i + 1) + " in " + filename);
    }

    inst.first[i] = inst.n;
    for ( int j = 0; j < np; j++ ) {
      double x,y;
      file >> x >> y;
      inst.xp.push_back(x);
      inst.yp.push_back(y);
    }
    inst.n += np;
  }
  inst.first[inst.m] = inst.n;

  if ( !file ) {
    throw std::runtime_error("Unexpected end of file in " + filename);
  }

  std::string rest;
  if ( file >> rest ) {
    throw std::runtime_error("Unexpected data at the end of " + filename);
  }

  return inst;
}

// *****************************************************************
// *****************************************************************

// Computes the convex parts of the polygon with vertices (x[j],y[j]), j = 0,...,np-1, given in counterclockwise order.
// Each part is returned as the list of indices (between 0 and np-1) of its vertices in increasing order.

inline std::vector<std::vector<int>> convexParts(int np,const double* x,const double* y)
{
  typedef CGAL::Exact_predicates_exact_constructions_kernel Kernel;
  typedef CGAL::Partition_traits_2<Kernel> Traits;
  typedef Traits::Point_2 Point_2;
  typedef Traits::Polygon_2 Polygon_2;

  Polygon_2 polygon;
  std::map<std::pair<double,double>,int> index;
  for ( int j = 0; j < np; j++ ) {
    polygon.push_back(Point_2(x[j],y[j]));
    if ( !index.insert({{x[j],y[j]},j}).second ) {
      throw std::runtime_error("Polygon with repeated vertices");
    }
  }

  if ( !polygon.is_simple() ) {
    throw std::runtime_error("Polygon is not simple");
  }

  if ( polygon.orientation() != CGAL::COUNTERCLOCKWISE ) {
    throw std::runtime_error("Polygon vertices are not in counterclockwise order");
  }

  std::vector<std::vector<int>> parts;

  // A convex polygon is kept as a single part
  if ( CGAL::is_convex_2(polygon.vertices_begin(),polygon.vertices_end(),Kernel()) ) {
    std::vector<int> all(np);
    for ( int j = 0; j < np; j++ ) all[j] = j;
    parts.push_back(all);
    return parts;
  }

  std::list<Polygon_2> cgalparts;
  CGAL::optimal_convex_partition_2(polygon.vertices_begin(),polygon.vertices_end(),
                                   std::back_inserter(cgalparts),Traits());

  for ( const Polygon_2& part : cgalparts ) {
    std::vector<int> ind;
    for ( auto it = part.vertices_begin(); it != part.vertices_end(); ++it ) {
      auto pos = index.find({CGAL::to_double(it->x()),CGAL::to_double(it->y())});
      if ( pos == index.end() ) {
        throw std::runtime_error("Convex part with a vertex that is not a vertex of the polygon");
      }
      ind.push_back(pos->second);
    }
    std::sort(ind.begin(),ind.end());
    parts.push_back(ind);
  }

  return parts;
}

// *****************************************************************
// *****************************************************************

// Area of the polygon whose vertices are ind[0],ind[1],... (positive if they are in counterclockwise order)

inline double polygonArea(const std::vector<int>& ind,const std::vector<double>& xp,const std::vector<double>& yp)
{
  double area = 0.0;
  const int nv = (int) ind.size();
  for ( int j = 0; j < nv; j++ ) {
    const int a = ind[j];
    const int b = ind[( j + 1 ) % nv];
    area += xp[a] * yp[b] - xp[b] * yp[a];
  }
  return 0.5 * area;
}

// *****************************************************************
// *****************************************************************

// Computes the convex parts of all clients, filling inst.U

inline void convexPartition(Instance& inst)
{
  inst.U.assign(inst.m,std::vector<std::vector<int>>());

  for ( int i = 0; i < inst.m; i++ ) {
    const int ini = inst.first[i];
    const int np = inst.first[i + 1] - ini;

    try {
      inst.U[i] = convexParts(np,&inst.xp[ini],&inst.yp[ini]);
    } catch ( const std::exception& e ) {
      throw std::runtime_error("Client " + std::to_string(i + 1) + ": " + e.what());
    }

    // Local indices -> global indices
    for ( std::vector<int>& part : inst.U[i] ) {
      for ( int& j : part ) j += ini;
    }

    // Consistency check: every part has positive area, every vertex belongs
    // to some part, and the areas of the parts add up to the area of the polygon.
    std::vector<int> all(np);
    for ( int j = 0; j < np; j++ ) all[j] = ini + j;
    const double total = polygonArea(all,inst.xp,inst.yp);

    double sum = 0.0;
    std::vector<bool> used(np,false);
    for ( const std::vector<int>& part : inst.U[i] ) {
      const double area = polygonArea(part,inst.xp,inst.yp);
      if ( part.size() < 3 || !( area > 0.0 ) ) {
        throw std::runtime_error("Client " + std::to_string(i + 1) + ": degenerate convex part");
      }
      sum += area;
      for ( int j : part ) used[j - ini] = true;
    }

    if ( std::find(used.begin(),used.end(),false) != used.end() ||
         std::fabs( sum - total ) > 1.0e-9 * std::fabs( total ) ) {
      throw std::runtime_error("Client " + std::to_string(i + 1) + ": inconsistent convex partition");
    }
  }
}

// *****************************************************************
// *****************************************************************

// Translates the vertices so that the depot is at the origin and
// divides them by scalefactor, the largest absolute value of a
// translated coordinate. After that, all the polygons are contained
// in the square [-1,1]^2. If the translated polygons are already
// contained in the square [-1,1]^2, scalefactor is set to 1, i.e.,
// the coordinates are not scaled (dividing by 1 does not change a
// floating-point number). Original coordinates are recovered as
// depx + scalefactor * xs[j] and depy + scalefactor * ys[j], and
// original distances as scalefactor times the scaled distances.

inline void scaleVertices(const Instance& inst,double& scalefactor,std::vector<double>& xs,std::vector<double>& ys)
{
  scalefactor = 0.0;
  for ( int j = 0; j < inst.n; j++ ) {
    scalefactor = std::max(scalefactor,std::fabs( inst.xp[j] - inst.depx ));
    scalefactor = std::max(scalefactor,std::fabs( inst.yp[j] - inst.depy ));
  }

  if ( !( scalefactor > 0.0 ) ) {
    throw std::runtime_error("All the vertices coincide with the depot");
  }

  // The polygons are already contained in the square [-1,1]^2
  if ( scalefactor <= 1.0 ) scalefactor = 1.0;

  xs.resize(inst.n);
  ys.resize(inst.n);
  for ( int j = 0; j < inst.n; j++ ) {
    xs[j] = ( inst.xp[j] - inst.depx ) / scalefactor;
    ys[j] = ( inst.yp[j] - inst.depy ) / scalefactor;
  }
}

// *****************************************************************
// *****************************************************************

// Half-plane a x + b y + c <= 0

struct HalfPlane {
  double a,b,c;
};

// Returns the half-planes whose intersection is the convex polygon with vertices (xs[j],ys[j]), j in part,
// given in counterclockwise order. There is one half-plane per edge and its coefficients are
// normalized so that |a| + |b| + |c| = 1.

inline std::vector<HalfPlane> partHalfPlanes(const std::vector<int>& part,const std::vector<double>& xs,
                                             const std::vector<double>& ys)
{
  std::vector<HalfPlane> hp;
  const int nv = (int) part.size();

  for ( int e = 0; e < nv; e++ ) {
    const int j = part[e];
    const int jnext = part[( e + 1 ) % nv];

    HalfPlane h;
    h.a = ys[jnext] - ys[j];
    h.b = xs[j] - xs[jnext];
    h.c = ys[j] * xs[jnext] - xs[j] * ys[jnext];

    const double norm = std::fabs( h.a ) + std::fabs( h.b ) + std::fabs( h.c );
    if ( norm > 0.0 ) {
      h.a /= norm;
      h.b /= norm;
      h.c /= norm;
    }

    hp.push_back(h);
  }

  return hp;
}

// *****************************************************************
// *****************************************************************

// Initial solution computed by the constructive heuristics of the
// method (Fortran code), in the original coordinates of the instance

struct InitialSolution {
  std::string heuristic;    // "CW" or "NN"
  double objective = 0;     // sum of the lengths of the routes
  double barycenters = 0;   // the same, with the barycenters of the
                            // polygons as visit points (the visit
                            // points are computed by BCD starting
                            // from the barycenters)

  // routes[r] is the list of clients (between 1 and m) of route r, in the order
  // they are visited, and points[r][j] is the visit point of client routes[r][j]
  std::vector<std::vector<int>> routes;
  std::vector<std::vector<std::pair<double,double>>> points;
};

// Routine of module cvrpncplexinitsol (cvrpncplexinitsol.f90). It reads the instance
// file by itself, with the routine used by the Fortran method.

extern "C" void cvrpn_initial_solution(const char* filename,int nclients,int* heur,double* fbest,double* fbar,
                                       int* nroutes,int* rnc,int* route,double* pathcoo);

// Returns the best solution between the ones computed by the Clarke
// and Wright (CW) and the Nearest Neighbor (NN) heuristics, with the
// visit points computed by BCD, exactly as in master.f90. Instance
// inst must have been read from file filename.

inline InitialSolution initialSolution(const Instance& inst,const std::string& filename)
{
  const int m = inst.m;

  // Maximum length of a file name in the Fortran code
  if ( filename.size() > 256 ) {
    throw std::runtime_error("The name of the instance file is too long (more than 256 characters)");
  }

  int heur,nroutes;
  double fbest,fbar;
  std::vector<int> rnc(m),route(m);
  std::vector<double> pathcoo(2 * (size_t) m);

  cvrpn_initial_solution(filename.c_str(),m,&heur,&fbest,&fbar,&nroutes,rnc.data(),route.data(),pathcoo.data());

  InitialSolution sol;
  sol.heuristic = ( heur == 1 ? "CW" : "NN" );
  sol.objective = fbest;
  sol.barycenters = fbar;

  int pos = 0;
  for ( int r = 0; r < nroutes; r++ ) {
    std::vector<int> clients;
    std::vector<std::pair<double,double>> points;
    for ( int j = 0; j < rnc[r]; j++ ) {
      clients.push_back(route[pos]);
      points.push_back({pathcoo[2 * pos],pathcoo[2 * pos + 1]});
      pos++;
    }
    sol.routes.push_back(clients);
    sol.points.push_back(points);
  }

  return sol;
}

// *****************************************************************
// *****************************************************************

// Returns the index (between 0 and U[i-1].size()-1) of the convex
// part of client i that contains the point (x,y), given in the
// original coordinates of the instance. Visit points usually lie on
// the boundary of the polygon and, for this reason, the part returned
// is the one in which the point is deepest, i.e. the one that
// maximizes the smallest signed distance from the point to the lines
// that contain the edges of the part (positive distances correspond
// to the interior side). This smallest distance is returned in depth;
// it is negative if, due to rounding, the point is outside all parts.

inline int convexPartOfPoint(const Instance& inst,int i,double x,double y,double& depth)
{
  int best = 0;
  depth = - HUGE_VAL;

  for ( size_t l = 0; l < inst.U[i - 1].size(); l++ ) {
    const std::vector<int>& part = inst.U[i - 1][l];
    const int nv = (int) part.size();

    double mindist = HUGE_VAL;
    for ( int e = 0; e < nv; e++ ) {
      const int j = part[e];
      const int jnext = part[( e + 1 ) % nv];
      const double dx = inst.xp[jnext] - inst.xp[j];
      const double dy = inst.yp[jnext] - inst.yp[j];
      const double dist = ( dx * ( y - inst.yp[j] ) - dy * ( x - inst.xp[j] ) ) / std::sqrt( dx * dx + dy * dy );
      mindist = std::min(mindist,dist);
    }

    if ( mindist > depth ) {
      depth = mindist;
      best = (int) l;
    }
  }

  return best;
}

// *****************************************************************
// *****************************************************************

// Writes a MetaPost file with a figure of a solution. routes[r] is the
// sequence of clients of the r-th route and (vx[i],vy[i]) is the visit
// point of client i, for i = 1,...,m, in the original coordinates of
// the instance.
//
// Each route has a color. The polygons of the clients of a route are
// filled with a light tone of the color of the route, and their
// contours and their visit points are drawn with a dark tone of it.
// The depot is drawn in black. The routes are sorted by the angle,
// around the depot, of the barycenter of their visit points, and the
// colors are assigned cyclically in that order, so that routes with
// the same color are not neighbors.
//
// The figure is centered and scaled to fit in a square of side 12cm.
// Each polygon and each route is written in a single line of the
// file. The sizes and the colors are defined at the beginning of the
// file, so they can be changed there. The figure is obtained with:
// mpost file.mp

inline void drawSolution(const Instance& inst,const std::vector<std::vector<int>>& routes,const std::vector<double>& vx,
                         const std::vector<double>& vy,const std::string& filename)
{
  // Colors of the routes (red, green and blue components, from 0 to 255)
  const int ncolors = 8;
  const double palette[ncolors][3] = { {  42, 120, 214 }, { 235, 104,  52 }, {  27, 175, 122 }, { 237, 161,   0 },
                                       { 232, 123, 164 }, {   0, 131,   0 }, {  74,  58, 167 }, { 227,  73,  72 } };

  // Tones of the color of a route: fraction of the color mixed with white (filling of the polygons)
  // and with black (contours of the polygons and visit points)
  const double lighttone = 0.30;
  const double darktone = 0.65;

  const int nr = (int) routes.size();

  // order[0],order[1],... are the routes sorted by the angle of the barycenter of their visit points around the depot
  std::vector<double> angle(nr,0.0);
  std::vector<int> order(nr);
  for ( int r = 0; r < nr; r++ ) {
    double bx = 0.0,by = 0.0;
    for ( int i : routes[r] ) {
      bx += vx[i];
      by += vy[i];
    }
    if ( !routes[r].empty() ) {
      angle[r] = std::atan2(by / routes[r].size() - inst.depy,bx / routes[r].size() - inst.depx);
    }
    order[r] = r;
  }
  std::sort(order.begin(),order.end(),[&angle](int a,int b) { return angle[a] < angle[b]; });

  // color[r] is the color of route r. If the last route in the order would have the same color
  // of the first one, which is its neighbor, it takes another color.
  std::vector<int> color(nr,0);
  for ( int pos = 0; pos < nr; pos++ ) {
    color[order[pos]] = pos % ncolors;
  }
  if ( nr > ncolors && nr % ncolors == 1 ) {
    color[order[nr - 1]] = ncolors / 2;
  }

  // routeof[i] is the route of client i
  std::vector<int> routeof(inst.m + 1,-1);
  for ( int r = 0; r < nr; r++ ) {
    for ( int i : routes[r] ) routeof[i] = r;
  }

  // Center and half of the side of the smallest square that contains the depot and all the polygons
  double xmin = inst.depx,xmax = inst.depx,ymin = inst.depy,ymax = inst.depy;
  for ( int j = 0; j < inst.n; j++ ) {
    xmin = std::min(xmin,inst.xp[j]);
    xmax = std::max(xmax,inst.xp[j]);
    ymin = std::min(ymin,inst.yp[j]);
    ymax = std::max(ymax,inst.yp[j]);
  }
  const double cx = 0.5 * ( xmin + xmax );
  const double cy = 0.5 * ( ymin + ymax );
  double half = 0.5 * std::max(xmax - xmin,ymax - ymin);
  if ( !( half > 0.0 ) ) half = 1.0;

  // Point (x,y) in the units of the figure
  auto pt = [cx,cy,half](double x,double y) {
    char buffer[80];
    std::snprintf(buffer,sizeof(buffer),"(%.6fu,%.6fu)",( x - cx ) / half,( y - cy ) / half);
    return std::string(buffer);
  };

  // Number, in the MetaPost file, of color c
  auto num = [](int c) {
    return std::to_string(c + 1);
  };

  // Closed path with the vertices of the polygon of client i
  auto polygon = [&inst,&pt](int i) {
    std::string path;
    for ( int j = inst.first[i - 1]; j < inst.first[i]; j++ ) {
      path += pt(inst.xp[j],inst.yp[j]) + "--";
    }
    return path + "cycle";
  };

  std::ofstream file(filename);
  if ( !file ) {
    throw std::runtime_error("Cannot create figure file " + filename);
  }

  file << "prologues := 3;\n";
  file << "outputtemplate := \"%j.mps\";\n";

  // The sizes and the colors are defined at the beginning of the file,
  // so they can be changed there
  file << "% Sizes: edges of the polygons, routes, visit points and depot\n";
  file << "edgewidth := 0.3pt;\n";
  file << "routewidth := 0.5pt;\n";
  file << "visitpointsize := 1.5pt;\n";
  file << "depotsize := 2.5pt;\n";

  file << "% Colors of the routes and of the depot\n";
  file << "color routecolor[], depotcolor;\n";
  for ( int c = 0; c < ncolors; c++ ) {
    char buffer[80];
    std::snprintf(buffer,sizeof(buffer)," := (%.4f,%.4f,%.4f);\n",palette[c][0] / 255.0,palette[c][1] / 255.0,
                  palette[c][2] / 255.0);
    file << "routecolor" << num(c) << buffer;
  }
  file << "depotcolor := black;\n";

  {
    char buffer[80];
    file << "% Tones: fraction of the color of a route in the filling of the polygons (mixed "
         << "with white) and in their edges and visit points (mixed with black)\n";
    std::snprintf(buffer,sizeof(buffer),"lighttone := %.2f;\ndarktone := %.2f;\n",lighttone,darktone);
    file << buffer;
  }

  // The colors of the filling of the polygons, of their edges and of
  // the visit points are tones of the color of the route, but each of
  // them can be replaced by any other color in the file
  file << "% Colors of the filling of the polygons, of their edges and of the visit points, for each route\n";
  file << "color polygonfill[], polygonedge[], visitpoint[];\n";
  file << "for k = 1 upto " << ncolors << ":\n";
  file << "  polygonfill[k] := lighttone[white,routecolor[k]];\n";
  file << "  polygonedge[k] := darktone*routecolor[k];\n";
  file << "  visitpoint[k] := darktone*routecolor[k];\n";
  file << "endfor\n";

  file << "beginfig(1);\n";
  file << "u = 6.0cm;\n";

  // Polygons filled with a light tone of the color of their route
  for ( int i = 1; i <= inst.m; i++ ) {
    if ( routeof[i] >= 0 ) {
      file << "fill " << polygon(i) << " withcolor polygonfill" << num(color[routeof[i]]) << ";\n";
    }
  }

  // Edges of the polygons, with a dark tone of the color of their route
  for ( int i = 1; i <= inst.m; i++ ) {
    file << "draw " << polygon(i) << " withpen pencircle scaled edgewidth withcolor "
         << ( routeof[i] >= 0 ? "polygonedge" + num(color[routeof[i]]) : std::string("black") ) << ";\n";
  }

  // Routes
  for ( int r = 0; r < nr; r++ ) {
    file << "draw " << pt(inst.depx,inst.depy) << "--";
    for ( int i : routes[r] ) {
      file << pt(vx[i],vy[i]) << "--";
    }
    file << pt(inst.depx,inst.depy) << " withpen pencircle scaled routewidth withcolor routecolor" << num(color[r]) << ";\n";
  }

  // Visit points, with a dark tone of the color of their route
  for ( int r = 0; r < nr; r++ ) {
    for ( int i : routes[r] ) {
      file << "drawdot " << pt(vx[i],vy[i]) << " withpen pencircle scaled visitpointsize withcolor visitpoint" << num(color[r]) << ";\n";
    }
  }

  // Depot
  file << "drawdot " << pt(inst.depx,inst.depy) << " withpen pencircle scaled depotsize withcolor depotcolor;\n";

  // White margin around the figure
  file << "mrg := 0.1cm;\n";
  file << "setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--"
       << "(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;\n";

  file << "endfig;\n";
  file << "end;\n";
}

#endif
