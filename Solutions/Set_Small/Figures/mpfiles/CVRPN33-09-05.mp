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
fill (-0.538155u,0.300098u)--(-0.722864u,0.133983u)--(-0.690692u,0.075779u)--cycle withcolor polygonfill1;
fill (-0.040067u,0.787001u)--(-0.125911u,0.892264u)--(-0.200823u,0.678753u)--cycle withcolor polygonfill1;
fill (-0.434973u,1.000000u)--(-0.567967u,0.964034u)--(-0.632324u,0.868488u)--(-0.501692u,0.770553u)--(-0.406890u,0.788306u)--cycle withcolor polygonfill1;
fill (-0.448189u,-0.787292u)--(-0.519365u,-0.832844u)--(-0.603799u,-0.892274u)--(-0.405656u,-1.000000u)--(-0.390683u,-0.912699u)--cycle withcolor polygonfill1;
fill (0.874923u,0.676472u)--(0.731641u,0.668274u)--(0.688025u,0.576827u)--(0.735532u,0.467099u)--(0.942583u,0.440865u)--cycle withcolor polygonfill2;
fill (0.045215u,-0.546778u)--(0.008124u,-0.494121u)--(-0.054865u,-0.632319u)--cycle withcolor polygonfill1;
fill (-0.468908u,-0.076045u)--(-0.614771u,-0.080638u)--(-0.563085u,-0.157108u)--(-0.354603u,-0.259212u)--(-0.367567u,-0.205328u)--cycle withcolor polygonfill1;
fill (0.178042u,0.239319u)--(0.005734u,0.312999u)--(-0.048724u,0.160268u)--(0.122382u,0.206329u)--cycle withcolor polygonfill2;
fill (-0.730911u,-0.673311u)--(-0.726309u,-0.590139u)--(-0.942583u,-0.784741u)--(-0.898104u,-0.827229u)--(-0.727998u,-0.781625u)--cycle withcolor polygonfill1;
draw (-0.538155u,0.300098u)--(-0.722864u,0.133983u)--(-0.690692u,0.075779u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.040067u,0.787001u)--(-0.125911u,0.892264u)--(-0.200823u,0.678753u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.434973u,1.000000u)--(-0.567967u,0.964034u)--(-0.632324u,0.868488u)--(-0.501692u,0.770553u)--(-0.406890u,0.788306u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.448189u,-0.787292u)--(-0.519365u,-0.832844u)--(-0.603799u,-0.892274u)--(-0.405656u,-1.000000u)--(-0.390683u,-0.912699u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.874923u,0.676472u)--(0.731641u,0.668274u)--(0.688025u,0.576827u)--(0.735532u,0.467099u)--(0.942583u,0.440865u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.045215u,-0.546778u)--(0.008124u,-0.494121u)--(-0.054865u,-0.632319u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.468908u,-0.076045u)--(-0.614771u,-0.080638u)--(-0.563085u,-0.157108u)--(-0.354603u,-0.259212u)--(-0.367567u,-0.205328u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.178042u,0.239319u)--(0.005734u,0.312999u)--(-0.048724u,0.160268u)--(0.122382u,0.206329u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.730911u,-0.673311u)--(-0.726309u,-0.590139u)--(-0.942583u,-0.784741u)--(-0.898104u,-0.827229u)--(-0.727998u,-0.781625u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.009924u,0.120922u)--(-0.200823u,0.678753u)--(-0.406890u,0.788306u)--(-0.538155u,0.300098u)--(-0.614771u,-0.080638u)--(-0.726309u,-0.590139u)--(-0.448189u,-0.787292u)--(0.008124u,-0.494121u)--(0.009924u,0.120922u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (0.009924u,0.120922u)--(0.122382u,0.206329u)--(0.735532u,0.467099u)--(0.009924u,0.120922u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.200823u,0.678753u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.406890u,0.788306u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.538155u,0.300098u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.614771u,-0.080638u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.726309u,-0.590139u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.448189u,-0.787292u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.008124u,-0.494121u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.122382u,0.206329u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.735532u,0.467099u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.009924u,0.120922u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
