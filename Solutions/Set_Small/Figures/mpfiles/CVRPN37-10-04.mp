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
fill (0.143110u,0.848285u)--(-0.024617u,0.718557u)--(0.208536u,0.720570u)--cycle withcolor polygonfill2;
fill (-0.523851u,0.886688u)--(-0.690973u,0.727436u)--(-0.558193u,0.744689u)--cycle withcolor polygonfill2;
fill (-0.066998u,0.923549u)--(-0.154927u,0.991859u)--(-0.088511u,0.786297u)--cycle withcolor polygonfill2;
fill (-0.455315u,0.368650u)--(-0.207557u,0.192695u)--(-0.238263u,0.258129u)--cycle withcolor polygonfill1;
fill (-0.775681u,-0.891755u)--(-0.910676u,-0.762913u)--(-0.876434u,-1.000000u)--(-0.820751u,-0.998350u)--cycle withcolor polygonfill1;
fill (0.738152u,-0.185299u)--(0.624034u,-0.162724u)--(0.497098u,-0.227134u)--(0.545574u,-0.362000u)--cycle withcolor polygonfill2;
fill (0.910676u,0.871877u)--(0.885960u,1.000000u)--(0.735815u,0.798960u)--(0.836344u,0.796003u)--cycle withcolor polygonfill2;
fill (-0.463126u,-0.702234u)--(-0.531033u,-0.725145u)--(-0.664576u,-0.754522u)--(-0.496136u,-0.922568u)--cycle withcolor polygonfill1;
fill (0.237304u,-0.165907u)--(0.223327u,-0.392822u)--(0.380040u,-0.338741u)--cycle withcolor polygonfill2;
fill (-0.057201u,-0.277300u)--(-0.213097u,-0.192646u)--(-0.173054u,-0.414454u)--cycle withcolor polygonfill1;
draw (0.143110u,0.848285u)--(-0.024617u,0.718557u)--(0.208536u,0.720570u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.523851u,0.886688u)--(-0.690973u,0.727436u)--(-0.558193u,0.744689u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.066998u,0.923549u)--(-0.154927u,0.991859u)--(-0.088511u,0.786297u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.455315u,0.368650u)--(-0.207557u,0.192695u)--(-0.238263u,0.258129u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.775681u,-0.891755u)--(-0.910676u,-0.762913u)--(-0.876434u,-1.000000u)--(-0.820751u,-0.998350u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.738152u,-0.185299u)--(0.624034u,-0.162724u)--(0.497098u,-0.227134u)--(0.545574u,-0.362000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.910676u,0.871877u)--(0.885960u,1.000000u)--(0.735815u,0.798960u)--(0.836344u,0.796003u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.463126u,-0.702234u)--(-0.531033u,-0.725145u)--(-0.664576u,-0.754522u)--(-0.496136u,-0.922568u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.237304u,-0.165907u)--(0.223327u,-0.392822u)--(0.380040u,-0.338741u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.057201u,-0.277300u)--(-0.213097u,-0.192646u)--(-0.173054u,-0.414454u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.053034u,0.003811u)--(-0.558193u,0.744689u)--(-0.088511u,0.786297u)--(0.066034u,0.788671u)--(0.735815u,0.798960u)--(0.497098u,-0.227134u)--(0.237304u,-0.165907u)--(-0.053034u,0.003811u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (-0.053034u,0.003811u)--(-0.211961u,-0.193263u)--(-0.664576u,-0.754522u)--(-0.816515u,-0.852783u)--(-0.207557u,0.192695u)--(-0.053034u,0.003811u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.558193u,0.744689u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.088511u,0.786297u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.066034u,0.788671u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.735815u,0.798960u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.497098u,-0.227134u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.237304u,-0.165907u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.211961u,-0.193263u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.664576u,-0.754522u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.816515u,-0.852783u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.207557u,0.192695u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.053034u,0.003811u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
