prologues := 3;
outputtemplate := "%j.mps";
% Sizes: edges of the polygons, routes, visit points and depot
edgewidth := 0.3pt;
routewidth := 0.5pt;
visitpointsize := 1.5pt;
depotsize := 2.5pt;
% Colors of the routes and of the depot
color routecolor[], depotcolor;
routecolor1 := (0.1647,0.4706,0.8392);
routecolor2 := (0.9216,0.4078,0.2039);
routecolor3 := (0.1059,0.6863,0.4784);
routecolor4 := (0.9294,0.6314,0.0000);
routecolor5 := (0.9098,0.4824,0.6431);
routecolor6 := (0.0000,0.5137,0.0000);
routecolor7 := (0.2902,0.2275,0.6549);
routecolor8 := (0.8902,0.2863,0.2824);
depotcolor := black;
% Tones: fraction of the color of a route in the filling of the polygons (mixed with white) and in their edges and visit points (mixed with black)
lighttone := 0.30;
darktone := 0.65;
% Colors of the filling of the polygons, of their edges and of the visit points, for each route
color polygonfill[], polygonedge[], visitpoint[];
for k = 1 upto 8:
  polygonfill[k] := lighttone[white,routecolor[k]];
  polygonedge[k] := darktone*routecolor[k];
  visitpoint[k] := darktone*routecolor[k];
endfor
beginfig(1);
u = 6.0cm;
fill (0.217742u,0.853863u)--(0.148097u,0.780810u)--(0.192479u,0.493606u)--(0.319184u,0.514524u)--cycle withcolor polygonfill1;
fill (-0.621402u,-0.435319u)--(-0.890464u,-0.326533u)--(-1.000000u,-0.476940u)--(-0.835243u,-0.729718u)--cycle withcolor polygonfill1;
fill (-0.709128u,0.900522u)--(-0.822012u,0.915910u)--(-0.971290u,0.859354u)--(-0.805572u,0.578335u)--(-0.625459u,0.724333u)--cycle withcolor polygonfill2;
fill (1.000000u,-0.658751u)--(0.818991u,-0.609583u)--(0.631280u,-0.767285u)--(0.544319u,-0.863307u)--(0.898523u,-0.915910u)--cycle withcolor polygonfill1;
draw (0.217742u,0.853863u)--(0.148097u,0.780810u)--(0.192479u,0.493606u)--(0.319184u,0.514524u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.621402u,-0.435319u)--(-0.890464u,-0.326533u)--(-1.000000u,-0.476940u)--(-0.835243u,-0.729718u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.709128u,0.900522u)--(-0.822012u,0.915910u)--(-0.971290u,0.859354u)--(-0.805572u,0.578335u)--(-0.625459u,0.724333u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (1.000000u,-0.658751u)--(0.818991u,-0.609583u)--(0.631280u,-0.767285u)--(0.544319u,-0.863307u)--(0.898523u,-0.915910u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.311731u,0.302444u)--(0.192479u,0.493606u)--(0.631280u,-0.767285u)--(-0.621402u,-0.435319u)--(-0.311731u,0.302444u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (-0.311731u,0.302444u)--(-0.642510u,0.710512u)--(-0.311731u,0.302444u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (0.192479u,0.493606u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.631280u,-0.767285u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.621402u,-0.435319u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.642510u,0.710512u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.311731u,0.302444u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
