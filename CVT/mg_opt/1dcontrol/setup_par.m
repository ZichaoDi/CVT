function [A,b,Aeq,beq,lb,ub,options]=setup_par(x,nit,res_prob);
%to set up all the parameters for the command 'fmincon'
%-------------------------------------------------------------constraint
global L N bounds_con  spec_bd
global lb ub current_n bind vvl vvu
j=find(N==length(x));
if(bounds_con==0)
    lb=[];ub=[];
else
    if(res_prob & spec_bd)
        [lb,ub] = set_bounds1(j,bind,vvl,vvu);
    else
        [lb,ub] = set_bounds(j);
    end
%     ub=5*ones(n,1);
%     lb=-0.01*ones(n,1);%ub=[];
    %lb=-1.00*ones(n,1);%ub=[];
end
Aeq=[];
beq=[];
A=[];b=[];
% A=[-eye(n)];%;eye(n)];
% b=[0.01*ones(n,1)];%;zeros(n,1)];

options = optimset('Algorithm','interior-point','InitBarrierParam',0.1,'Display','iter', 'GradObj','on', 'Hessian','lbfgs','MaxIter',nit, 'TolFun', 1e-8);%,'AlwaysHonorConstraints','none''PlotFcns',@optimplotx ,InitBarrierParam
