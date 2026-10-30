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
fill (-0.540691u,-0.385473u)--(-0.705036u,-0.416232u)--(-0.800573u,-0.488423u)--(-0.693861u,-0.715142u)--(-0.550522u,-0.622404u)--cycle withcolor polygonfill1;
fill (1.000000u,-0.707549u)--(0.863436u,-0.655004u)--(0.655458u,-0.792296u)--(0.935383u,-0.764975u)--cycle withcolor polygonfill1;
fill (-0.220425u,-0.336694u)--(-0.353989u,-0.359616u)--(-0.229733u,-0.639669u)--cycle withcolor polygonfill1;
fill (-1.000000u,-0.372640u)--(-0.920146u,-0.583412u)--(-0.919177u,-0.486838u)--cycle withcolor polygonfill1;
fill (0.386278u,0.792296u)--(0.446528u,0.706967u)--(0.530317u,0.709708u)--(0.655806u,0.725469u)--cycle withcolor polygonfill2;
fill (0.437512u,0.552294u)--(0.115772u,0.512088u)--(0.160080u,0.410943u)--cycle withcolor polygonfill2;
fill (0.246455u,-0.109095u)--(-0.075276u,0.001667u)--(-0.093722u,-0.091006u)--(-0.075382u,-0.240835u)--(0.177708u,-0.187658u)--cycle withcolor polygonfill2;
draw (-0.540691u,-0.385473u)--(-0.705036u,-0.416232u)--(-0.800573u,-0.488423u)--(-0.693861u,-0.715142u)--(-0.550522u,-0.622404u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (1.000000u,-0.707549u)--(0.863436u,-0.655004u)--(0.655458u,-0.792296u)--(0.935383u,-0.764975u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.220425u,-0.336694u)--(-0.353989u,-0.359616u)--(-0.229733u,-0.639669u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-1.000000u,-0.372640u)--(-0.920146u,-0.583412u)--(-0.919177u,-0.486838u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.386278u,0.792296u)--(0.446528u,0.706967u)--(0.530317u,0.709708u)--(0.655806u,0.725469u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.437512u,0.552294u)--(0.115772u,0.512088u)--(0.160080u,0.410943u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.246455u,-0.109095u)--(-0.075276u,0.001667u)--(-0.093722u,-0.091006u)--(-0.075382u,-0.240835u)--(0.177708u,-0.187658u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.035001u,0.281996u)--(-0.919177u,-0.486838u)--(-0.789477u,-0.511996u)--(-0.239000u,-0.618782u)--(0.655458u,-0.792296u)--(0.035001u,0.281996u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (0.035001u,0.281996u)--(0.277369u,0.532282u)--(0.446528u,0.706967u)--(-0.000242u,-0.024165u)--(0.035001u,0.281996u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.919177u,-0.486838u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.789477u,-0.511996u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.239000u,-0.618782u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.655458u,-0.792296u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.277369u,0.532282u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.446528u,0.706967u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.000242u,-0.024165u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.035001u,0.281996u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
