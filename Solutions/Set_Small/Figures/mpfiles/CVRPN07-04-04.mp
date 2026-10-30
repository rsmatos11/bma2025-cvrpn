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
fill (0.648106u,0.830485u)--(0.518311u,0.604910u)--(0.593256u,0.452722u)--(0.736390u,0.483923u)--cycle withcolor polygonfill1;
fill (0.227123u,-0.335225u)--(0.029236u,-0.542779u)--(0.222268u,-0.604575u)--cycle withcolor polygonfill1;
fill (1.000000u,-0.521498u)--(0.595877u,-0.599689u)--(0.614966u,-0.808520u)--(0.986260u,-0.830485u)--cycle withcolor polygonfill1;
fill (-0.613306u,0.093583u)--(-1.000000u,0.134403u)--(-0.953469u,-0.080078u)--(-0.636889u,-0.117641u)--cycle withcolor polygonfill1;
draw (0.648106u,0.830485u)--(0.518311u,0.604910u)--(0.593256u,0.452722u)--(0.736390u,0.483923u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.227123u,-0.335225u)--(0.029236u,-0.542779u)--(0.222268u,-0.604575u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (1.000000u,-0.521498u)--(0.595877u,-0.599689u)--(0.614966u,-0.808520u)--(0.986260u,-0.830485u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.613306u,0.093583u)--(-1.000000u,0.134403u)--(-0.953469u,-0.080078u)--(-0.636889u,-0.117641u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.309636u,-0.118583u)--(0.595877u,-0.599689u)--(0.193044u,-0.370969u)--(-0.614016u,0.087225u)--(0.593256u,0.452722u)--(0.309636u,-0.118583u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (0.595877u,-0.599689u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.193044u,-0.370969u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.614016u,0.087225u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.593256u,0.452722u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.309636u,-0.118583u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
