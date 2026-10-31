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
fill (0.280312u,0.339876u)--(0.022591u,0.383838u)--(0.072009u,0.129421u)--(0.125551u,0.174760u)--cycle withcolor polygonfill1;
fill (-0.228617u,-0.258908u)--(-0.350537u,-0.259885u)--(-0.435816u,-0.313321u)--(-0.308784u,-0.517485u)--(-0.244527u,-0.470589u)--(-0.187739u,-0.427082u)--cycle withcolor polygonfill1;
fill (0.435816u,-0.245440u)--(0.127612u,-0.425535u)--(0.230660u,-0.462302u)--cycle withcolor polygonfill1;
fill (0.061826u,-0.709818u)--(-0.076847u,-0.948395u)--(0.029427u,-1.000000u)--cycle withcolor polygonfill1;
fill (-0.073247u,0.984967u)--(-0.201736u,1.000000u)--(-0.368725u,0.735489u)--(-0.092094u,0.706033u)--(-0.085519u,0.783063u)--cycle withcolor polygonfill1;
draw (0.280312u,0.339876u)--(0.022591u,0.383838u)--(0.072009u,0.129421u)--(0.125551u,0.174760u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.228617u,-0.258908u)--(-0.350537u,-0.259885u)--(-0.435816u,-0.313321u)--(-0.308784u,-0.517485u)--(-0.244527u,-0.470589u)--(-0.187739u,-0.427082u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.435816u,-0.245440u)--(0.127612u,-0.425535u)--(0.230660u,-0.462302u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.061826u,-0.709818u)--(-0.076847u,-0.948395u)--(0.029427u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.073247u,0.984967u)--(-0.201736u,1.000000u)--(-0.368725u,0.735489u)--(-0.092094u,0.706033u)--(-0.085519u,0.783063u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.388991u,-0.029430u)--(0.226235u,-0.367906u)--(0.061826u,-0.709818u)--(-0.218214u,-0.301704u)--(-0.092094u,0.706033u)--(0.130728u,0.365392u)--(0.388991u,-0.029430u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (0.226235u,-0.367906u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.061826u,-0.709818u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.218214u,-0.301704u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.092094u,0.706033u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.130728u,0.365392u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.388991u,-0.029430u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
