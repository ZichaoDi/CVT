function [f, g] = sfun (v)

%----------------------------------------------------
% Compute the objective function and gradient.
%

global current_n N beta V_L V_U v_low v_up
global L X ustar bounds lambdaind  lambdatn
global test_v_in_fmincon v_after_r

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
%%Objective function: f=1/2x'Ax-x'b;
%%%%#######################################################################
%%%%#plot the variable changing in 'fmincon'
% if(test_v_in_fmincon==1)
%     load vs2s17;
%     %figure(11);plot(1:current_n,v,'bo-',1:current_n,vs1s1151,'g*-');
% figure(11);plot(1:current_n,v_after_r,'r.-',1:current_n,v,'b.-',1:current_n,vs2s17,'go-'); title('red: v_after_r; blue: current_v; green: vstar')
% pause;
% end
%%%%%%%####################################################################
j = find(N==current_n);
A=-L{j};
current_ustar = ustar{j};
f=0.5*v'*A*v-v'*current_ustar-v(end)*(V_U);
g=A*v-current_ustar;
g(end)=g(end)-V_U;
% load compare
% load cvdzc;
% if(j==2)
% figure(456);plot(1:N(2),v,'r.-',1:N(2),compare,'b.-',1:N(2),cvdzc,'m.-'); title('red: v; blue: compare');%pause;
% end
% load current_fnl2;
% f     = f - v'*current_fnl2;
% g     = g - current_fnl2;



