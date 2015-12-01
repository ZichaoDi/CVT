function [f,g,F,G]=sfun(x)

global miu N v_low v_up


% %% Rosenbrock problem
f=sum((1-x(1:N-1)).^2+100.*(x(2:N)-x(1:N-1).^2).^2);
g=zeros(N,1);
g(1)=-2*(1-x(1))+200*(x(2)-x(1)^2)*(-2*x(1));
g(N)=200*(x(N)-x(N-1)^2);
g(2:N-1)=-2.*(1-x(2:N-1))+200.*(x(3:N)-x(2:N-1).^2).*(-2.*x(2:N-1))+200.*(x(2:N-1)-x(1:N-2).^2);
% %%=====================================================================

%%Trigonometric problem
% a=sum(cos(x));
% e=(1:N)';
% f=sum((N-a+e.*(1-cos(x))-sin(x)).^2);
% g=2*sum(N-a+e.*(1-cos(x))-sin(x)).*(sin(x))+2*(N-a...
%         +e.*(1-cos(x))-sin(x)).*(e.*sin(x)-cos(x));
% %%=====================================================================
F=f-miu*sum(log(x-v_low))-miu*sum(log(v_up-x));
G=g-miu*1./(x-v_low)+miu*1./(v_up-x);
  
    