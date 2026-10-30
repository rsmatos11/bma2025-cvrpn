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
fill (0.587049u,0.617001u)--(0.437718u,0.637741u)--(0.629800u,0.466980u)--cycle withcolor polygonfill2;
fill (0.043144u,-0.478826u)--(-0.152419u,-0.635655u)--(0.054426u,-0.653322u)--cycle withcolor polygonfill1;
fill (0.976484u,-0.804813u)--(0.931275u,-0.692145u)--(0.749605u,-0.827709u)--(0.985442u,-0.906598u)--cycle withcolor polygonfill1;
fill (0.601286u,-0.515824u)--(0.644272u,-0.457025u)--(0.396927u,-0.523017u)--(0.429031u,-0.567980u)--(0.596540u,-0.661210u)--cycle withcolor polygonfill1;
fill (0.658796u,0.092922u)--(0.581361u,0.071390u)--(0.451932u,0.053789u)--(0.441590u,-0.057573u)--(0.459865u,-0.104689u)--cycle withcolor polygonfill2;
fill (0.869646u,-0.164496u)--(0.828669u,-0.223523u)--(0.767018u,-0.346541u)--(0.770953u,-0.414391u)--cycle withcolor polygonfill2;
fill (0.344857u,0.936711u)--(0.265066u,1.000000u)--(0.167803u,0.923188u)--(0.115804u,0.854458u)--(0.343987u,0.791453u)--cycle withcolor polygonfill2;
fill (-0.964621u,-0.495491u)--(-0.985442u,-0.606563u)--(-0.734896u,-0.630265u)--cycle withcolor polygonfill1;
fill (-0.450021u,-0.383833u)--(-0.405868u,-0.294220u)--(-0.449571u,-0.330400u)--(-0.617750u,-0.490776u)--(-0.527557u,-0.502521u)--cycle withcolor polygonfill1;
fill (0.517137u,-0.854471u)--(0.322441u,-0.905058u)--(0.348417u,-1.000000u)--cycle withcolor polygonfill1;
draw (0.587049u,0.617001u)--(0.437718u,0.637741u)--(0.629800u,0.466980u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.043144u,-0.478826u)--(-0.152419u,-0.635655u)--(0.054426u,-0.653322u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.976484u,-0.804813u)--(0.931275u,-0.692145u)--(0.749605u,-0.827709u)--(0.985442u,-0.906598u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.601286u,-0.515824u)--(0.644272u,-0.457025u)--(0.396927u,-0.523017u)--(0.429031u,-0.567980u)--(0.596540u,-0.661210u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.658796u,0.092922u)--(0.581361u,0.071390u)--(0.451932u,0.053789u)--(0.441590u,-0.057573u)--(0.459865u,-0.104689u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.869646u,-0.164496u)--(0.828669u,-0.223523u)--(0.767018u,-0.346541u)--(0.770953u,-0.414391u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.344857u,0.936711u)--(0.265066u,1.000000u)--(0.167803u,0.923188u)--(0.115804u,0.854458u)--(0.343987u,0.791453u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.964621u,-0.495491u)--(-0.985442u,-0.606563u)--(-0.734896u,-0.630265u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.450021u,-0.383833u)--(-0.405868u,-0.294220u)--(-0.449571u,-0.330400u)--(-0.617750u,-0.490776u)--(-0.527557u,-0.502521u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.517137u,-0.854471u)--(0.322441u,-0.905058u)--(0.348417u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.137272u,0.156309u)--(-0.440723u,-0.364962u)--(-0.734896u,-0.630265u)--(-0.152419u,-0.635655u)--(0.517137u,-0.854471u)--(0.749605u,-0.827709u)--(0.536782u,-0.485703u)--(0.137272u,0.156309u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (0.137272u,0.156309u)--(0.448780u,0.019857u)--(0.869646u,-0.164496u)--(0.437718u,0.637741u)--(0.343987u,0.791453u)--(0.137272u,0.156309u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.440723u,-0.364962u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.734896u,-0.630265u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.152419u,-0.635655u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.517137u,-0.854471u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.749605u,-0.827709u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.536782u,-0.485703u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.448780u,0.019857u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.869646u,-0.164496u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.437718u,0.637741u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.343987u,0.791453u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.137272u,0.156309u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
