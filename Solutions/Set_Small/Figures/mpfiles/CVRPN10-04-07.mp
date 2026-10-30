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
fill (0.940799u,-0.664261u)--(1.000000u,-0.486069u)--(0.550066u,-0.750557u)--(0.690022u,-0.777299u)--(0.946709u,-0.763775u)--cycle withcolor polygonfill1;
fill (-0.518609u,-0.672300u)--(-0.885690u,-0.418670u)--(-0.914388u,-0.776083u)--(-0.653007u,-0.900104u)--cycle withcolor polygonfill1;
fill (0.979994u,0.801866u)--(0.869996u,0.900104u)--(0.500762u,0.553620u)--(0.512679u,0.417272u)--(0.979137u,0.526350u)--cycle withcolor polygonfill1;
fill (-0.735555u,0.138681u)--(-0.616736u,0.193407u)--(-0.844837u,0.249967u)--(-0.961882u,0.177342u)--(-1.000000u,0.061950u)--(-0.620175u,-0.040003u)--cycle withcolor polygonfill1;
draw (0.940799u,-0.664261u)--(1.000000u,-0.486069u)--(0.550066u,-0.750557u)--(0.690022u,-0.777299u)--(0.946709u,-0.763775u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.518609u,-0.672300u)--(-0.885690u,-0.418670u)--(-0.914388u,-0.776083u)--(-0.653007u,-0.900104u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.979994u,0.801866u)--(0.869996u,0.900104u)--(0.500762u,0.553620u)--(0.512679u,0.417272u)--(0.979137u,0.526350u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.735555u,0.138681u)--(-0.616736u,0.193407u)--(-0.844837u,0.249967u)--(-0.961882u,0.177342u)--(-1.000000u,0.061950u)--(-0.620175u,-0.040003u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.400563u,-0.176251u)--(-0.620175u,-0.040003u)--(-0.518609u,-0.672300u)--(0.550066u,-0.750557u)--(0.512679u,0.417272u)--(-0.400563u,-0.176251u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.620175u,-0.040003u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.518609u,-0.672300u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.550066u,-0.750557u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.512679u,0.417272u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.400563u,-0.176251u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
