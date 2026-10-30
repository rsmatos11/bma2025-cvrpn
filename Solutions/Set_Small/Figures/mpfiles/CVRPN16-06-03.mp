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
fill (0.287059u,-0.295442u)--(0.060007u,-0.288086u)--(0.207398u,-0.317558u)--cycle withcolor polygonfill1;
fill (0.580356u,0.727031u)--(0.509400u,0.676283u)--(0.562581u,0.523011u)--cycle withcolor polygonfill1;
fill (1.000000u,-0.662015u)--(0.793505u,-0.621630u)--(0.785509u,-0.727031u)--cycle withcolor polygonfill1;
fill (-0.378068u,0.610718u)--(-0.446419u,0.655146u)--(-0.626305u,0.443855u)--cycle withcolor polygonfill1;
fill (-0.904688u,0.257687u)--(-1.000000u,0.191064u)--(-0.805675u,-0.038845u)--cycle withcolor polygonfill1;
fill (-0.078089u,0.276671u)--(-0.166316u,0.328900u)--(-0.013656u,0.212897u)--cycle withcolor polygonfill1;
draw (0.287059u,-0.295442u)--(0.060007u,-0.288086u)--(0.207398u,-0.317558u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.580356u,0.727031u)--(0.509400u,0.676283u)--(0.562581u,0.523011u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (1.000000u,-0.662015u)--(0.793505u,-0.621630u)--(0.785509u,-0.727031u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.378068u,0.610718u)--(-0.446419u,0.655146u)--(-0.626305u,0.443855u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.904688u,0.257687u)--(-1.000000u,0.191064u)--(-0.805675u,-0.038845u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.078089u,0.276671u)--(-0.166316u,0.328900u)--(-0.013656u,0.212897u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.092514u,0.094024u)--(-0.885661u,0.200704u)--(-0.626305u,0.443855u)--(-0.166316u,0.328900u)--(0.562581u,0.523011u)--(0.793505u,-0.621630u)--(0.287059u,-0.295442u)--(0.092514u,0.094024u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.885661u,0.200704u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.626305u,0.443855u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.166316u,0.328900u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.562581u,0.523011u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.793505u,-0.621630u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.287059u,-0.295442u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.092514u,0.094024u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
