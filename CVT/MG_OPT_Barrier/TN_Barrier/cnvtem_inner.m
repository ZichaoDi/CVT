function conv = cnvtem_inner(x,low,up,sfun)
%---------------------------------------------------------------
% inner convergence test for barrier function with specific miu
%---------------------------------------------------------------
global upper lower eps3 add_term lambda
[f, g, F, G] = feval (sfun, x);
dist=0.1;
if(upper && ~lower)
    lambda=zeros(size(x));
    ind=find(abs(up-x)<=dist);
    lambda(ind)=-g(ind);
elseif(lower && ~upper)
    lambda=zeros(size(x));
    ind=find(abs(x-low)<=dist);
    lambda(ind)=g(ind);
else
    lambda1=zeros(size(g));
    lambda2=zeros(size(g));
    ind1=find(abs(x-low)<=dist);
    lambda1(ind1)=g(ind1);
    ind2=find(abs(up-x)<=dist);
    lambda2(ind2)=-g(ind2);
    lambda=[lambda1;lambda2];
end
if (add_term)
    eps3=1e-5;
else
    eps3=1e-3;
end
eps4=1e-6;
conv=norm(G,'inf')/(1+abs(F))<=eps3 & min(lambda)>=-eps4;


