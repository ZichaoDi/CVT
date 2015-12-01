function ustar1 = downdate_u(ustar,nx1,nt1)
%--------------------------------------------------------------
% Downdate ustar(fine_grid) to a specified grid
%--------------------------------------------------------------
[nx,nt] = size(ustar);
x   = linspace(0,1,nx);
t   = linspace(0,1,nt);
x1  = linspace(0,1,nx1);
t1  = linspace(0,1,nt1);
%--------------------------------------------------------------
[x1,t1] = meshgrid(x1,t1);
[x ,t ] = meshgrid(x ,t );
ustar1 = interp2(x,t,ustar,x1,t1,'linear');
