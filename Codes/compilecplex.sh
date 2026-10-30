#!/bin/bash

# ============================================================
# Script: compilecplex.sh
# Description:
#   Compiles the CPLEX model for the CVRPN (cvrpncplexmodels.cpp),
#   together with the Fortran code that computes the initial
#   solution (constructive heuristics of the method), and creates
#   the executable. It does not run any instance.
#
# Requirements for the compilation:
#   CPLEX_STUDIO_DIR  folder of CPLEX Studio (e.g. /opt/ibm/ILOG/CPLEX_Studio2212)
#   CGAL_INC          include folder of CGAL (default: $HOME/CGAL-6.0.1/include)
#
# Usage: bash compilecplex.sh
#
# After that, to run one instance:
#   ./cvrpncplexmodels instance.dat [--model 20|26] [--start none|warm|fixed]
# ============================================================

# ============================
# Executable name
# ============================
EXEC="cvrpncplexmodels"

CGAL_INC="${CGAL_INC:-$HOME/CGAL-6.0.1/include}"

if [ -z "$CPLEX_STUDIO_DIR" ]; then
    echo "[ERROR] CPLEX_STUDIO_DIR is not set."
    exit 1
fi

if [ ! -f "$CGAL_INC/CGAL/partition_2.h" ]; then
    echo "[ERROR] CGAL not found in $CGAL_INC (set CGAL_INC)."
    exit 1
fi

OUTDIR="files_compile_cplex"    # Folder to store object (.o) and module (.mod) files

# Clean previous compilation files
rm -f "$OUTDIR"/*.o "$OUTDIR"/*.mod
mkdir -p "$OUTDIR"

# Fortran code (initial solution): compile each module separately, in
# the order of their dependencies. The '|| exit 1' ensures the script
# stops if compilation fails.
for module in drand mygeometry statistics instance solution dijkstra \
              blockcoordinatedescent constructiveheuristcs cvrpncplexinitsol; do
    gfortran -c -O3 -J"$OUTDIR" -o "$OUTDIR"/$module.o $module.f90 || exit 1
done

# C++ code (CPLEX model) and linking of all object files to create
# the executable
g++ -std=c++17 -O3 -DIL_STD cvrpncplexmodels.cpp "$OUTDIR"/*.o -o "$EXEC" \
    -I"$CGAL_INC" \
    -I"$CPLEX_STUDIO_DIR/cplex/include" \
    -I"$CPLEX_STUDIO_DIR/concert/include" \
    -L"$CPLEX_STUDIO_DIR/cplex/lib/x86-64_linux/static_pic" \
    -L"$CPLEX_STUDIO_DIR/concert/lib/x86-64_linux/static_pic" \
    -lilocplex \
    -lconcert \
    -lcplex \
    -lgfortran \
    -lmpfr \
    -lgmp \
    -lm \
    -lpthread \
    -ldl || exit 1

echo "Compilation completed successfully! Executable: ./$EXEC"
