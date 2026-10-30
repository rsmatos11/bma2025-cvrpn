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
fill (-0.789426u,-0.028684u)--(-0.920985u,-0.041487u)--(-0.979571u,-0.073738u)--cycle withcolor polygonfill1;
fill (-0.165535u,1.000000u)--(-0.157312u,0.909163u)--(-0.014498u,0.834919u)--cycle withcolor polygonfill2;
fill (-0.528024u,-0.823748u)--(-0.581379u,-0.859282u)--(-0.546424u,-1.000000u)--cycle withcolor polygonfill1;
fill (0.715387u,0.172474u)--(0.824966u,0.029766u)--(0.949799u,0.093605u)--cycle withcolor polygonfill2;
fill (-0.656421u,0.882885u)--(-0.726702u,0.801940u)--(-0.744800u,0.675791u)--cycle withcolor polygonfill1;
fill (0.812031u,0.694192u)--(0.833248u,0.612762u)--(0.979571u,0.432050u)--cycle withcolor polygonfill2;
fill (0.565352u,0.944235u)--(0.458759u,0.892982u)--(0.727802u,0.825599u)--cycle withcolor polygonfill2;
draw (-0.789426u,-0.028684u)--(-0.920985u,-0.041487u)--(-0.979571u,-0.073738u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.165535u,1.000000u)--(-0.157312u,0.909163u)--(-0.014498u,0.834919u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.528024u,-0.823748u)--(-0.581379u,-0.859282u)--(-0.546424u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.715387u,0.172474u)--(0.824966u,0.029766u)--(0.949799u,0.093605u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.656421u,0.882885u)--(-0.726702u,0.801940u)--(-0.744800u,0.675791u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.812031u,0.694192u)--(0.833248u,0.612762u)--(0.979571u,0.432050u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.565352u,0.944235u)--(0.458759u,0.892982u)--(0.727802u,0.825599u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.014954u,0.017610u)--(-0.744800u,0.675791u)--(-0.789426u,-0.028684u)--(-0.528024u,-0.823748u)--(0.014954u,0.017610u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (0.014954u,0.017610u)--(0.715387u,0.172474u)--(0.833248u,0.612762u)--(0.458759u,0.892982u)--(-0.014498u,0.834919u)--(0.014954u,0.017610u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.744800u,0.675791u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.789426u,-0.028684u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.528024u,-0.823748u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.715387u,0.172474u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.833248u,0.612762u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.458759u,0.892982u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.014498u,0.834919u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.014954u,0.017610u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
