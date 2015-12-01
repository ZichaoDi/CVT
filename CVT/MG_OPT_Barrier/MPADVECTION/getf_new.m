function f = getf(v)

%------------------------------------------------------------------
% Compute f(v) for the model advection least-squares problem.
%
% $Id: getf.m,v 0.0 2001/05/24 15:33:52 buckaroo Exp buckaroo $
%

global X N current_n ustar current_u
global alpha beta

%------------------------------------------------------------

j = find(N==current_n);
x = X(1:N(j),j);
nx = length(x);

[u,dx,dt] = advect_getu(x,v);
current_u = u;

[nx1 nt1] = size(current_u);
current_ustar = ustar{j};
r = (current_u - current_ustar);

d = zeros(size(current_u));
d(2:nx,:) = (r(2:nx,:) - r(1:nx-1,:))/dx;

% f = 0.5 * ( alpha * sum(sum(r.*r)) + beta * sum(sum(d.*d)) ) * (dx*dt);
  f = 0.5 * ( alpha * sum(sum(r.*r)) + beta * sum(sum(d.*d)) ) *     dt ;
