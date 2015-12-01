function zH=downdate(zh,res_prob)
%--------------------------------------------------------------
% Downdate to a smaller problem
% Use explicit formulas for interpolation
%--------------------------------------------------------------
% Usage: zH = downdate(zh,res_prob)
%--------------------------------------------------------------
% res_prob=1:downdate function variable and gradient;
% res_prob=2:downdate lambda and constraint for equality
% res_prob=3:downdate lambda and constraint for inequality
%-------------------------------------------------------------
global N
%--------------------------------------------------------------
nt=length(zh);

%--------------------------------------------------------------
if (isempty(zh))
    zH=[];
else
if(res_prob==1)
n2  = nt/2;
nm  = sqrt(n2);
j   = find(N==nm);
nm1 = N(j+1);
zs1  = reshape(zh(1:n2),nm,nm);zs2  = reshape(zh(n2+1:end),nm,nm);
nx  = nm + 2;
ny  = nm + 2;
%--------------------------------------------------------------
% set up boundary conditions
%--------------------------------------------------------------
 [x,y,hx,hy,sx0,sy0,sx1,sy1] = getborder(nx,ny);
zs1  = [sx0
      sy0(2:(ny-1)) zs1 sy1(2:(ny-1))
      sx1];
%--------------------------------------------------------------
zz1  = zeros(nm1+2,nm1+2);
%--------------------------------------------------------------
for i=2:(nm1+1); 
    ii = 2*(i-1)+1;
    for j=2:(nm1+1);
        jj = 2*(j-1)+1;
        zt = zs1(ii,jj);
        zt = zt + (zs1(ii-1,jj)+zs1(ii,jj-1)+zs1(ii,jj+1)+zs1(ii+1,jj)) / 2;
        zt = zt + (zs1(ii-1,jj-1)+zs1(ii-1,jj+1)+zs1(ii+1,jj-1)+zs1(ii+1,jj+1))/ 4;
        zz1(i,j) = zt / 4;
    end;
end;
%--------------------------------------------------------------
zz1  = zz1(2:(nm1+1),2:(nm1+1));
z1  = zz1(:);
zs2  = [sx0
      sy0(2:(ny-1)) zs2 sy1(2:(ny-1))
      sx1];
%--------------------------------------------------------------
zz2  = zeros(nm1+2,nm1+2);
%--------------------------------------------------------------
for i=2:(nm1+1); 
    ii = 2*(i-1)+1;
    for j=2:(nm1+1);
        jj = 2*(j-1)+1;
        zt = zs2(ii,jj);
        zt = zt + (zs2(ii-1,jj)+zs2(ii,jj-1)+zs2(ii,jj+1)+zs2(ii+1,jj)) / 2;
        zt = zt + (zs2(ii-1,jj-1)+zs2(ii-1,jj+1)+zs2(ii+1,jj-1)+zs2(ii+1,jj+1))/ 4;
        zz2(i,j) = zt / 4;
    end;
end;
%--------------------------------------------------------------
zz2  = zz2(2:(nm1+1),2:(nm1+1));
z2  = zz2(:);
zH=[z1;z2];
else
nm  = sqrt(nt);
j   = find(N==nm);
nm1 = N(j+1);
%--------------------------------------------------------------
zs  = reshape(zh,nm,nm);
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
zH  = zz(:);
end
end
    
