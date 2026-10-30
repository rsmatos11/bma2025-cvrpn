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
fill (0.907813u,0.828390u)--(0.603660u,0.764077u)--(0.804954u,0.711240u)--cycle withcolor polygonfill2;
fill (0.977262u,-0.135897u)--(0.930788u,-0.183154u)--(0.834728u,-0.131876u)--(0.712122u,-0.455123u)--(0.919491u,-0.463051u)--cycle withcolor polygonfill1;
fill (0.059557u,1.000000u)--(-0.045158u,0.883412u)--(-0.070131u,0.740071u)--(0.094773u,0.731854u)--(0.222356u,0.695949u)--(0.199907u,0.807901u)--cycle withcolor polygonfill2;
fill (-0.721908u,-0.730599u)--(-0.841204u,-0.701312u)--(-0.977262u,-1.000000u)--(-0.783807u,-0.977186u)--(-0.728245u,-0.928048u)--(-0.706124u,-0.873743u)--cycle withcolor polygonfill1;
fill (0.902264u,-0.837773u)--(0.651226u,-0.852378u)--(0.891925u,-0.948465u)--cycle withcolor polygonfill1;
fill (-0.183913u,-0.800868u)--(-0.235712u,-0.698604u)--(-0.366035u,-0.648771u)--(-0.379105u,-0.967833u)--(-0.150862u,-0.974452u)--cycle withcolor polygonfill1;
draw (0.907813u,0.828390u)--(0.603660u,0.764077u)--(0.804954u,0.711240u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.977262u,-0.135897u)--(0.930788u,-0.183154u)--(0.834728u,-0.131876u)--(0.712122u,-0.455123u)--(0.919491u,-0.463051u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.059557u,1.000000u)--(-0.045158u,0.883412u)--(-0.070131u,0.740071u)--(0.094773u,0.731854u)--(0.222356u,0.695949u)--(0.199907u,0.807901u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.721908u,-0.730599u)--(-0.841204u,-0.701312u)--(-0.977262u,-1.000000u)--(-0.783807u,-0.977186u)--(-0.728245u,-0.928048u)--(-0.706124u,-0.873743u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.902264u,-0.837773u)--(0.651226u,-0.852378u)--(0.891925u,-0.948465u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.183913u,-0.800868u)--(-0.235712u,-0.698604u)--(-0.366035u,-0.648771u)--(-0.379105u,-0.967833u)--(-0.150862u,-0.974452u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.018303u,0.066514u)--(0.222356u,0.695949u)--(0.603660u,0.764077u)--(0.018303u,0.066514u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (0.018303u,0.066514u)--(-0.721908u,-0.730599u)--(-0.195876u,-0.777251u)--(0.651226u,-0.852378u)--(0.712122u,-0.455123u)--(0.018303u,0.066514u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (0.222356u,0.695949u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.603660u,0.764077u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.721908u,-0.730599u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.195876u,-0.777251u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.651226u,-0.852378u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.712122u,-0.455123u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.018303u,0.066514u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
