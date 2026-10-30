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
fill (0.489383u,-0.755963u)--(0.213440u,-0.683794u)--(0.395981u,-0.951729u)--cycle withcolor polygonfill1;
fill (-0.101950u,0.882216u)--(-0.256074u,0.831111u)--(-0.022681u,0.627187u)--cycle withcolor polygonfill2;
fill (-0.054933u,-0.142148u)--(-0.248866u,-0.121503u)--(-0.307865u,-0.210759u)--(-0.203853u,-0.367902u)--(-0.030264u,-0.265563u)--cycle withcolor polygonfill1;
fill (1.000000u,0.869308u)--(0.715125u,0.951729u)--(0.679600u,0.681424u)--(0.750782u,0.717572u)--(0.961263u,0.628962u)--cycle withcolor polygonfill2;
fill (0.160593u,0.683553u)--(0.138619u,0.594342u)--(0.210548u,0.622926u)--cycle withcolor polygonfill2;
fill (-0.880756u,-0.192949u)--(-0.967092u,-0.178440u)--(-1.000000u,-0.278138u)--(-0.706650u,-0.243117u)--cycle withcolor polygonfill1;
draw (0.489383u,-0.755963u)--(0.213440u,-0.683794u)--(0.395981u,-0.951729u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.101950u,0.882216u)--(-0.256074u,0.831111u)--(-0.022681u,0.627187u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.054933u,-0.142148u)--(-0.248866u,-0.121503u)--(-0.307865u,-0.210759u)--(-0.203853u,-0.367902u)--(-0.030264u,-0.265563u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (1.000000u,0.869308u)--(0.715125u,0.951729u)--(0.679600u,0.681424u)--(0.750782u,0.717572u)--(0.961263u,0.628962u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.160593u,0.683553u)--(0.138619u,0.594342u)--(0.210548u,0.622926u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.880756u,-0.192949u)--(-0.967092u,-0.178440u)--(-1.000000u,-0.278138u)--(-0.706650u,-0.243117u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.146603u,0.154043u)--(-0.054933u,-0.142148u)--(0.213440u,-0.683794u)--(-0.706650u,-0.243117u)--(-0.146603u,0.154043u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (-0.146603u,0.154043u)--(0.679600u,0.681424u)--(0.149994u,0.640523u)--(-0.022681u,0.627187u)--(-0.146603u,0.154043u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.054933u,-0.142148u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.213440u,-0.683794u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.706650u,-0.243117u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.679600u,0.681424u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.149994u,0.640523u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.022681u,0.627187u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.146603u,0.154043u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
