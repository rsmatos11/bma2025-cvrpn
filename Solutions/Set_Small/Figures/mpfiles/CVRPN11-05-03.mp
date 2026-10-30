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
fill (-0.530660u,-0.707074u)--(-0.750278u,-0.662483u)--(-0.655148u,-0.973497u)--cycle withcolor polygonfill1;
fill (0.750278u,0.463014u)--(0.426664u,0.379593u)--(0.483982u,0.253051u)--cycle withcolor polygonfill1;
fill (0.101837u,0.855784u)--(-0.091941u,0.554372u)--(0.010253u,0.639515u)--cycle withcolor polygonfill1;
fill (0.502682u,-0.697162u)--(0.307091u,-0.839074u)--(0.599431u,-1.000000u)--cycle withcolor polygonfill1;
fill (0.535412u,0.982017u)--(0.362683u,1.000000u)--(0.596218u,0.890427u)--cycle withcolor polygonfill1;
draw (-0.530660u,-0.707074u)--(-0.750278u,-0.662483u)--(-0.655148u,-0.973497u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.750278u,0.463014u)--(0.426664u,0.379593u)--(0.483982u,0.253051u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.101837u,0.855784u)--(-0.091941u,0.554372u)--(0.010253u,0.639515u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.502682u,-0.697162u)--(0.307091u,-0.839074u)--(0.599431u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.535412u,0.982017u)--(0.362683u,1.000000u)--(0.596218u,0.890427u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.298508u,-0.149546u)--(0.426664u,0.379593u)--(0.420319u,0.972957u)--(0.010253u,0.639515u)--(-0.530660u,-0.707074u)--(0.307091u,-0.839074u)--(0.298508u,-0.149546u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (0.426664u,0.379593u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.420319u,0.972957u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.010253u,0.639515u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.530660u,-0.707074u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.307091u,-0.839074u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.298508u,-0.149546u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
