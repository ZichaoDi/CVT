function z2 = downdate(z,res_prob)
%--------------------------------------------------------------
% Downdate to a smaller problem
% Use explicit formulas for interpolation
%--------------------------------------------------------------
% Usage: z2 = downdate(z,res_prob)
%--------------------------------------------------------------
global N
%--------------------------------------------------------------
n2  = length(z);
nm  = sqrt(n2);
j   = find(N==nm);
nm1 = N(j+1);
n21 = nm1*nm1;
%--------------------------------------------------------------
zs  = reshape(z,nm,nm);
nx  = nm + 2;
ny  = nm + 2;
%--------------------------------------------------------------
% set up boundary conditions
%--------------------------------------------------------------
if (res_prob);
  [x,y,hx,hy,sx0,sy0,sx1,sy1] = getborder_res(nx,ny);
else
  [x,y,hx,hy,sx0,sy0,sx1,sy1] = getborder(nx,ny);
end;
zs  = [sx0
      sy0(2:(ny-1)) zs sy1(2:(ny-1))
      sx1];
%--------------------------------------------------------------
zz  = zeros(nm1+2,nm1+2);
%--------------------------------------------------------------
for i=2:(nm1+1); 
    ii = 2*(i-1)+1;
    for j=2:(nm1+1);
        jj = 2*(j-1)+1;
        zt = zs(ii,jj);
        zt = zt + (zs(ii-1,jj)+zs(ii,jj-1)+zs(ii,jj+1)+zs(ii+1,jj)) / 2;
        zt = zt + (zs(ii-1,jj-1)+zs(ii-1,jj+1)+zs(ii+1,jj-1)+zs(ii+1,jj+1))/ 4;
        zz(i,j) = zt / 4;
    end;
end;
%--------------------------------------------------------------
zz  = zz(2:(nm1+1),2:(nm1+1));
z2  = zz(:);
