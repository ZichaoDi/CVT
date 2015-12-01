function [A,b,Aeq,beq,lb,ub,options]=setup_par(x,nit);
%to set up all the parameters for the command 'fmincon'
%-------------------------------------------------------------constraint
global L N
n=length(x)/2;
j=find(N==n);
Aeq=[L{j},-eye(n)];
beq=zeros(n,1);
%A=[];b=[];
A=[zeros(n,n),-eye(n);zeros(n,n),eye(n)];
b=[0.01*ones(n,1);zeros(n,1)];
lb=[];ub=[];
options = optimset('Algorithm','interior-point','Display','iter', 'GradObj','on', 'Hessian','lbfgs','MaxIter',nit, 'TolFun', 1e-8);%,'PlotFcns',@optimplotfval
