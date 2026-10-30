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
fill (1.000000u,0.844561u)--(0.907275u,0.822208u)--(0.885212u,0.698343u)--cycle withcolor polygonfill2;
fill (-0.771988u,-0.587648u)--(-1.000000u,-0.676798u)--(-0.859982u,-0.733708u)--cycle withcolor polygonfill1;
fill (0.930880u,0.090740u)--(0.783139u,0.139067u)--(0.807103u,-0.094555u)--cycle withcolor polygonfill2;
fill (-0.047650u,0.518392u)--(-0.218933u,0.524979u)--(-0.231113u,0.421823u)--cycle withcolor polygonfill2;
fill (0.419053u,-0.851948u)--(0.280569u,-0.813542u)--(0.200316u,-0.925649u)--cycle withcolor polygonfill1;
fill (-0.773025u,0.101769u)--(-0.935573u,0.117952u)--(-0.774637u,-0.061627u)--cycle withcolor polygonfill1;
fill (0.478440u,-0.234055u)--(0.356646u,-0.233717u)--(0.455771u,-0.342939u)--cycle withcolor polygonfill1;
fill (-0.146774u,0.285751u)--(-0.283997u,0.284713u)--(-0.307007u,0.101475u)--cycle withcolor polygonfill2;
fill (0.256304u,0.925649u)--(0.271975u,0.744691u)--(0.406635u,0.764634u)--cycle withcolor polygonfill2;
draw (1.000000u,0.844561u)--(0.907275u,0.822208u)--(0.885212u,0.698343u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.771988u,-0.587648u)--(-1.000000u,-0.676798u)--(-0.859982u,-0.733708u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.930880u,0.090740u)--(0.783139u,0.139067u)--(0.807103u,-0.094555u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.047650u,0.518392u)--(-0.218933u,0.524979u)--(-0.231113u,0.421823u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.419053u,-0.851948u)--(0.280569u,-0.813542u)--(0.200316u,-0.925649u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.773025u,0.101769u)--(-0.935573u,0.117952u)--(-0.774637u,-0.061627u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.478440u,-0.234055u)--(0.356646u,-0.233717u)--(0.455771u,-0.342939u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.146774u,0.285751u)--(-0.283997u,0.284713u)--(-0.307007u,0.101475u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.256304u,0.925649u)--(0.271975u,0.744691u)--(0.406635u,0.764634u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.079736u,-0.029530u)--(-0.146774u,0.285751u)--(-0.047650u,0.518392u)--(0.406635u,0.764634u)--(0.885212u,0.698343u)--(0.783139u,0.139067u)--(-0.079736u,-0.029530u) withpen pencircle scaled routewidth withcolor routecolor2;
draw (-0.079736u,-0.029530u)--(0.356646u,-0.233717u)--(0.280569u,-0.813542u)--(-0.771988u,-0.587648u)--(-0.774637u,-0.061627u)--(-0.079736u,-0.029530u) withpen pencircle scaled routewidth withcolor routecolor1;
drawdot (-0.146774u,0.285751u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.047650u,0.518392u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.406635u,0.764634u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.885212u,0.698343u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.783139u,0.139067u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.356646u,-0.233717u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.280569u,-0.813542u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.771988u,-0.587648u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.774637u,-0.061627u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.079736u,-0.029530u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
