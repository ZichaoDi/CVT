function [A,b,Aeq,beq,lb,ub,options]=setup_par(x,nit);
%to set up all the parameters for the command 'fmincon'
%-------------------------------------------------------------constraint
n=length(x);
A = []; b = [];Aeq=[];beq=[];
for i=1:n
    lb(i)=-inf;ub(i)=inf;
end
% lb(n)=0;
% ub(n)=0;
lb=lb';
ub=ub';
options = optimset('Algorithm','interior-point','Display','iter', 'GradObj','on', 'Hessian','lbfgs','MaxIter',nit, 'TolFun', 1e-8);%,'PlotFcns',@optimplotfval
