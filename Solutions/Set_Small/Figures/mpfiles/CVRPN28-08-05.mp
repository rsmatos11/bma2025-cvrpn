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
fill (0.367058u,-0.499816u)--(0.308161u,-0.569302u)--(0.518703u,-0.606698u)--(0.598390u,-0.567816u)--cycle withcolor polygonfill2;
fill (0.900152u,0.287022u)--(0.941849u,0.322876u)--(0.658815u,0.161918u)--(0.653622u,0.087545u)--(0.919620u,0.211130u)--cycle withcolor polygonfill2;
fill (0.938851u,0.646690u)--(0.909740u,0.735285u)--(0.673481u,0.594138u)--(0.818178u,0.495743u)--(0.875806u,0.500568u)--cycle withcolor polygonfill2;
fill (-0.846892u,-0.131698u)--(-0.941849u,-0.098447u)--(-0.907651u,-0.367725u)--(-0.692313u,-0.235339u)--cycle withcolor polygonfill1;
fill (-0.299344u,0.901332u)--(-0.517289u,1.000000u)--(-0.522288u,0.812115u)--(-0.311674u,0.756874u)--cycle withcolor polygonfill2;
fill (0.258121u,-0.753427u)--(0.002950u,-0.727674u)--(0.263960u,-0.923602u)--cycle withcolor polygonfill2;
fill (-0.311034u,-0.275604u)--(-0.279814u,-0.356207u)--(-0.166126u,-0.517013u)--cycle withcolor polygonfill1;
fill (0.616919u,-0.810950u)--(0.404810u,-0.930249u)--(0.477046u,-1.000000u)--(0.582567u,-0.980501u)--cycle withcolor polygonfill2;
draw (0.367058u,-0.499816u)--(0.308161u,-0.569302u)--(0.518703u,-0.606698u)--(0.598390u,-0.567816u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.900152u,0.287022u)--(0.941849u,0.322876u)--(0.658815u,0.161918u)--(0.653622u,0.087545u)--(0.919620u,0.211130u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.938851u,0.646690u)--(0.909740u,0.735285u)--(0.673481u,0.594138u)--(0.818178u,0.495743u)--(0.875806u,0.500568u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.846892u,-0.131698u)--(-0.941849u,-0.098447u)--(-0.907651u,-0.367725u)--(-0.692313u,-0.235339u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.299344u,0.901332u)--(-0.517289u,1.000000u)--(-0.522288u,0.812115u)--(-0.311674u,0.756874u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.258121u,-0.753427u)--(0.002950u,-0.727674u)--(0.263960u,-0.923602u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.311034u,-0.275604u)--(-0.279814u,-0.356207u)--(-0.166126u,-0.517013u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.616919u,-0.810950u)--(0.404810u,-0.930249u)--(0.477046u,-1.000000u)--(0.582567u,-0.980501u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.007611u,-0.187734u)--(0.258121u,-0.753427u)--(0.518210u,-0.866469u)--(0.556230u,-0.588387u)--(0.658815u,0.161918u)--(0.673481u,0.594138u)--(-0.311674u,0.756874u)--(0.007611u,-0.187734u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (0.007611u,-0.187734u)--(-0.311034u,-0.275604u)--(-0.692313u,-0.235339u)--(0.007611u,-0.187734u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (0.258121u,-0.753427u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.518210u,-0.866469u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.556230u,-0.588387u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.658815u,0.161918u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.673481u,0.594138u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.311674u,0.756874u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.311034u,-0.275604u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.692313u,-0.235339u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.007611u,-0.187734u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
