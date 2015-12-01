function [Fvmg,Gvmg]=eval_merit(F,G,v,Aeq,beq,A,b,output,lambda,row);
%%%%%%%%=========================with constraints======================
% %violation=max((A*v-b),0);
% %m=length(A*v-b);
% %figure(222);%subplot(2,1,1);plot(1:m,(A*v-b),'r.-');subplot(2,1,2);plot(1:m,lambda.ineqlin,'b.-');
% %plot(1:m,lambda.ineqlin'*(A*v-b),'.');
% % Fvmg=F+violation'*lambda.ineqlin+row/2*violation'*violation;
% % Gvmg=G+A'*lambda.ineqlin+row*A'*violation;
% violation=max((-v-0.01),0);
% Fvmg=F+violation'*lambda.lower+row/2*violation'*violation;
% if(violation==0)
%     Gvmg=G;
% else
% Gvmg=G-lambda.lower-row*violation;
% end
% m=length(v);
% % figure(222);subplot(2,1,1);plot(1:m,(-v-0.01),'r.-');subplot(2,1,2);plot(1:m,lambda.lower,'b.-',1:m,lambda.upper,'ro-');
% % figure(44);
% % plot(1:m,violation.*lambda.lower,'.');
% % %%%====================================================================
%%%%=========================no constraints===========================
Fvmg=F;
Gvmg=G;
