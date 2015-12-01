function c = advect_getc (x)

%-----------------------------------------------------------------
% This procedure computes the values of c(x) for an array of x
% values, where c(x) is the coefficient (velocity field) in
% the advection equation
%
%    u_{t}(x,t) + c(x) u_{x}(x,t) = 0.
%
% Arguments:
%  x  -> the x-mesh
%
%  c <- the values c(x) over the x-mesh

x = x(:);

c = ones(size(x));
