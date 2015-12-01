%function g=getg_adj(v)
%g=[2(v(1)-2*v(2))+4*v(1)^3;-4*(v(1)-2*v(2))];
function g = getg_adj (z)
%--------------------------------------------------------------
% objective gradient for soap-film minimal surface
%--------------------------------------------------------------
n2 = length(z);
nm = sqrt(n2);
zs = reshape(z,nm,nm);
nx = nm + 2;
ny = nm + 2;
%--------------------------------------------------------------
% set up boundary conditions
%--------------------------------------------------------------
[x,y,hx,hy,sx0,sy0,sx1,sy1] = getborder(nx,ny);
zs = [sx0
      sy0(2:(ny-1)) zs sy1(2:(ny-1))
      sx1];
%--------------------------------------------------------------
% calculate derivative values
%--------------------------------------------------------------
gs = 0*zs;
for i=2:ny;
for j=2:nx;
  tx = zs(i,j) - zs(i,j-1);
  ty = zs(i,j) - zs(i-1,j);
  val = 1 + tx^2/hx^2 + ty^2/hy^2;
  gs(i  ,j  ) = gs(i  ,j  ) + (tx/hx^2)/sqrt(val);
  gs(i  ,j  ) = gs(i  ,j  ) + (ty/hy^2)/sqrt(val);
  gs(i  ,j-1) = gs(i  ,j-1) - (tx/hx^2)/sqrt(val);
  gs(i-1,j  ) = gs(i-1,j  ) - (ty/hy^2)/sqrt(val);
end;
end;
%--------------------------------------------------------------
% reshape gradient array
%--------------------------------------------------------------
gs = gs(2:(ny-1),2:(nx-1));
g  = gs(:);
g  = g*hx*hy;
