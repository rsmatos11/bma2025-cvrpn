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
fill (-0.342901u,-0.799619u)--(-0.558477u,-0.815350u)--(-0.562216u,-0.906247u)--(-0.505646u,-0.971608u)--(-0.328990u,-1.000000u)--cycle withcolor polygonfill1;
fill (0.180828u,-0.646259u)--(0.061790u,-0.629116u)--(-0.054817u,-0.765045u)--(-0.002974u,-0.782411u)--(0.010481u,-0.843323u)--(0.109638u,-0.843020u)--cycle withcolor polygonfill1;
fill (0.311574u,0.845733u)--(0.175866u,1.000000u)--(0.109278u,0.884423u)--(0.212643u,0.750295u)--(0.270082u,0.791655u)--(0.372358u,0.762769u)--cycle withcolor polygonfill1;
fill (0.912036u,0.269814u)--(0.845657u,0.040349u)--(0.964249u,0.060094u)--cycle withcolor polygonfill1;
fill (-0.587360u,0.159782u)--(-0.627342u,0.109327u)--(-0.617640u,-0.007066u)--(-0.601755u,0.053937u)--cycle withcolor polygonfill2;
fill (0.419589u,-0.669501u)--(0.277833u,-0.646466u)--(0.286402u,-0.829313u)--(0.411183u,-0.815466u)--cycle withcolor polygonfill1;
fill (-0.744117u,0.444195u)--(-0.831044u,0.448139u)--(-0.964249u,0.266187u)--(-0.693605u,0.363170u)--cycle withcolor polygonfill2;
draw (-0.342901u,-0.799619u)--(-0.558477u,-0.815350u)--(-0.562216u,-0.906247u)--(-0.505646u,-0.971608u)--(-0.328990u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.180828u,-0.646259u)--(0.061790u,-0.629116u)--(-0.054817u,-0.765045u)--(-0.002974u,-0.782411u)--(0.010481u,-0.843323u)--(0.109638u,-0.843020u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.311574u,0.845733u)--(0.175866u,1.000000u)--(0.109278u,0.884423u)--(0.212643u,0.750295u)--(0.270082u,0.791655u)--(0.372358u,0.762769u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.912036u,0.269814u)--(0.845657u,0.040349u)--(0.964249u,0.060094u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.587360u,0.159782u)--(-0.627342u,0.109327u)--(-0.617640u,-0.007066u)--(-0.601755u,0.053937u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.419589u,-0.669501u)--(0.277833u,-0.646466u)--(0.286402u,-0.829313u)--(0.411183u,-0.815466u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.744117u,0.444195u)--(-0.831044u,0.448139u)--(-0.964249u,0.266187u)--(-0.693605u,0.363170u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.094231u,-0.041532u)--(-0.342901u,-0.799619u)--(-0.015094u,-0.718740u)--(0.277833u,-0.646466u)--(0.845657u,0.040349u)--(0.372358u,0.762769u)--(-0.094231u,-0.041532u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (-0.094231u,-0.041532u)--(-0.693605u,0.363170u)--(-0.587360u,0.159782u)--(-0.094231u,-0.041532u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.342901u,-0.799619u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.015094u,-0.718740u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.277833u,-0.646466u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.845657u,0.040349u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.372358u,0.762769u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.693605u,0.363170u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.587360u,0.159782u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.094231u,-0.041532u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
