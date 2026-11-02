CODES FOR THE CVRPN (CAPACITATED VEHICLE ROUTING PROBLEM WITH NEIGHBORHOODS)
============================================================================

This folder contains the codes of the two methods used in the paper:

  - the heuristic method (Fortran): constructive heuristics, block
    coordinate descent (BCD) for the visit points and GVNS;
  - the CPLEX models (C++): the MIQCP model of the paper (option --model 20)
    and the same model with additional linear constraints based on the
    bounds max(|xi - xj|, |yi - yj|) <= distance <= |xi - xj| + |yi - yj|
    on the distance between two visit points (option --model 26). The
    values 20 and 26 refer to the numbering of the equations in the paper:
    models (2)-(20) and (2)-(26).


Files
-----

  Method (Fortran)
    master.f90                   main program
    metaheuristics.f90           GVNS
    neighborhoods.f90            neighborhoods of the local search and shake
    constructiveheuristcs.f90    constructive heuristics (CW and NN)
    blockcoordinatedescent.f90   BCD for the visit points of a route
    dijkstra.f90                 visit points restricted to the vertices of the polygons
    solution.f90                 solutions and figures of the solutions
    instance.f90                 reading of the instances
    mygeometry.f90               geometric routines (GNU LGPL v3; see
                                 LICENSE-LGPL.txt and LICENSE-GPL.txt)
    statistics.f90               counters and records of the runs
    drand.f90                    random number generator
    compilegvns.sh               compilation

  CPLEX models (C++)
    cvrpncplexmodels.cpp         models (2)-(20) and (2)-(26)
    cvrpninstance.hpp            reading of the instances and convex partition
                                 of the nonconvex polygons (CGAL)
    cvrpncplexinitsol.f90        initial solution given by the constructive
                                 heuristics of the method (it also uses the
                                 Fortran files above, except master.f90,
                                 metaheuristics.f90 and neighborhoods.f90)
    compilecplex.sh              compilation


Method (GVNS)
-------------

Compilation (requires gfortran):

    bash compilegvns.sh

Usage:

    ./cvrpngvns instance.dat otype rmax norder qmax flip randroutes tlim nrungvns

  otype       B = best improvement, F = first improvement
  rmax        maximum number of arcs or elements removed in the neighborhoods
  norder      order of the neighborhoods: 1 = 2-Opt, 3-Opt, Or-Opt, 1-0-Exchange,
              1-1-Exchange, 1-2-Exchange, Relocate, 2-Opt*, Cross-Exchange;
              2 = the same order starting from 1-0-Exchange (intra-route
              neighborhoods at the end); 3 and 4 = the orders 1 and 2,
              shuffled at random after each cycle without improvement
  qmax        number of moves of the shake
  flip        true or false: also consider the reversed segments
  randroutes  true or false: consider the routes in random order
              (first improvement only)
  tlim        CPU time limit of each run, in seconds
  nrungvns    number of independent runs (run k uses the seed k*123456)

The configuration used in the paper (selected by the calibration) is

    ./cvrpngvns instance.dat B 3 3 5 true false tlim 10

with tlim = 60 for the small-scale instances and 1200 for the other ones.

Output:
  - standard output: report of the initial solution and of each run, and
    the best solution found (routes, sequences of clients and visit points);
  - records_method/<instance>_runs.csv: one line per run (value, time to the
    best solution, number of routes, cycles, shakes and moves, BCD data);
  - records_method/<instance>_traj.csv: time and value of each improvement
    of the best solution of each run;
  - records_method/<instance>_neigh.csv: calls, improvements, gain and CPU
    time of each neighborhood in each stage of the local search;
  - figures_method/<instance>_ini_bcd.mp and <instance>_gvns.mp: figures
    (MetaPost) of the initial solution and of the best solution found. To
    obtain a PDF: mpost <file>.mp; epstopdf <file>.mps

The CPU time reported for the best solution is measured from the start of
the GVNS; it does not include the constructive heuristics.


CPLEX models
------------

Compilation (Linux; requires CPLEX, CGAL, Boost, GMP and MPFR):

    CPLEX_STUDIO_DIR=<CPLEX folder> CGAL_INC=<CGAL include folder> bash compilecplex.sh

Usage:

    ./cvrpncplexmodels instance.dat [--model 20|26] [--start none|warm|fixed]

  --model 20     the MIQCP model of the paper, models (2)-(20)
  --model 26     the same model with the additional constraints,
                 models (2)-(26)
  --start none   no initial solution
  --start warm   the best solution of the constructive heuristics CW and NN
                 is given to CPLEX as an initial solution (MIP start)
  --start fixed  the routes of that solution are fixed and only the visit
                 points are optimized

Other parameters are constants at the beginning of cvrpncplexmodels.cpp:
CPU time limit (3600 s), number of threads (1), tight big-M constants
(true) and figure of the solution (saved in figures_cplex). The results
are written to the standard output, in the original units of the instance.


Format of the instances
-----------------------

    <capacity of the vehicles>
    <number of clients n>
    <maximum number of vertices of a polygon>
    <demand of client 1>
    ...
    <demand of client n>
    1                       (depot: polygon with one vertex)
    <x> <y>                 (coordinates of the depot)
    <number of vertices of the polygon of client 1>
    <x> <y>                 (one line per vertex)
    ...
    (the same for clients 2 to n)
