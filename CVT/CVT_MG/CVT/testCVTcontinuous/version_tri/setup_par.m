function [A,b,Aeq,beq,lb,ub,options]=setup_par(x,nit,res_prob);
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
options = optimset('Algorithm','active-set','Display','iter', 'GradObj','off', 'Hessian','lbfgs','MaxIter',nit, 'TolFun', 1e-8);%,'PlotFcns',@optimplotfval
%options = optimset('Algorithm','trust-region-reflective','Display','iter', 'GradObj','on', 'Hessian','off','MaxIter',nit, 'TolFun', 1e-8);%,'PlotFcns',@optimplotfval
