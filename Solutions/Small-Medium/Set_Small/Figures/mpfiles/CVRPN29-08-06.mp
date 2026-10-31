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
fill (0.596325u,-0.789923u)--(0.406747u,-0.694297u)--(0.325293u,-0.841322u)--(0.455456u,-0.878636u)--cycle withcolor polygonfill1;
fill (1.000000u,0.330041u)--(0.957298u,0.401918u)--(0.878933u,0.454371u)--(0.727111u,0.203929u)--(0.807297u,0.205669u)--(0.994872u,0.225121u)--cycle withcolor polygonfill1;
fill (-0.909044u,0.878636u)--(-1.000000u,0.862301u)--(-0.778522u,0.709492u)--cycle withcolor polygonfill2;
fill (-0.596796u,-0.168950u)--(-0.602049u,-0.315250u)--(-0.377909u,-0.376649u)--cycle withcolor polygonfill2;
fill (0.252455u,0.528835u)--(0.072947u,0.641969u)--(0.003071u,0.588832u)--(0.042605u,0.436964u)--(0.183046u,0.390415u)--cycle withcolor polygonfill1;
fill (0.019174u,0.108960u)--(-0.063332u,0.192840u)--(-0.076470u,0.031874u)--(0.073725u,-0.024881u)--(0.060148u,0.072919u)--cycle withcolor polygonfill1;
fill (-0.742432u,-0.250574u)--(-0.836605u,-0.275196u)--(-0.835850u,-0.214338u)--(-0.984462u,-0.288813u)--(-0.797687u,-0.479784u)--cycle withcolor polygonfill2;
fill (-0.640434u,0.676901u)--(-0.672204u,0.575327u)--(-0.684817u,0.422505u)--cycle withcolor polygonfill2;
draw (0.596325u,-0.789923u)--(0.406747u,-0.694297u)--(0.325293u,-0.841322u)--(0.455456u,-0.878636u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (1.000000u,0.330041u)--(0.957298u,0.401918u)--(0.878933u,0.454371u)--(0.727111u,0.203929u)--(0.807297u,0.205669u)--(0.994872u,0.225121u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.909044u,0.878636u)--(-1.000000u,0.862301u)--(-0.778522u,0.709492u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.596796u,-0.168950u)--(-0.602049u,-0.315250u)--(-0.377909u,-0.376649u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.252455u,0.528835u)--(0.072947u,0.641969u)--(0.003071u,0.588832u)--(0.042605u,0.436964u)--(0.183046u,0.390415u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.019174u,0.108960u)--(-0.063332u,0.192840u)--(-0.076470u,0.031874u)--(0.073725u,-0.024881u)--(0.060148u,0.072919u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.742432u,-0.250574u)--(-0.836605u,-0.275196u)--(-0.835850u,-0.214338u)--(-0.984462u,-0.288813u)--(-0.797687u,-0.479784u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.640434u,0.676901u)--(-0.672204u,0.575327u)--(-0.684817u,0.422505u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.175188u,-0.131460u)--(-0.598643u,-0.220380u)--(-0.742432u,-0.250574u)--(-0.778522u,0.709492u)--(-0.673242u,0.562748u)--(-0.175188u,-0.131460u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (-0.175188u,-0.131460u)--(0.001900u,0.126522u)--(0.183046u,0.390415u)--(0.727111u,0.203929u)--(0.406747u,-0.694297u)--(-0.175188u,-0.131460u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.598643u,-0.220380u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.742432u,-0.250574u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.778522u,0.709492u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.673242u,0.562748u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.001900u,0.126522u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.183046u,0.390415u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.727111u,0.203929u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.406747u,-0.694297u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.175188u,-0.131460u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
