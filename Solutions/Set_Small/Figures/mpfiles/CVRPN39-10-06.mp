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
fill (0.542775u,0.060207u)--(0.585868u,0.110805u)--(0.485241u,0.140750u)--(0.388115u,0.083432u)--(0.541436u,-0.039836u)--(0.567107u,-0.005702u)--cycle withcolor polygonfill2;
fill (-0.315238u,-0.433182u)--(-0.540327u,-0.419857u)--(-0.468573u,-0.557316u)--(-0.419212u,-0.550302u)--cycle withcolor polygonfill1;
fill (0.832769u,-0.645925u)--(0.677001u,-0.635268u)--(0.783413u,-0.798873u)--cycle withcolor polygonfill2;
fill (-0.731235u,0.534926u)--(-0.717343u,0.609456u)--(-0.772330u,0.596466u)--(-0.832769u,0.407578u)--(-0.736768u,0.423044u)--(-0.694391u,0.443693u)--cycle withcolor polygonfill2;
fill (-0.124429u,1.000000u)--(-0.193065u,0.968565u)--(-0.275753u,0.970664u)--(-0.138953u,0.889229u)--(-0.123534u,0.953971u)--cycle withcolor polygonfill2;
fill (-0.584777u,-0.831987u)--(-0.746268u,-0.820212u)--(-0.641933u,-1.000000u)--cycle withcolor polygonfill1;
fill (-0.440696u,0.792262u)--(-0.599998u,0.820561u)--(-0.639499u,0.807121u)--(-0.586654u,0.654142u)--(-0.467018u,0.665464u)--cycle withcolor polygonfill2;
fill (0.015034u,0.522862u)--(-0.004831u,0.468855u)--(0.151537u,0.406058u)--cycle withcolor polygonfill2;
fill (0.667541u,-0.343990u)--(0.572719u,-0.345933u)--(0.509605u,-0.453951u)--(0.499840u,-0.498748u)--(0.669749u,-0.489150u)--cycle withcolor polygonfill2;
fill (-0.124424u,-0.417726u)--(-0.210604u,-0.386618u)--(-0.178016u,-0.572976u)--(-0.124770u,-0.564379u)--(-0.039895u,-0.595860u)--(0.001544u,-0.543712u)--cycle withcolor polygonfill1;
draw (0.542775u,0.060207u)--(0.585868u,0.110805u)--(0.485241u,0.140750u)--(0.388115u,0.083432u)--(0.541436u,-0.039836u)--(0.567107u,-0.005702u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.315238u,-0.433182u)--(-0.540327u,-0.419857u)--(-0.468573u,-0.557316u)--(-0.419212u,-0.550302u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.832769u,-0.645925u)--(0.677001u,-0.635268u)--(0.783413u,-0.798873u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.731235u,0.534926u)--(-0.717343u,0.609456u)--(-0.772330u,0.596466u)--(-0.832769u,0.407578u)--(-0.736768u,0.423044u)--(-0.694391u,0.443693u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.124429u,1.000000u)--(-0.193065u,0.968565u)--(-0.275753u,0.970664u)--(-0.138953u,0.889229u)--(-0.123534u,0.953971u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.584777u,-0.831987u)--(-0.746268u,-0.820212u)--(-0.641933u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.440696u,0.792262u)--(-0.599998u,0.820561u)--(-0.639499u,0.807121u)--(-0.586654u,0.654142u)--(-0.467018u,0.665464u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.015034u,0.522862u)--(-0.004831u,0.468855u)--(0.151537u,0.406058u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.667541u,-0.343990u)--(0.572719u,-0.345933u)--(0.509605u,-0.453951u)--(0.499840u,-0.498748u)--(0.669749u,-0.489150u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.124424u,-0.417726u)--(-0.210604u,-0.386618u)--(-0.178016u,-0.572976u)--(-0.124770u,-0.564379u)--(-0.039895u,-0.595860u)--(0.001544u,-0.543712u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.044507u,-0.024832u)--(-0.694391u,0.443693u)--(-0.467018u,0.665464u)--(-0.138953u,0.889229u)--(0.151537u,0.406058u)--(0.388115u,0.083432u)--(0.565599u,-0.358119u)--(0.677001u,-0.635268u)--(-0.044507u,-0.024832u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (-0.044507u,-0.024832u)--(-0.210604u,-0.386618u)--(-0.584777u,-0.831987u)--(-0.317738u,-0.433034u)--(-0.044507u,-0.024832u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.694391u,0.443693u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.467018u,0.665464u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.138953u,0.889229u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.151537u,0.406058u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.388115u,0.083432u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.565599u,-0.358119u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.677001u,-0.635268u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.210604u,-0.386618u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.584777u,-0.831987u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.317738u,-0.433034u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.044507u,-0.024832u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
