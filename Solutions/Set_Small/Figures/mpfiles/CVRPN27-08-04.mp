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
fill (0.276792u,-0.067869u)--(0.094309u,0.022852u)--(0.124828u,-0.203083u)--(0.327622u,-0.174893u)--cycle withcolor polygonfill2;
fill (-0.333748u,0.098957u)--(-0.345280u,-0.090746u)--(-0.324869u,-0.016971u)--cycle withcolor polygonfill2;
fill (-0.361165u,0.913722u)--(-0.526153u,1.000000u)--(-0.627883u,0.882875u)--(-0.455733u,0.771091u)--cycle withcolor polygonfill2;
fill (0.793794u,0.415775u)--(0.726103u,0.481378u)--(0.660859u,0.295107u)--(0.830952u,0.335197u)--cycle withcolor polygonfill2;
fill (-0.129037u,-0.341563u)--(-0.357714u,-0.370669u)--(-0.188051u,-0.606522u)--(-0.082704u,-0.489448u)--cycle withcolor polygonfill1;
fill (0.398513u,-0.734750u)--(0.217263u,-0.743908u)--(0.331288u,-0.937198u)--cycle withcolor polygonfill2;
fill (0.838595u,-0.777439u)--(0.734421u,-0.866041u)--(0.786474u,-0.956469u)--(0.938549u,-1.000000u)--cycle withcolor polygonfill2;
fill (-0.916235u,0.715304u)--(-0.938549u,0.502300u)--(-0.695406u,0.533047u)--cycle withcolor polygonfill2;
draw (0.276792u,-0.067869u)--(0.094309u,0.022852u)--(0.124828u,-0.203083u)--(0.327622u,-0.174893u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.333748u,0.098957u)--(-0.345280u,-0.090746u)--(-0.324869u,-0.016971u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.361165u,0.913722u)--(-0.526153u,1.000000u)--(-0.627883u,0.882875u)--(-0.455733u,0.771091u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.793794u,0.415775u)--(0.726103u,0.481378u)--(0.660859u,0.295107u)--(0.830952u,0.335197u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.129037u,-0.341563u)--(-0.357714u,-0.370669u)--(-0.188051u,-0.606522u)--(-0.082704u,-0.489448u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.398513u,-0.734750u)--(0.217263u,-0.743908u)--(0.331288u,-0.937198u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.838595u,-0.777439u)--(0.734421u,-0.866041u)--(0.786474u,-0.956469u)--(0.938549u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.916235u,0.715304u)--(-0.938549u,0.502300u)--(-0.695406u,0.533047u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.033347u,-0.157431u)--(-0.333748u,0.098957u)--(-0.695406u,0.533047u)--(-0.455733u,0.771091u)--(0.660859u,0.295107u)--(0.772163u,-0.833940u)--(0.398513u,-0.734750u)--(0.124828u,-0.203083u)--(-0.033347u,-0.157431u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (-0.033347u,-0.157431u)--(-0.129037u,-0.341563u)--(-0.033347u,-0.157431u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.333748u,0.098957u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.695406u,0.533047u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.455733u,0.771091u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.660859u,0.295107u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.772163u,-0.833940u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.398513u,-0.734750u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.124828u,-0.203083u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.129037u,-0.341563u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.033347u,-0.157431u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
