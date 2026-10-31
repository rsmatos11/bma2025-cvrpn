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
fill (-0.598989u,-0.058040u)--(-0.800095u,-0.061023u)--(-0.762063u,-0.227736u)--(-0.586460u,-0.251939u)--cycle withcolor polygonfill1;
fill (0.590396u,-0.769123u)--(0.404327u,-0.963276u)--(0.504916u,-1.000000u)--(0.622206u,-0.936896u)--cycle withcolor polygonfill2;
fill (-0.194015u,1.000000u)--(-0.243014u,0.917422u)--(-0.173924u,0.802750u)--cycle withcolor polygonfill1;
fill (-0.495803u,-0.516081u)--(-0.714961u,-0.467479u)--(-0.703200u,-0.697143u)--(-0.509100u,-0.687935u)--cycle withcolor polygonfill1;
fill (0.758423u,-0.126640u)--(0.691430u,-0.170152u)--(0.669096u,-0.339680u)--(0.800095u,-0.252646u)--cycle withcolor polygonfill2;
fill (-0.403829u,0.052728u)--(-0.334729u,-0.227150u)--(-0.236050u,-0.186246u)--(-0.126615u,-0.221084u)--cycle withcolor polygonfill1;
fill (-0.275854u,0.631835u)--(-0.260396u,0.446418u)--(-0.213294u,0.509629u)--cycle withcolor polygonfill1;
draw (-0.598989u,-0.058040u)--(-0.800095u,-0.061023u)--(-0.762063u,-0.227736u)--(-0.586460u,-0.251939u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.590396u,-0.769123u)--(0.404327u,-0.963276u)--(0.504916u,-1.000000u)--(0.622206u,-0.936896u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.194015u,1.000000u)--(-0.243014u,0.917422u)--(-0.173924u,0.802750u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.495803u,-0.516081u)--(-0.714961u,-0.467479u)--(-0.703200u,-0.697143u)--(-0.509100u,-0.687935u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.758423u,-0.126640u)--(0.691430u,-0.170152u)--(0.669096u,-0.339680u)--(0.800095u,-0.252646u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.403829u,0.052728u)--(-0.334729u,-0.227150u)--(-0.236050u,-0.186246u)--(-0.126615u,-0.221084u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.275854u,0.631835u)--(-0.260396u,0.446418u)--(-0.213294u,0.509629u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.120185u,0.152120u)--(-0.173924u,0.802750u)--(-0.269691u,0.557911u)--(-0.586460u,-0.251939u)--(-0.501225u,-0.514878u)--(-0.204432u,-0.196311u)--(0.120185u,0.152120u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (0.120185u,0.152120u)--(0.590396u,-0.769123u)--(0.669096u,-0.339680u)--(0.120185u,0.152120u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.173924u,0.802750u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.269691u,0.557911u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.586460u,-0.251939u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.501225u,-0.514878u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.204432u,-0.196311u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.590396u,-0.769123u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.669096u,-0.339680u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.120185u,0.152120u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
