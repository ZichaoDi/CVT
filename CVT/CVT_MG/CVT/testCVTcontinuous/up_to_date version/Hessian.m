function H= Hessian (x, g)
%%%%%%%%%%%%%%%%%##################
global bounds v_low v_up
%%%%%%%%%%%%%%%%%##################
%---------------------------------------------------------
% compute the product of the Hessian times the vector v;
% store result in the vector gv 
% (finite-difference version)
%---------------------------------------------------------
%%%%%%%%%%%%%%%%%##################
%## delta   = sqrt(accrcy)*(1 + xnorm);
 accrcy=eps^(1/3); H=[];
delta   = 1e-7;
%         h = eps^(1/3);
%         delta = sqrt(h)*(1+xnorm)/norm(v);
% size(v)
% size(x)
% size(delta)
nn=length(x);

vx=zeros(nn,1);vy=zeros(nn,1);
for i=1:nn/2
    t=0;
    for j=1:2:nn-1
        t=t+1;
        vx=zeros(nn,1);vy=zeros(nn,1);
        vx(j)=1;vy(j+1)=1;
      hgx      = x + delta*vx;
      hgy      = x + delta*vy;
[f, gvx] = sfun(hgx);
[f, gvy] = sfun(hgy);
gvxx      = (gvx(1:2:nn-1) - g(1:2:nn-1))/delta;
gvxy=(gvy(1:2:nn-1) - g(1:2:nn-1))/delta;
gvyx=(gvx(2:2:nn) - g(2:2:nn))/delta;
gvyy=(gvy(2:2:nn) - g(2:2:nn))/delta;
H(i,t)=gvxy(i)+gvyx(i)+gvxx(i)+gvyy(i);
    end
end
