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
fill (-0.772777u,1.000000u)--(-0.982297u,0.724968u)--(-0.860264u,0.645317u)--cycle withcolor polygonfill1;
fill (0.671404u,-0.144766u)--(0.608326u,-0.388761u)--(0.770126u,-0.383644u)--(0.970925u,-0.416961u)--cycle withcolor polygonfill1;
fill (0.939464u,-0.630878u)--(0.842482u,-0.661623u)--(0.838114u,-0.955648u)--(0.982297u,-1.000000u)--cycle withcolor polygonfill1;
fill (0.031329u,0.519342u)--(-0.375239u,0.338179u)--(-0.322876u,0.218574u)--(0.004573u,0.179963u)--cycle withcolor polygonfill2;
fill (0.916490u,0.762881u)--(0.517155u,0.550166u)--(0.673630u,0.486923u)--cycle withcolor polygonfill1;
draw (-0.772777u,1.000000u)--(-0.982297u,0.724968u)--(-0.860264u,0.645317u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.671404u,-0.144766u)--(0.608326u,-0.388761u)--(0.770126u,-0.383644u)--(0.970925u,-0.416961u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.939464u,-0.630878u)--(0.842482u,-0.661623u)--(0.838114u,-0.955648u)--(0.982297u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.031329u,0.519342u)--(-0.375239u,0.338179u)--(-0.322876u,0.218574u)--(0.004573u,0.179963u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.916490u,0.762881u)--(0.517155u,0.550166u)--(0.673630u,0.486923u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.259162u,-0.022219u)--(-0.232032u,0.207862u)--(-0.259162u,-0.022219u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (-0.259162u,-0.022219u)--(0.842482u,-0.661623u)--(0.767873u,-0.383715u)--(0.517155u,0.550166u)--(-0.860264u,0.645317u)--(-0.259162u,-0.022219u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.232032u,0.207862u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.842482u,-0.661623u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.767873u,-0.383715u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.517155u,0.550166u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.860264u,0.645317u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.259162u,-0.022219u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
