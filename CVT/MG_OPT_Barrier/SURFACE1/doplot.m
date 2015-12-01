function doplot(it,v)
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
[x,y,hx,hy,sx0,sy0,sx1,sy1] = getborder(nx,ny);
vs = [sx0
      sy0(2:(ny-1)) vs sy1(2:(ny-1))
      sx1];
%--------------------------------------------------------------
figure(1); subplot(3,3,it+1);
%--------------------------------------------------------------
[xx,yy] = meshgrid(min(x):.02:max(x),min(y):.02:max(y));
[x,y] = meshgrid(x,y);
vv = interp2(x,y,vs,xx,yy,'cubic');

surfl(xx,yy,vv);
shading interp
colormap pink 
%-------------------------------------------------------
T = sprintf('MG %1i',it);
title(T)
