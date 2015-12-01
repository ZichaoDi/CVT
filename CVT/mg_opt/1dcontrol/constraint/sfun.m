function [f, g] = sfun (v)

%----------------------------------------------------
% Compute the objective function and gradient.
%

global X N current_n ustar
global beta

%------------------------------------------------------------

j = find(N==current_n);
x = X(1:N(j),j);
nx = length(x);
D = logspace(2,4,current_n)';
y=v(1:nx);
u=v(nx+1:end);
current_ustar = ustar{j};
r = (y - current_ustar);
f=1/2*r'*r+beta/2*u'*(D.*u);

g=[r;beta*D.*u];
