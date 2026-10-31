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
fill (-0.108507u,0.625378u)--(-0.185378u,0.677708u)--(-0.304615u,0.696776u)--(-0.317538u,0.603917u)--(-0.289358u,0.463756u)--(-0.102729u,0.507227u)--cycle withcolor polygonfill2;
fill (1.000000u,-0.573559u)--(0.966302u,-0.482987u)--(0.747845u,-0.712765u)--(0.955674u,-0.657275u)--cycle withcolor polygonfill2;
fill (-0.318183u,0.161208u)--(-0.229717u,-0.082355u)--(-0.160747u,-0.075983u)--cycle withcolor polygonfill1;
fill (-0.734507u,-0.730041u)--(-0.846539u,-0.699938u)--(-0.829413u,-0.922351u)--(-0.702230u,-0.841355u)--cycle withcolor polygonfill1;
fill (-0.370173u,-0.292352u)--(-0.352723u,-0.500730u)--(-0.257934u,-0.474043u)--cycle withcolor polygonfill1;
fill (-0.880334u,-0.121318u)--(-1.000000u,-0.373330u)--(-0.883851u,-0.355856u)--cycle withcolor polygonfill1;
fill (0.487531u,0.922351u)--(0.518103u,0.828619u)--(0.582054u,0.717598u)--(0.711423u,0.686799u)--(0.700613u,0.785725u)--cycle withcolor polygonfill2;
draw (-0.108507u,0.625378u)--(-0.185378u,0.677708u)--(-0.304615u,0.696776u)--(-0.317538u,0.603917u)--(-0.289358u,0.463756u)--(-0.102729u,0.507227u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (1.000000u,-0.573559u)--(0.966302u,-0.482987u)--(0.747845u,-0.712765u)--(0.955674u,-0.657275u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.318183u,0.161208u)--(-0.229717u,-0.082355u)--(-0.160747u,-0.075983u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.734507u,-0.730041u)--(-0.846539u,-0.699938u)--(-0.829413u,-0.922351u)--(-0.702230u,-0.841355u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.370173u,-0.292352u)--(-0.352723u,-0.500730u)--(-0.257934u,-0.474043u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.880334u,-0.121318u)--(-1.000000u,-0.373330u)--(-0.883851u,-0.355856u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.487531u,0.922351u)--(0.518103u,0.828619u)--(0.582054u,0.717598u)--(0.711423u,0.686799u)--(0.700613u,0.785725u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.053061u,-0.130162u)--(-0.361771u,-0.392680u)--(-0.752754u,-0.725138u)--(-0.883851u,-0.355856u)--(-0.229717u,-0.082355u)--(-0.053061u,-0.130162u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (-0.053061u,-0.130162u)--(-0.102729u,0.507227u)--(0.582054u,0.717598u)--(0.966302u,-0.482987u)--(-0.053061u,-0.130162u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.361771u,-0.392680u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.752754u,-0.725138u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.883851u,-0.355856u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.229717u,-0.082355u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.102729u,0.507227u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.582054u,0.717598u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.966302u,-0.482987u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.053061u,-0.130162u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
