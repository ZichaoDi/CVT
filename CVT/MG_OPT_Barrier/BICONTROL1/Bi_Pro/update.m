function z = update(z2,res_prob)
%--------------------------------------------------------------
% Update to a larger problem: 
% Use explicit formulas for interpolation
%--------------------------------------------------------------
global N
%--------------------------------------------------------------
n2  = length(z2);
nm  = sqrt(n2);
j   = find(N==nm);
nm1 = N(j-1);
n21 = nm1*nm1;
%--------------------------------------------------------------
zs  = reshape(z2,nm,nm);
nx  = nm + 2;
ny  = nm + 2;
%--------------------------------------------------------------
% set up boundary conditions
%--------------------------------------------------------------
[x,y,hx,hy,sx0,sy0,sx1,sy1] = getborder(nx,ny);
zs  = [sx0
      sy0(2:(ny-1)) zs sy1(2:(ny-1))
      sx1];
%--------------------------------------------------------------
zz  = zeros(nm1+2,nm1+2);
%--------------------------------------------------------------
for i=1:(nx-1); 
    ii = 2*(i-1)+1;
    for j=1:(ny-1);
        jj = 2*(j-1)+1;
        zz(ii  ,jj  ) = zs(i  ,j  );
        zz(ii+2,jj  ) = zs(i+1,j  );
        zz(ii  ,jj+2) = zs(i  ,j+1);
        zz(ii+2,jj+2) = zs(i+1,j+1);
        
        zz(ii  ,jj+1) = (zs(i,j)   + zs(i,j+1)  ) / 2;
        zz(ii+1,jj  ) = (zs(i,j)   + zs(i+1,j)  ) / 2;
        zz(ii+1,jj+2) = (zs(i,j+1) + zs(i+1,j+1)) / 2;
        zz(ii+2,jj+1) = (zs(i+1,j) + zs(i+1,j+1)) / 2;
        
        zz(ii+1,jj+1) = (zs(i,j) + zs(i,j+1) + zs(i+1,j) + zs(i+1,j+1)) / 4;
    end;
end;
%--------------------------------------------------------------
zz  = zz(2:(nm1+1),2:(nm1+1));
z   = zz(:);
