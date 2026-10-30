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
fill (-0.165742u,-0.737775u)--(-0.145868u,-0.559469u)--(-0.507695u,-0.605730u)--(-0.551269u,-0.860272u)--(-0.546745u,-1.000000u)--(-0.139711u,-0.857743u)--cycle withcolor polygonfill1;
fill (0.551269u,-0.337139u)--(0.371961u,-0.213248u)--(0.383709u,-0.620606u)--cycle withcolor polygonfill1;
fill (-0.200102u,1.000000u)--(-0.401990u,0.952014u)--(-0.374640u,0.508532u)--(-0.146790u,0.817433u)--cycle withcolor polygonfill1;
draw (-0.165742u,-0.737775u)--(-0.145868u,-0.559469u)--(-0.507695u,-0.605730u)--(-0.551269u,-0.860272u)--(-0.546745u,-1.000000u)--(-0.139711u,-0.857743u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.551269u,-0.337139u)--(0.371961u,-0.213248u)--(0.383709u,-0.620606u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.200102u,1.000000u)--(-0.401990u,0.952014u)--(-0.374640u,0.508532u)--(-0.146790u,0.817433u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.348243u,-0.099005u)--(-0.145868u,-0.559469u)--(0.371961u,-0.213248u)--(-0.374640u,0.508532u)--(-0.348243u,-0.099005u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.145868u,-0.559469u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.371961u,-0.213248u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.374640u,0.508532u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.348243u,-0.099005u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
