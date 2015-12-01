function doplot(it,v)
%--------------------------------------------------------------
% Plot results of linear control problem
%--------------------------------------------------------------
global n2
y=v(1:n2);
v=v(n2+1:end);
nm = sqrt(n2);
vs = reshape(v,nm,nm);
ys = reshape(y,nm,nm);
nx = nm + 2;
ny = nm + 2;
%--------------------------------------------------------------
% set up boundary conditions
%--------------------------------------------------------------
[x,y,hx,hy] = getborder(nx,ny);
%--------------------------------------------------------------
figure(3); subplot(2,1,2);
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
subplot(2,1,1);
vv = interp2(x,y,ys,xx,yy,'cubic');

surfl(xx,yy,vv);
shading interp
colormap pink 
%-------------------------------------------------------
T = sprintf('MG %1i',it);
title(T)