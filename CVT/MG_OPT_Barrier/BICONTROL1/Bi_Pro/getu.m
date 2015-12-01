function u0 = getu(us)
%-------------------------------------
% Compute initial guess for bilinear
% problem from solution of linear
% problem (us)
%-------------------------------------
global A
global f
global z
global nu
global IND
%-------------------------------------
% Form state for linear problem from 
% solution ustar of linear problem

y  = -A\(us+f);

% Form control u0 for bilinear problem
% corresponding to state y

w  = A*y+f;
u0 = -w./y;