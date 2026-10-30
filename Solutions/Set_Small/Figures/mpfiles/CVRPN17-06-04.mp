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
fill (0.277620u,-0.543473u)--(0.168359u,-0.656028u)--(0.253349u,-0.714246u)--cycle withcolor polygonfill1;
fill (-0.412291u,0.434261u)--(-0.490814u,0.521418u)--(-0.471962u,0.262488u)--cycle withcolor polygonfill2;
fill (0.597109u,0.956914u)--(0.356346u,1.000000u)--(0.338826u,0.750042u)--cycle withcolor polygonfill1;
fill (0.821302u,-0.752443u)--(0.651412u,-0.767484u)--(0.518400u,-0.805225u)--cycle withcolor polygonfill1;
fill (-0.742302u,-0.795262u)--(-0.811556u,-0.693350u)--(-0.905449u,-0.714230u)--(-0.911035u,-1.000000u)--cycle withcolor polygonfill1;
fill (0.725356u,0.779917u)--(0.805909u,0.762195u)--(0.911035u,0.746549u)--cycle withcolor polygonfill1;
draw (0.277620u,-0.543473u)--(0.168359u,-0.656028u)--(0.253349u,-0.714246u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.412291u,0.434261u)--(-0.490814u,0.521418u)--(-0.471962u,0.262488u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.597109u,0.956914u)--(0.356346u,1.000000u)--(0.338826u,0.750042u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.821302u,-0.752443u)--(0.651412u,-0.767484u)--(0.518400u,-0.805225u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.742302u,-0.795262u)--(-0.811556u,-0.693350u)--(-0.905449u,-0.714230u)--(-0.911035u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.725356u,0.779917u)--(0.805909u,0.762195u)--(0.911035u,0.746549u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.150701u,0.083301u)--(-0.471962u,0.262488u)--(-0.150701u,0.083301u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (-0.150701u,0.083301u)--(0.338826u,0.750042u)--(0.725356u,0.779917u)--(0.518400u,-0.805225u)--(0.253349u,-0.714246u)--(-0.742302u,-0.795262u)--(-0.150701u,0.083301u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.471962u,0.262488u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.338826u,0.750042u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.725356u,0.779917u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.518400u,-0.805225u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.253349u,-0.714246u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.742302u,-0.795262u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.150701u,0.083301u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
