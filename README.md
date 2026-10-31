# CVRPN benchmark instances and solutions

Instances, solutions and source code of the Capacitated Vehicle Routing
Problem with Polygonal Neighborhoods (CVRPN), from:

> E. G. Birgin, R. S. Matos.
> *Solving the capacitated vehicle routing problem with polygonal
> neighborhoods using a metaheuristic enhanced with block coordinate descent.*
> (journal and DOI to be added)

Web page with the table of results: https://rsmatos11.github.io/bma2025-cvrpn/

## Contents

| Folder | Content |
|--------|---------|
| `Instances/` | small-, medium- and large-scale instances, and the instances used in the calibration |
| `Solutions/` | solutions found by the proposed method: `Files/` (text) and `Figures/` (PDF) of each set |
| `Codes/` | source code of the proposed method and of the CPLEX models (see [`Codes/README.txt`](Codes/README.txt)) |
| `index.html` | source of the web page: table with links to the instances and solutions |

## Instances

| Set | Instances | Clients | Type |
|-----|-----------|---------|------|
| `Set_Small` | 65 | 3 to 15 | small-scale |
| `Set_Medium` | 69 | 16 to 60 | medium-scale |
| `Set_A` | 81 | 31 to 79 | large-scale |
| `Set_B` | 69 | 30 to 77 | large-scale |
| `Set_E` | 33 | 21 to 100 | large-scale |
| `Set_F` | 9 | 44 to 134 | large-scale |
| `Set_M` | 15 | 100 to 199 | large-scale |
| `Set_P` | 72 | 15 to 100 | large-scale |
| `Set_Tai` | 39 | 75 to 385 | large-scale |
| `Set_Calibration` | 15 | 80 to 200 | calibration |

### Origin

The small- and medium-scale instances were generated as described in Section
5.2 of the paper, following the scheme of Laporte (1984). The large-scale
instances were derived from the CVRP instances of the same names in CVRPLib.
The calibration instances were generated following Uchoa et al. (2017), with 5
instances for each suffix `_a01`, `_a05` and `_a10`.

### File names

Small- and medium-scale instances are named `CVRPN<id>-<c>-<v>`, where `c` is
the number of clients and `v` is the maximum number of vertices of a polygon.
For example, `CVRPN100-38-10` has 38 clients and polygons with at most 10
vertices.

Each large-scale instance has three versions, with the same capacity, demands
and depot. The suffixes `_a01`, `_a05` and `_a10` correspond to 0.1%, 0.5% and
1.0%: the larger square of each client, inside which its polygon is generated,
has that percentage of the area of the smallest rectangle containing the depot
and the clients. In names such as `A-n32-k5`, the number after `n` counts the
depot: this instance has 31 clients.

### Instance format

```
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
```

## Solutions

The folder `Solutions/` has one solution for each small- and medium-scale
instance and for each large-scale instance with suffix `_a01`. There are no
solutions for the versions `_a05` and `_a10`, nor for the calibration
instances. The solution files of the large-scale sets have no suffix:
`Solutions/Set_A/Files/A-n32-k5.txt` is the solution of `A-n32-k5_a01`.

The MetaPost sources of the figures of the small- and medium-scale solutions
are in `Figures/mpfiles/`.

### Solution format

```
instance = CVRPN01-03-03
number of clients = 3
depot = 0.000000000000 0.000000000000
total distance = 2.827390024232
number of routes = 1

route 1
number of clients = 3
length = 2.827390024232
demand = 20
client                x                y
     2   0.360959726016  -0.149883635736
     3  -0.194297600950  -0.359778450910
     1  -0.831062116404   0.339009745041
```

The header gives the data of the whole solution, and `number of clients`
inside a route refers only to that route; the depot is not counted as a
client. The lines after `client` give the visit points in visiting order.
Each route starts and ends at the depot, and `length` includes these two
segments. Clients are numbered as in the instance file.
