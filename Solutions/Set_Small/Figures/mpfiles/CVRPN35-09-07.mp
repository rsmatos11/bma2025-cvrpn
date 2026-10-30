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
fill (-0.359880u,-0.401815u)--(-0.454264u,-0.344809u)--(-0.348441u,-0.535609u)--cycle withcolor polygonfill1;
fill (0.397241u,0.142884u)--(0.325415u,0.175009u)--(0.255839u,0.023197u)--(0.489551u,-0.022720u)--cycle withcolor polygonfill2;
fill (0.421801u,-0.821270u)--(0.473231u,-0.731601u)--(0.264301u,-0.727043u)--(0.266486u,-0.818461u)--(0.216297u,-0.848724u)--(0.445466u,-0.943575u)--(0.436759u,-0.898941u)--cycle withcolor polygonfill2;
fill (1.000000u,0.061041u)--(0.819567u,0.101465u)--(0.730486u,-0.089842u)--(0.956036u,-0.141436u)--cycle withcolor polygonfill2;
fill (-0.452439u,0.144563u)--(-0.568990u,-0.045074u)--(-0.540959u,-0.121335u)--(-0.291377u,-0.065209u)--cycle withcolor polygonfill1;
fill (-0.306003u,0.881884u)--(-0.411166u,0.887078u)--(-0.453916u,0.900452u)--(-0.492424u,0.943575u)--(-0.561552u,0.889854u)--(-0.376131u,0.665225u)--(-0.334822u,0.781638u)--cycle withcolor polygonfill1;
fill (0.099650u,-0.157236u)--(0.115906u,-0.094018u)--(0.039130u,-0.124469u)--(-0.078630u,-0.137910u)--(-0.127804u,-0.335398u)--(-0.082177u,-0.381957u)--(0.107400u,-0.242566u)--cycle withcolor polygonfill2;
fill (-0.891422u,0.884946u)--(-1.000000u,0.794593u)--(-0.807958u,0.797678u)--cycle withcolor polygonfill1;
fill (-0.665596u,-0.220213u)--(-0.773160u,-0.196508u)--(-0.831579u,-0.185924u)--(-0.880211u,-0.166959u)--(-0.943060u,-0.370199u)--(-0.829189u,-0.393429u)--(-0.678830u,-0.263286u)--cycle withcolor polygonfill1;
draw (-0.359880u,-0.401815u)--(-0.454264u,-0.344809u)--(-0.348441u,-0.535609u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.397241u,0.142884u)--(0.325415u,0.175009u)--(0.255839u,0.023197u)--(0.489551u,-0.022720u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.421801u,-0.821270u)--(0.473231u,-0.731601u)--(0.264301u,-0.727043u)--(0.266486u,-0.818461u)--(0.216297u,-0.848724u)--(0.445466u,-0.943575u)--(0.436759u,-0.898941u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (1.000000u,0.061041u)--(0.819567u,0.101465u)--(0.730486u,-0.089842u)--(0.956036u,-0.141436u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.452439u,0.144563u)--(-0.568990u,-0.045074u)--(-0.540959u,-0.121335u)--(-0.291377u,-0.065209u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.306003u,0.881884u)--(-0.411166u,0.887078u)--(-0.453916u,0.900452u)--(-0.492424u,0.943575u)--(-0.561552u,0.889854u)--(-0.376131u,0.665225u)--(-0.334822u,0.781638u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.099650u,-0.157236u)--(0.115906u,-0.094018u)--(0.039130u,-0.124469u)--(-0.078630u,-0.137910u)--(-0.127804u,-0.335398u)--(-0.082177u,-0.381957u)--(0.107400u,-0.242566u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.891422u,0.884946u)--(-1.000000u,0.794593u)--(-0.807958u,0.797678u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.665596u,-0.220213u)--(-0.773160u,-0.196508u)--(-0.831579u,-0.185924u)--(-0.880211u,-0.166959u)--(-0.943060u,-0.370199u)--(-0.829189u,-0.393429u)--(-0.678830u,-0.263286u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.176778u,0.213836u)--(-0.318401u,-0.071286u)--(-0.454264u,-0.344809u)--(-0.665596u,-0.220213u)--(-0.807958u,0.797678u)--(-0.376131u,0.665225u)--(-0.176778u,0.213836u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (-0.176778u,0.213836u)--(0.274051u,0.062935u)--(0.730486u,-0.089842u)--(0.341795u,-0.728734u)--(0.011107u,-0.127667u)--(-0.176778u,0.213836u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.318401u,-0.071286u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.454264u,-0.344809u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.665596u,-0.220213u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.807958u,0.797678u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.376131u,0.665225u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.274051u,0.062935u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.730486u,-0.089842u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.341795u,-0.728734u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.011107u,-0.127667u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.176778u,0.213836u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
