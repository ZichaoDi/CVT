function [Fvmg,Gvmg]=eval_merit(f,g,v,Aeq,beq,A,b,lb,ub,output,lambda,row);
%%%%%%%%=========================with constraints======================
%violation=max((A*v-b),0);
%m=length(A*v-b);
%figure(222);%subplot(2,1,1);plot(1:m,(A*v-b),'r.-');subplot(2,1,2);plot(1:m,lambda.ineqlin,'b.-');
%plot(1:m,lambda.ineqlin'*(A*v-b),'.');
% Fvmg=F+violation'*lambda.ineqlin+row/2*violation'*violation;
% Gvmg=G+A'*lambda.ineqlin+row*A'*violation;
violation_lower=max((-v+lb),0);
violation_upper=max((v-ub),0);
ind_upper=find(violation_upper~=0);
ind_lower=find(violation_lower~=0);
f_low = violation_lower'*lambda.lower+row/2*violation_lower'*violation_lower;
f_up = violation_upper'*lambda.upper+row/2*violation_upper'*violation_upper;
Fvmg = f+f_low+f_up;
if(isempty(ind_upper) & isempty(ind_lower) )
    disp('no violation')
    Gvmg=g;
elseif(isempty(ind_lower) &  ~isempty(ind_upper))
    disp('only upper violation')
    Gvmg=g+lambda.upper+row*violation_upper;
elseif(~isempty(ind_lower) & isempty(ind_upper))
    disp('only lower violation')
    Gvmg=g-lambda.lower-row*violation_lower;
else
    disp('lower and upper violation')
    Gvmg=g-lambda.lower-row*violation_lower+lambda.upper+row*violation_upper;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% m=length(v);
% figure(222);subplot(2,1,1);plot(1:m,(-v-0.01),'r.-');subplot(2,1,2);plot(1:m,lambda.lower,'b.-',1:m,lambda.upper,'ro-');
% figure(44);
% plot(1:m,violation.*lambda.lower,'.');
% % %%%====================================================================
%%%%=========================no constraints===========================
% Fvmg=F;
% Gvmg=G;
