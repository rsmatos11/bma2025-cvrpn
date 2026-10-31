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
fill (-0.204871u,-0.339387u)--(-0.389440u,-0.354392u)--(-0.258490u,-0.444094u)--cycle withcolor polygonfill1;
fill (-0.716616u,0.090601u)--(-0.862304u,0.059474u)--(-0.777350u,-0.087205u)--cycle withcolor polygonfill2;
fill (0.006462u,-0.113777u)--(-0.165881u,-0.131627u)--(-0.133446u,-0.325643u)--(0.012393u,-0.259017u)--cycle withcolor polygonfill1;
fill (0.005219u,-0.820996u)--(-0.118646u,-0.899458u)--(0.080543u,-0.973669u)--cycle withcolor polygonfill1;
fill (-0.225337u,-0.800433u)--(-0.285609u,-0.790465u)--(-0.366732u,-0.779637u)--(-0.336111u,-0.953749u)--(-0.267891u,-1.000000u)--(-0.187570u,-0.873542u)--cycle withcolor polygonfill1;
fill (0.829305u,0.009596u)--(0.734971u,0.096653u)--(0.665067u,0.067866u)--(0.676730u,-0.057349u)--(0.768786u,-0.099064u)--(0.862304u,-0.027449u)--cycle withcolor polygonfill2;
fill (0.452810u,-0.446517u)--(0.405770u,-0.413696u)--(0.298166u,-0.492911u)--(0.503388u,-0.516396u)--(0.524242u,-0.473521u)--cycle withcolor polygonfill1;
fill (-0.327763u,0.922966u)--(-0.431518u,1.000000u)--(-0.520135u,0.855825u)--(-0.469780u,0.826056u)--cycle withcolor polygonfill2;
fill (0.447451u,0.480163u)--(0.235121u,0.543374u)--(0.377511u,0.365181u)--(0.469153u,0.407792u)--cycle withcolor polygonfill2;
draw (-0.204871u,-0.339387u)--(-0.389440u,-0.354392u)--(-0.258490u,-0.444094u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.716616u,0.090601u)--(-0.862304u,0.059474u)--(-0.777350u,-0.087205u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.006462u,-0.113777u)--(-0.165881u,-0.131627u)--(-0.133446u,-0.325643u)--(0.012393u,-0.259017u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.005219u,-0.820996u)--(-0.118646u,-0.899458u)--(0.080543u,-0.973669u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.225337u,-0.800433u)--(-0.285609u,-0.790465u)--(-0.366732u,-0.779637u)--(-0.336111u,-0.953749u)--(-0.267891u,-1.000000u)--(-0.187570u,-0.873542u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.829305u,0.009596u)--(0.734971u,0.096653u)--(0.665067u,0.067866u)--(0.676730u,-0.057349u)--(0.768786u,-0.099064u)--(0.862304u,-0.027449u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.452810u,-0.446517u)--(0.405770u,-0.413696u)--(0.298166u,-0.492911u)--(0.503388u,-0.516396u)--(0.524242u,-0.473521u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.327763u,0.922966u)--(-0.431518u,1.000000u)--(-0.520135u,0.855825u)--(-0.469780u,0.826056u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.447451u,0.480163u)--(0.235121u,0.543374u)--(0.377511u,0.365181u)--(0.469153u,0.407792u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.096481u,-0.048850u)--(-0.716616u,0.090601u)--(-0.469780u,0.826056u)--(0.377511u,0.365181u)--(0.665067u,0.067866u)--(0.096481u,-0.048850u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (0.096481u,-0.048850u)--(-0.141382u,-0.278176u)--(-0.204871u,-0.339387u)--(-0.225337u,-0.800433u)--(0.005219u,-0.820996u)--(0.298166u,-0.492911u)--(0.096481u,-0.048850u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.716616u,0.090601u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.469780u,0.826056u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.377511u,0.365181u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.665067u,0.067866u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.141382u,-0.278176u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.204871u,-0.339387u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.225337u,-0.800433u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.005219u,-0.820996u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.298166u,-0.492911u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.096481u,-0.048850u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
