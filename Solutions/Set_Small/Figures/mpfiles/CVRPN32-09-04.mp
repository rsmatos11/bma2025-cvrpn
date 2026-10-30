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
fill (-0.652503u,0.495512u)--(-0.831781u,0.445098u)--(-0.814319u,0.368629u)--cycle withcolor polygonfill3;
fill (-0.651938u,0.179328u)--(-0.816718u,0.118752u)--(-0.640905u,-0.030059u)--cycle withcolor polygonfill3;
fill (0.046688u,-0.087473u)--(0.003065u,-0.143748u)--(-0.069559u,-0.281169u)--(0.080952u,-0.319063u)--cycle withcolor polygonfill1;
fill (-0.382444u,-0.833621u)--(-0.597685u,-0.846418u)--(-0.421918u,-1.000000u)--cycle withcolor polygonfill1;
fill (0.581475u,-0.616427u)--(0.469296u,-0.708897u)--(0.641252u,-0.830208u)--(0.642005u,-0.778062u)--cycle withcolor polygonfill2;
fill (0.693602u,0.824151u)--(0.489377u,0.837514u)--(0.499339u,0.747661u)--(0.630346u,0.599020u)--cycle withcolor polygonfill3;
fill (0.831781u,-0.296909u)--(0.651508u,-0.255428u)--(0.619032u,-0.441490u)--(0.724707u,-0.449534u)--cycle withcolor polygonfill2;
fill (0.097391u,-0.494077u)--(-0.153360u,-0.495534u)--(0.064557u,-0.651220u)--cycle withcolor polygonfill1;
fill (-0.406893u,1.000000u)--(-0.419851u,0.898693u)--(-0.163494u,0.858244u)--cycle withcolor polygonfill3;
draw (-0.652503u,0.495512u)--(-0.831781u,0.445098u)--(-0.814319u,0.368629u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge3;
draw (-0.651938u,0.179328u)--(-0.816718u,0.118752u)--(-0.640905u,-0.030059u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge3;
draw (0.046688u,-0.087473u)--(0.003065u,-0.143748u)--(-0.069559u,-0.281169u)--(0.080952u,-0.319063u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.382444u,-0.833621u)--(-0.597685u,-0.846418u)--(-0.421918u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.581475u,-0.616427u)--(0.469296u,-0.708897u)--(0.641252u,-0.830208u)--(0.642005u,-0.778062u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.693602u,0.824151u)--(0.489377u,0.837514u)--(0.499339u,0.747661u)--(0.630346u,0.599020u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge3;
draw (0.831781u,-0.296909u)--(0.651508u,-0.255428u)--(0.619032u,-0.441490u)--(0.724707u,-0.449534u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.097391u,-0.494077u)--(-0.153360u,-0.495534u)--(0.064557u,-0.651220u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.406893u,1.000000u)--(-0.419851u,0.898693u)--(-0.163494u,0.858244u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge3;
draw (0.099280u,0.025104u)--(-0.651938u,0.179328u)--(-0.652503u,0.495512u)--(-0.163494u,0.858244u)--(0.499339u,0.747661u)--(0.099280u,0.025104u) withpen pencircle scaled routewidth withcolor routecolor3;
draw (0.099280u,0.025104u)--(0.041243u,-0.094497u)--(-0.153360u,-0.495534u)--(-0.382444u,-0.833621u)--(0.099280u,0.025104u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (0.099280u,0.025104u)--(0.619032u,-0.441490u)--(0.581475u,-0.616427u)--(0.099280u,0.025104u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.651938u,0.179328u) withpen pencircle scaled visitpointsize withcolor visitpoint3;
drawdot (-0.652503u,0.495512u) withpen pencircle scaled visitpointsize withcolor visitpoint3;
drawdot (-0.163494u,0.858244u) withpen pencircle scaled visitpointsize withcolor visitpoint3;
drawdot (0.499339u,0.747661u) withpen pencircle scaled visitpointsize withcolor visitpoint3;
drawdot (0.041243u,-0.094497u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.153360u,-0.495534u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.382444u,-0.833621u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.619032u,-0.441490u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.581475u,-0.616427u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.099280u,0.025104u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
