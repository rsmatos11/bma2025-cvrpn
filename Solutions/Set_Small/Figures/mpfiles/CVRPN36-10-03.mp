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
fill (-0.268487u,-0.914312u)--(-0.276895u,-0.987215u)--(-0.071070u,-1.000000u)--cycle withcolor polygonfill1;
fill (-0.132472u,-0.199430u)--(-0.109182u,-0.275190u)--(-0.014961u,-0.325725u)--cycle withcolor polygonfill2;
fill (0.815381u,0.206747u)--(0.797458u,0.099986u)--(0.957215u,0.018742u)--cycle withcolor polygonfill3;
fill (-0.684706u,0.058727u)--(-0.836406u,0.092999u)--(-0.672089u,-0.130589u)--cycle withcolor polygonfill1;
fill (0.552170u,1.000000u)--(0.325457u,0.903021u)--(0.333524u,0.780473u)--cycle withcolor polygonfill3;
fill (-0.877275u,0.957451u)--(-0.957215u,0.849997u)--(-0.934647u,0.739244u)--cycle withcolor polygonfill3;
fill (0.801657u,-0.341451u)--(0.653861u,-0.391881u)--(0.780148u,-0.549933u)--cycle withcolor polygonfill3;
fill (0.178391u,0.312521u)--(0.169878u,0.237865u)--(0.352093u,0.203543u)--cycle withcolor polygonfill2;
fill (-0.261970u,-0.508747u)--(-0.322175u,-0.519584u)--(-0.376649u,-0.640062u)--cycle withcolor polygonfill1;
fill (-0.636290u,-0.220840u)--(-0.729375u,-0.220743u)--(-0.747573u,-0.412429u)--cycle withcolor polygonfill1;
draw (-0.268487u,-0.914312u)--(-0.276895u,-0.987215u)--(-0.071070u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.132472u,-0.199430u)--(-0.109182u,-0.275190u)--(-0.014961u,-0.325725u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.815381u,0.206747u)--(0.797458u,0.099986u)--(0.957215u,0.018742u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge3;
draw (-0.684706u,0.058727u)--(-0.836406u,0.092999u)--(-0.672089u,-0.130589u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.552170u,1.000000u)--(0.325457u,0.903021u)--(0.333524u,0.780473u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge3;
draw (-0.877275u,0.957451u)--(-0.957215u,0.849997u)--(-0.934647u,0.739244u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge3;
draw (0.801657u,-0.341451u)--(0.653861u,-0.391881u)--(0.780148u,-0.549933u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge3;
draw (0.178391u,0.312521u)--(0.169878u,0.237865u)--(0.352093u,0.203543u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.261970u,-0.508747u)--(-0.322175u,-0.519584u)--(-0.376649u,-0.640062u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.636290u,-0.220840u)--(-0.729375u,-0.220743u)--(-0.747573u,-0.412429u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.112446u,-0.042650u)--(-0.268487u,-0.914312u)--(-0.376649u,-0.640062u)--(-0.636290u,-0.220840u)--(-0.672089u,-0.130589u)--(-0.112446u,-0.042650u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (-0.112446u,-0.042650u)--(0.653861u,-0.391881u)--(0.797458u,0.099986u)--(0.333524u,0.780473u)--(-0.934647u,0.739244u)--(-0.112446u,-0.042650u) withpen pencircle scaled routewidth withcolor routecolor3;
draw (-0.112446u,-0.042650u)--(-0.132472u,-0.199430u)--(0.169878u,0.237865u)--(-0.112446u,-0.042650u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.268487u,-0.914312u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.376649u,-0.640062u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.636290u,-0.220840u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.672089u,-0.130589u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.653861u,-0.391881u) withpen pencircle scaled visitpointsize withcolor visitpoint3;
drawdot (0.797458u,0.099986u) withpen pencircle scaled visitpointsize withcolor visitpoint3;
drawdot (0.333524u,0.780473u) withpen pencircle scaled visitpointsize withcolor visitpoint3;
drawdot (-0.934647u,0.739244u) withpen pencircle scaled visitpointsize withcolor visitpoint3;
drawdot (-0.132472u,-0.199430u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.169878u,0.237865u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.112446u,-0.042650u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
