function [J,g] = sfun(u)
%-------------------------------------
% Define objective function and 
% gradient for the linear function
% in Vallejos and Borzi (2008)
%-------------------------------------
global Av fv zv nu IND
global N
%-------------------------------------
% Identify level and get data
%-------------------------------------
n2 = length(u);
n  = sqrt(n2);
k  = find(n==N);
A = Av{k};
f = fv{k};
z = zv{k};
%-------------------------------------
% Compute function and gradient
%-------------------------------------
if (IND==1); % linear problem
    y = -A\(u+f);
    p =  A\(y-z);
    g = nu*u-p;   
    J = 0.5*(y-z)'*(y-z) + 0.5*nu*u'*u;
else         % bilinear problem
    n2 = length(u);
    U  = spdiags(u,0,n2,n2);
    B  = A+U;
    y  = -B\f;
    p  =  B\(y-z);
    g  = nu*u - y.*p;
    J  = 0.5*(y-z)'*(y-z) + 0.5*nu*u'*u;
end;

% Scale problem

h = 1/(n+1);
% C = 1e4*h^2;
C = 1e4;
J = C*J;
g = C*g;