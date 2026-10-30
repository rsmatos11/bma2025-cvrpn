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
fill (-0.846812u,-0.476874u)--(-1.000000u,-0.488052u)--(-0.836926u,-0.817464u)--cycle withcolor polygonfill1;
fill (-0.217783u,-0.101467u)--(-0.294390u,-0.131469u)--(-0.586481u,-0.281045u)--(-0.537032u,-0.439700u)--cycle withcolor polygonfill1;
fill (0.264303u,0.678513u)--(0.122764u,0.622483u)--(0.271597u,0.378262u)--cycle withcolor polygonfill1;
fill (0.365827u,-0.449870u)--(0.119603u,-0.325916u)--(0.197251u,-0.649272u)--(0.346050u,-0.669200u)--cycle withcolor polygonfill1;
fill (1.000000u,0.745163u)--(0.612378u,0.817464u)--(0.817823u,0.687041u)--(0.921833u,0.657590u)--cycle withcolor polygonfill1;
draw (-0.846812u,-0.476874u)--(-1.000000u,-0.488052u)--(-0.836926u,-0.817464u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.217783u,-0.101467u)--(-0.294390u,-0.131469u)--(-0.586481u,-0.281045u)--(-0.537032u,-0.439700u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.264303u,0.678513u)--(0.122764u,0.622483u)--(0.271597u,0.378262u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.365827u,-0.449870u)--(0.119603u,-0.325916u)--(0.197251u,-0.649272u)--(0.346050u,-0.669200u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (1.000000u,0.745163u)--(0.612378u,0.817464u)--(0.817823u,0.687041u)--(0.921833u,0.657590u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.072893u,0.389831u)--(0.171575u,0.542388u)--(0.612378u,0.817464u)--(0.119603u,-0.325916u)--(-0.540365u,-0.429005u)--(-0.846812u,-0.476874u)--(-0.072893u,0.389831u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (0.171575u,0.542388u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.612378u,0.817464u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.119603u,-0.325916u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.540365u,-0.429005u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.846812u,-0.476874u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.072893u,0.389831u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
