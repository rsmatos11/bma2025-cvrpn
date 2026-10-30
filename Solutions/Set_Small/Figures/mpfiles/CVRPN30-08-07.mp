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
fill (0.802948u,-0.871575u)--(0.739718u,-0.754318u)--(0.622146u,-0.915229u)--(0.722259u,-0.959349u)--(0.821486u,-1.000000u)--cycle withcolor polygonfill1;
fill (-0.955584u,1.000000u)--(-0.878009u,0.812249u)--(-0.767452u,0.842572u)--cycle withcolor polygonfill2;
fill (-0.260100u,0.918640u)--(-0.338587u,0.899483u)--(-0.372631u,0.800696u)--(-0.310788u,0.716035u)--cycle withcolor polygonfill2;
fill (0.918470u,-0.221821u)--(0.924517u,-0.172214u)--(0.881717u,-0.175820u)--(0.779665u,-0.157583u)--(0.793082u,-0.399919u)--(0.905972u,-0.412321u)--(0.955584u,-0.345734u)--cycle withcolor polygonfill1;
fill (-0.364216u,-0.273366u)--(-0.444322u,-0.301146u)--(-0.467949u,-0.270644u)--(-0.506962u,-0.261640u)--(-0.581959u,-0.353437u)--(-0.533976u,-0.472989u)--(-0.428472u,-0.458529u)--cycle withcolor polygonfill1;
fill (-0.497496u,-0.615990u)--(-0.457685u,-0.565217u)--(-0.644162u,-0.556956u)--(-0.688657u,-0.587427u)--(-0.590111u,-0.784749u)--(-0.472224u,-0.709867u)--cycle withcolor polygonfill1;
fill (0.186544u,0.889327u)--(0.182319u,0.941642u)--(0.011413u,0.727272u)--(0.049281u,0.701087u)--(0.230051u,0.708282u)--(0.202379u,0.738754u)--cycle withcolor polygonfill2;
fill (0.557947u,-0.233746u)--(0.388925u,-0.345088u)--(0.415283u,-0.396694u)--(0.514650u,-0.398062u)--(0.584479u,-0.444512u)--cycle withcolor polygonfill1;
draw (0.802948u,-0.871575u)--(0.739718u,-0.754318u)--(0.622146u,-0.915229u)--(0.722259u,-0.959349u)--(0.821486u,-1.000000u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.955584u,1.000000u)--(-0.878009u,0.812249u)--(-0.767452u,0.842572u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (-0.260100u,0.918640u)--(-0.338587u,0.899483u)--(-0.372631u,0.800696u)--(-0.310788u,0.716035u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.918470u,-0.221821u)--(0.924517u,-0.172214u)--(0.881717u,-0.175820u)--(0.779665u,-0.157583u)--(0.793082u,-0.399919u)--(0.905972u,-0.412321u)--(0.955584u,-0.345734u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.364216u,-0.273366u)--(-0.444322u,-0.301146u)--(-0.467949u,-0.270644u)--(-0.506962u,-0.261640u)--(-0.581959u,-0.353437u)--(-0.533976u,-0.472989u)--(-0.428472u,-0.458529u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.497496u,-0.615990u)--(-0.457685u,-0.565217u)--(-0.644162u,-0.556956u)--(-0.688657u,-0.587427u)--(-0.590111u,-0.784749u)--(-0.472224u,-0.709867u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (0.186544u,0.889327u)--(0.182319u,0.941642u)--(0.011413u,0.727272u)--(0.049281u,0.701087u)--(0.230051u,0.708282u)--(0.202379u,0.738754u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge2;
draw (0.557947u,-0.233746u)--(0.388925u,-0.345088u)--(0.415283u,-0.396694u)--(0.514650u,-0.398062u)--(0.584479u,-0.444512u)--cycle withpen pencircle scaled edgewidth withcolor polygonedge1;
draw (-0.001644u,0.006760u)--(-0.428472u,-0.458529u)--(-0.457685u,-0.565217u)--(0.739718u,-0.754318u)--(0.793082u,-0.399919u)--(0.518776u,-0.259550u)--(-0.001644u,0.006760u) withpen pencircle scaled routewidth withcolor routecolor1;
draw (-0.001644u,0.006760u)--(-0.767452u,0.842572u)--(-0.359058u,0.782115u)--(0.011413u,0.727272u)--(-0.001644u,0.006760u) withpen pencircle scaled routewidth withcolor routecolor2;
drawdot (-0.428472u,-0.458529u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.457685u,-0.565217u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.739718u,-0.754318u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.793082u,-0.399919u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (0.518776u,-0.259550u) withpen pencircle scaled visitpointsize withcolor visitpoint1;
drawdot (-0.767452u,0.842572u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.359058u,0.782115u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (0.011413u,0.727272u) withpen pencircle scaled visitpointsize withcolor visitpoint2;
drawdot (-0.001644u,0.006760u) withpen pencircle scaled depotsize withcolor depotcolor;
mrg := 0.1cm;
setbounds currentpicture to (llcorner currentpicture - (mrg,mrg))--(lrcorner currentpicture + (mrg,-mrg))--(urcorner currentpicture + (mrg,mrg))--(ulcorner currentpicture + (-mrg,mrg))--cycle;
endfig;
end;
