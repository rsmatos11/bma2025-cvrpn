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
fill (0.800642u,-0.054121u)--(0.608665u,-0.003912u)--(0.735661u,-0.426631u)--(1.000000u,-0.357631u)--(0.940360u,-0.284433u)--cycle withcolor polygonfill1;
fill (-0.688839u,-0.462200u)--(-0.902041u,-0.310612u)--(-0.926948u,-0.659170u)--(-0.955076u,-0.770875u)--cycle withcolor polygonfill1;
fill (-0.602421u,0.102993u)--(-0.780730u,0.175352u)--(-0.915917u,0.004110u)--(-0.716103u,-0.199406u)--(-0.594161u,-0.020605u)--(-0.491549u,-0.035737u)--cycle withcolor polygonfill1;
fill (-0.563432u,0.764865u)--(-0.865196u,0.770875u)--(-0.947229u,0.674407u)--(-1.000000u,0.403340u)--cycle withcolor polygonfill1;
draw (0.800642u,-0.054121u)--(0.608665u,-0.003912u)--(0.735661u,-0.426631u)--(1.000000u,-0.357631u)--(0.940360u,-0.284433u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.688839u,-0.462200u)--(-0.902041u,-0.310612u)--(-0.926948u,-0.659170u)--(-0.955076u,-0.770875u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.602421u,0.102993u)--(-0.780730u,0.175352u)--(-0.915917u,0.004110u)--(-0.716103u,-0.199406u)--(-0.594161u,-0.020605u)--(-0.491549u,-0.035737u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.563432u,0.764865u)--(-0.865196u,0.770875u)--(-0.947229u,0.674407u)--(-1.000000u,0.403340u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.014371u,-0.252857u)--(0.608665u,-0.003912u)--(-0.888999u,0.495261u)--(-0.836392u,0.104845u)--(-0.767597u,-0.406203u)--(-0.014371u,-0.252857u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (0.608665u,-0.003912u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.888999u,0.495261u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.836392u,0.104845u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.767597u,-0.406203u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.014371u,-0.252857u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
