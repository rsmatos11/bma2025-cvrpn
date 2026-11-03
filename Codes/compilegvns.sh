#!/bin/bash

# ============================================================
# Script: compilegvns.sh
# Description:
#   Compiles the Fortran code of the method (constructive
#   heuristics, BCD and GVNS) and creates the executable. It does
#   not run any instance.
#
# Requirements for the compilation:
#   gfortran
#
# Usage: bash compilegvns.sh
#
# After that, to run one instance:
#   ./cvrpngvns instance.dat otype rmax norder qmax flip randroutes tlim nrungvns
# ============================================================

# ============================
# Executable name
# ============================
EXEC="cvrpngvns"

# Compile all the Fortran files with a single command and create the
# executable. The files must be given in the order of the dependencies
# between the modules. If the compilation fails, the script stops.
gfortran -O3 drand.f90 mygeometry.f90 statistics.f90 instance.f90 solution.f90 dijkstra.f90 \
         blockcoordinatedescent.f90 constructiveheuristics.f90 neighborhoods.f90 metaheuristics.f90 \
         master.f90 -o "$EXEC" || { rm -f *.mod; exit 1; }

# Remove the module files (.mod) created by the compilation
rm -f *.mod
