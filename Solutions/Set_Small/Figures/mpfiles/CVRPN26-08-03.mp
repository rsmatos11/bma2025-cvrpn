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
fill (0.094631u,0.545224u)--(0.021059u,0.555719u)--(0.267134u,0.370584u)--cycle withcolor polygonfill2;
fill (1.000000u,0.660330u)--(0.789789u,0.653681u)--(0.736645u,0.580404u)--cycle withcolor polygonfill2;
fill (-0.214124u,0.654370u)--(-0.318717u,0.689131u)--(-0.449491u,0.515113u)--cycle withcolor polygonfill1;
fill (0.960693u,-0.260859u)--(0.756408u,-0.541653u)--(0.945203u,-0.473676u)--cycle withcolor polygonfill2;
fill (-0.849069u,-0.474614u)--(-1.000000u,-0.595441u)--(-0.876137u,-0.689131u)--cycle withcolor polygonfill1;
fill (-0.648673u,-0.129546u)--(-0.664078u,-0.358049u)--(-0.588580u,-0.310795u)--cycle withcolor polygonfill1;
fill (-0.159389u,-0.559046u)--(-0.297541u,-0.530638u)--(-0.055924u,-0.650458u)--cycle withcolor polygonfill1;
fill (0.655073u,0.064145u)--(0.449222u,0.063278u)--(0.659934u,-0.078098u)--cycle withcolor polygonfill2;
draw (0.094631u,0.545224u)--(0.021059u,0.555719u)--(0.267134u,0.370584u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (1.000000u,0.660330u)--(0.789789u,0.653681u)--(0.736645u,0.580404u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.214124u,0.654370u)--(-0.318717u,0.689131u)--(-0.449491u,0.515113u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.960693u,-0.260859u)--(0.756408u,-0.541653u)--(0.945203u,-0.473676u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.849069u,-0.474614u)--(-1.000000u,-0.595441u)--(-0.876137u,-0.689131u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.648673u,-0.129546u)--(-0.664078u,-0.358049u)--(-0.588580u,-0.310795u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.159389u,-0.559046u)--(-0.297541u,-0.530638u)--(-0.055924u,-0.650458u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.655073u,0.064145u)--(0.449222u,0.063278u)--(0.659934u,-0.078098u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.118603u,0.050781u)--(0.659934u,-0.078098u)--(0.960693u,-0.260859u)--(0.736645u,0.580404u)--(0.267134u,0.370584u)--(0.118603u,0.050781u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (0.118603u,0.050781u)--(-0.449491u,0.515113u)--(-0.648673u,-0.129546u)--(-0.849069u,-0.474614u)--(-0.297541u,-0.530638u)--(0.118603u,0.050781u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (0.659934u,-0.078098u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.960693u,-0.260859u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.736645u,0.580404u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.267134u,0.370584u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.449491u,0.515113u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.648673u,-0.129546u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.849069u,-0.474614u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.297541u,-0.530638u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.118603u,0.050781u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
