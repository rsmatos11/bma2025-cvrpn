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
fill (-0.390708u,0.456627u)--(-0.387044u,0.275479u)--(-0.330481u,0.105530u)--cycle withcolor polygonfill1;
fill (0.889186u,0.872490u)--(0.678468u,0.710400u)--(0.990130u,0.577441u)--(1.000000u,0.710294u)--cycle withcolor polygonfill1;
fill (0.548385u,-0.584061u)--(0.475002u,-0.596110u)--(0.416636u,-0.556318u)--(0.286364u,-0.554879u)--(0.428760u,-0.872490u)--(0.555401u,-0.848257u)--cycle withcolor polygonfill1;
fill (-0.678780u,0.034380u)--(-0.937388u,-0.061672u)--(-1.000000u,-0.044485u)--(-0.863527u,-0.186731u)--(-0.803449u,-0.182409u)--(-0.718536u,-0.182319u)--(-0.682570u,-0.126735u)--cycle withcolor polygonfill1;
fill (0.069388u,0.584039u)--(-0.126905u,0.461454u)--(0.104850u,0.325257u)--cycle withcolor polygonfill1;
draw (-0.390708u,0.456627u)--(-0.387044u,0.275479u)--(-0.330481u,0.105530u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.889186u,0.872490u)--(0.678468u,0.710400u)--(0.990130u,0.577441u)--(1.000000u,0.710294u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.548385u,-0.584061u)--(0.475002u,-0.596110u)--(0.416636u,-0.556318u)--(0.286364u,-0.554879u)--(0.428760u,-0.872490u)--(0.555401u,-0.848257u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.678780u,0.034380u)--(-0.937388u,-0.061672u)--(-1.000000u,-0.044485u)--(-0.863527u,-0.186731u)--(-0.803449u,-0.182409u)--(-0.718536u,-0.182319u)--(-0.682570u,-0.126735u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.069388u,0.584039u)--(-0.126905u,0.461454u)--(0.104850u,0.325257u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.068815u,0.206245u)--(0.104850u,0.325257u)--(0.678468u,0.710400u)--(0.286364u,-0.554879u)--(-0.680885u,-0.055118u)--(-0.330481u,0.105530u)--(0.068815u,0.206245u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (0.104850u,0.325257u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.678468u,0.710400u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.286364u,-0.554879u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.680885u,-0.055118u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.330481u,0.105530u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.068815u,0.206245u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
