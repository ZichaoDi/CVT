function [A,b,Aeq,beq,lb,ub,nonlcon,options]=setup_par(a,sa,c,sc,nit);
%to set up all the parameters for the command 'fmincon'
%-------------------------------------------------------------constraint
 global current_n 
% global L N x1 y1 n2 hx;
% nm=current_n;%%mesh size;
% ind=find(nm==N);
% A=cell2mat(L(ind));
% n2=nm^2; 
% nx = nm + 2;
% ny = nm + 2;
% [x1,y1,hx,hy] = getborder(nx,ny);
% f1=sin(2*pi*x1)*sin(2*pi*y1);  %%
% %f1=ones(size(f1));
% 
% fc=reshape(f1,n2,1);clear f1;
% cu=spdiags(-1.*ones(n2,1),0,n2,n2);
% Aeq=[-A,cu];
% clear cu;
% beq=fc;
%------------------------------------------------------------------------
A = []; b = [];Aeq=[];beq=[];nonlcon=[];
for i=1:current_n
    lb(i)=-INF;ub(i)=INF;
end
options = optimset('Algorithm','interior-point','Display','iter', 'GradObj','on', 'Hessian','lbfgs','MaxIter',nit, 'TolFun', 1e-8);%
