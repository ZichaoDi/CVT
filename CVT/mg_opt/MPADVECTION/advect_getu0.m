function a = advect_getu0 (x, v)

%-----------------------------------------------------------------
% This procedure computes the initial value for the advection 
% equation
%
%    u_{t}(x,t) + a(x) u_{x}(x,t) = 0.
%
% Arguments:
%  x   -> the x-mesh
%  v   -> the model parameters
%
%  a   <- the values a(x) over the x-mesh
%

n = length(v);
x = x(:);

a = v;
