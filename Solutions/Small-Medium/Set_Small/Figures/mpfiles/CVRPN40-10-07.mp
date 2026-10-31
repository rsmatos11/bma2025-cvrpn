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
fill (0.948790u,-0.504334u)--(0.910791u,-0.473607u)--(0.723576u,-0.413965u)--(0.719887u,-0.487812u)--(0.754470u,-0.525340u)--(0.844473u,-0.593785u)--(0.954177u,-0.587724u)--cycle withcolor polygonfill1;
fill (0.003566u,-0.609295u)--(0.014192u,-0.753299u)--(0.135560u,-0.820962u)--(0.159679u,-0.765573u)--cycle withcolor polygonfill1;
fill (-0.643158u,0.793753u)--(-0.710846u,0.796536u)--(-0.561733u,0.563705u)--cycle withcolor polygonfill2;
fill (0.120026u,0.525974u)--(-0.067157u,0.634813u)--(-0.065711u,0.506221u)--(0.080115u,0.408668u)--(0.143131u,0.420667u)--(0.141532u,0.481209u)--cycle withcolor polygonfill2;
fill (-0.446849u,-0.299731u)--(-0.547446u,-0.295195u)--(-0.631521u,-0.285721u)--(-0.629626u,-0.409335u)--(-0.445505u,-0.359663u)--cycle withcolor polygonfill2;
fill (1.000000u,-0.103934u)--(0.854133u,-0.175401u)--(0.949150u,-0.310682u)--cycle withcolor polygonfill1;
fill (-0.773040u,0.073601u)--(-0.997551u,0.149762u)--(-1.000000u,0.029787u)--(-0.762859u,0.001434u)--cycle withcolor polygonfill2;
fill (0.282964u,-0.236068u)--(0.138286u,-0.207165u)--(0.199651u,-0.263013u)--(0.154625u,-0.256577u)--(0.313900u,-0.391612u)--(0.366445u,-0.396459u)--cycle withcolor polygonfill1;
fill (0.197646u,0.820962u)--(0.199528u,0.722023u)--(0.369573u,0.601954u)--cycle withcolor polygonfill2;
fill (-0.766627u,-0.548160u)--(-0.904949u,-0.445270u)--(-0.785551u,-0.651701u)--cycle withcolor polygonfill2;
draw (0.948790u,-0.504334u)--(0.910791u,-0.473607u)--(0.723576u,-0.413965u)--(0.719887u,-0.487812u)--(0.754470u,-0.525340u)--(0.844473u,-0.593785u)--(0.954177u,-0.587724u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.003566u,-0.609295u)--(0.014192u,-0.753299u)--(0.135560u,-0.820962u)--(0.159679u,-0.765573u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.643158u,0.793753u)--(-0.710846u,0.796536u)--(-0.561733u,0.563705u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.120026u,0.525974u)--(-0.067157u,0.634813u)--(-0.065711u,0.506221u)--(0.080115u,0.408668u)--(0.143131u,0.420667u)--(0.141532u,0.481209u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.446849u,-0.299731u)--(-0.547446u,-0.295195u)--(-0.631521u,-0.285721u)--(-0.629626u,-0.409335u)--(-0.445505u,-0.359663u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (1.000000u,-0.103934u)--(0.854133u,-0.175401u)--(0.949150u,-0.310682u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.773040u,0.073601u)--(-0.997551u,0.149762u)--(-1.000000u,0.029787u)--(-0.762859u,0.001434u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.282964u,-0.236068u)--(0.138286u,-0.207165u)--(0.199651u,-0.263013u)--(0.154625u,-0.256577u)--(0.313900u,-0.391612u)--(0.366445u,-0.396459u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.197646u,0.820962u)--(0.199528u,0.722023u)--(0.369573u,0.601954u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.766627u,-0.548160u)--(-0.904949u,-0.445270u)--(-0.785551u,-0.651701u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.087894u,-0.233981u)--(-0.445505u,-0.359663u)--(-0.814703u,-0.512398u)--(-0.762859u,0.001434u)--(-0.561733u,0.563705u)--(0.199528u,0.722023u)--(0.143131u,0.420667u)--(0.087894u,-0.233981u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (0.087894u,-0.233981u)--(0.221417u,-0.223773u)--(0.854133u,-0.175401u)--(0.723576u,-0.413965u)--(0.003566u,-0.609295u)--(0.087894u,-0.233981u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.445505u,-0.359663u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.814703u,-0.512398u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.762859u,0.001434u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.561733u,0.563705u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.199528u,0.722023u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.143131u,0.420667u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.221417u,-0.223773u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.854133u,-0.175401u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.723576u,-0.413965u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.003566u,-0.609295u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.087894u,-0.233981u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
