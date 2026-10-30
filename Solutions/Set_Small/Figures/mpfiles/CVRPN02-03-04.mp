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
fill (-0.674360u,0.138999u)--(-0.937806u,0.050554u)--(-0.980630u,-0.137536u)--(-1.000000u,-0.459898u)--cycle withcolor polygonfill1;
fill (0.194928u,0.438220u)--(0.285655u,0.583553u)--(-0.310463u,0.264624u)--(0.220557u,0.079040u)--cycle withcolor polygonfill1;
fill (0.835875u,0.426489u)--(0.744720u,0.043873u)--(0.876094u,-0.070880u)--(1.000000u,-0.164637u)--cycle withcolor polygonfill1;
draw (-0.674360u,0.138999u)--(-0.937806u,0.050554u)--(-0.980630u,-0.137536u)--(-1.000000u,-0.459898u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.194928u,0.438220u)--(0.285655u,0.583553u)--(-0.310463u,0.264624u)--(0.220557u,0.079040u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.835875u,0.426489u)--(0.744720u,0.043873u)--(0.876094u,-0.070880u)--(1.000000u,-0.164637u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.049417u,-0.583553u)--(0.744720u,0.043873u)--(0.220557u,0.079040u)--(-0.674360u,0.138999u)--(0.049417u,-0.583553u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (0.744720u,0.043873u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.220557u,0.079040u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.674360u,0.138999u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.049417u,-0.583553u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
