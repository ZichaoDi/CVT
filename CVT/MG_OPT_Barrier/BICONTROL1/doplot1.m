function doplot(v,figno)
%--------------------------------------------------------------
% Plot results of soap-film minimal surface
%--------------------------------------------------------------
n2 = length(v);
nm = sqrt(n2);
vs = reshape(v,nm,nm);
nx = nm + 2;
ny = nm + 2;
%--------------------------------------------------------------
% set up boundary conditions
%--------------------------------------------------------------
[x,y,hx,hy] = getborder(nx,ny);
%--------------------------------------------------------------
figure(figno);
%--------------------------------------------------------------
[xx,yy] = meshgrid(min(x):.02:max(x),min(y):.02:max(y));
[x,y] = meshgrid(x,y);
vv = interp2(x,y,vs,xx,yy,'cubic');
surfl(xx,yy,vv);
shading interp
colormap pink 
%------------------------------------------------------