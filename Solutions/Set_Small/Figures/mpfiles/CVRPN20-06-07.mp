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
fill (0.637322u,0.558113u)--(0.677824u,0.592584u)--(0.396142u,0.631213u)--(0.365123u,0.439552u)--(0.417394u,0.445244u)--(0.592604u,0.411766u)--(0.653102u,0.448793u)--cycle withcolor polygonfill2;
fill (0.010902u,0.998927u)--(-0.143008u,1.000000u)--(-0.126279u,0.790718u)--(0.027687u,0.742532u)--(0.133885u,0.727614u)--cycle withcolor polygonfill2;
fill (-0.229630u,-0.029402u)--(-0.320550u,-0.043393u)--(-0.465008u,-0.047699u)--(-0.468531u,-0.305534u)--(-0.376756u,-0.324825u)--(-0.340308u,-0.283749u)--(-0.265080u,-0.328952u)--cycle withcolor polygonfill1;
fill (-0.233804u,0.883281u)--(-0.299735u,0.925763u)--(-0.400536u,0.910598u)--(-0.427707u,0.867261u)--(-0.345847u,0.607971u)--(-0.302266u,0.641838u)--(-0.251000u,0.766592u)--cycle withcolor polygonfill2;
fill (0.301613u,0.017398u)--(0.213762u,0.161053u)--(0.174864u,0.219577u)--(0.086637u,-0.061130u)--(0.133645u,-0.086223u)--(0.210609u,-0.096853u)--(0.327550u,-0.040703u)--cycle withcolor polygonfill2;
fill (-0.644447u,-0.824227u)--(-0.677824u,-1.000000u)--(-0.447823u,-0.942768u)--cycle withcolor polygonfill1;
draw (0.637322u,0.558113u)--(0.677824u,0.592584u)--(0.396142u,0.631213u)--(0.365123u,0.439552u)--(0.417394u,0.445244u)--(0.592604u,0.411766u)--(0.653102u,0.448793u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.010902u,0.998927u)--(-0.143008u,1.000000u)--(-0.126279u,0.790718u)--(0.027687u,0.742532u)--(0.133885u,0.727614u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.229630u,-0.029402u)--(-0.320550u,-0.043393u)--(-0.465008u,-0.047699u)--(-0.468531u,-0.305534u)--(-0.376756u,-0.324825u)--(-0.340308u,-0.283749u)--(-0.265080u,-0.328952u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.233804u,0.883281u)--(-0.299735u,0.925763u)--(-0.400536u,0.910598u)--(-0.427707u,0.867261u)--(-0.345847u,0.607971u)--(-0.302266u,0.641838u)--(-0.251000u,0.766592u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.301613u,0.017398u)--(0.213762u,0.161053u)--(0.174864u,0.219577u)--(0.086637u,-0.061130u)--(0.133645u,-0.086223u)--(0.210609u,-0.096853u)--(0.327550u,-0.040703u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.644447u,-0.824227u)--(-0.677824u,-1.000000u)--(-0.447823u,-0.942768u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.338421u,0.142163u)--(-0.302266u,0.641838u)--(0.027687u,0.742532u)--(0.365123u,0.439552u)--(0.174864u,0.219577u)--(-0.338421u,0.142163u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (-0.338421u,0.142163u)--(-0.644447u,-0.824227u)--(-0.397911u,-0.045699u)--(-0.338421u,0.142163u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.302266u,0.641838u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.027687u,0.742532u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.365123u,0.439552u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.174864u,0.219577u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.644447u,-0.824227u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.397911u,-0.045699u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.338421u,0.142163u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
