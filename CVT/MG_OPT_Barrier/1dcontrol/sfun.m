function [f,g,F,G] = sfun (v)

%----------------------------------------------------
% Compute the objective function and gradient.
%

global current_n N beta V_L V_U v_low v_up miu
global L X ustar A current_star


%
%#################################################################
%%%Objective function:f=1/2*(y-ustar)'*(y-ustar)+1/2*beta*u'*u 
%%% s.t. y=Au;
% j = find(N==current_n);
% D = logspace(2,4,current_n);
% %D = ones(current_n,1);
% D = diag(D);
% 
% A=L{j};
% x = X(1:N(j),j);
% current_y=A\v;
% current_ustar = ustar{j};
% r = (current_y - current_ustar);
% f=0.5*r'*r+0.5*beta*v'*(D*v);
% 
% g=A\r+beta*(D*v);
% 
% % H=(inv(A))^2+beta*D;
% % H = (H+H')/2;
% % ee=eig(H);
% % figure(41);plot(ee);
% % pause;

%##########################################################################
%% Objective function: f=1/2x'Ax-x'b;
%% Barrier funciton: B=f-miu*\sum(ln(c_i (x)))  where c_i(x)=x_i-l_i >=0
%%%%%%%####################################################################
j = find(N==current_n);
A=-L{j};
current_ustar = ustar{j};
f=0.5*v'*A*v-v'*current_ustar-v(end)*(V_U);
g=A*v-current_ustar;
g(end)=g(end)-V_U;
F=f-miu*sum(log(v-v_low));
G=g-miu*1./(v-v_low);



