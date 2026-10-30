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
fill (-0.190385u,0.033685u)--(-0.597085u,0.197970u)--(-0.618844u,-0.170385u)--(-0.613765u,-0.345354u)--(-0.224648u,-0.331543u)--(-0.247505u,-0.235314u)--cycle withcolor polygonfill1;
fill (0.188299u,-0.589383u)--(-0.123678u,-0.468711u)--(-0.304375u,-0.564749u)--(-0.070822u,-1.000000u)--(0.062837u,-0.950803u)--(0.223973u,-0.936865u)--cycle withcolor polygonfill1;
fill (0.500668u,0.993915u)--(0.241609u,1.000000u)--(0.144980u,0.784936u)--(0.402537u,0.565921u)--(0.618844u,0.460598u)--(0.572329u,0.670831u)--cycle withcolor polygonfill1;
draw (-0.190385u,0.033685u)--(-0.597085u,0.197970u)--(-0.618844u,-0.170385u)--(-0.613765u,-0.345354u)--(-0.224648u,-0.331543u)--(-0.247505u,-0.235314u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.188299u,-0.589383u)--(-0.123678u,-0.468711u)--(-0.304375u,-0.564749u)--(-0.070822u,-1.000000u)--(0.062837u,-0.950803u)--(0.223973u,-0.936865u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.500668u,0.993915u)--(0.241609u,1.000000u)--(0.144980u,0.784936u)--(0.402537u,0.565921u)--(0.618844u,0.460598u)--(0.572329u,0.670831u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.118541u,0.332707u)--(-0.190385u,0.033685u)--(-0.123678u,-0.468711u)--(0.338214u,0.620619u)--(-0.118541u,0.332707u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.190385u,0.033685u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.123678u,-0.468711u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.338214u,0.620619u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.118541u,0.332707u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
