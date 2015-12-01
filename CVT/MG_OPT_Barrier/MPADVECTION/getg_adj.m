function g = getg_adj(v)

%----------------------------------------------------------
% Compute the gradient g(v) via the adjoint approach.
%
% $Id: getg_adj.m,v 0.0 2001/05/24 15:33:52 buckaroo Exp buckaroo $
%

global X N current_n ustar current_u
global alpha beta

%----------------------------------------------------------

j = find(N==current_n);
x = X(1:N(j),j);
nx = length(x);

dx = x(2) - x(1);

g = 0*v(:);

[nx nt] = size(current_u);
dt = (1/(nt-1));

[nx1 nt1] = size(current_u);
current_ustar = ustar{j};
r = (current_u - current_ustar);

d = zeros(size(current_u));
d(1,:) = -(r(2,:) - r(1,:))/(dx^2);
d(2:nx-1,:) = (-r(3:nx,:) + 2*r(2:nx-1,:) - r(1:nx-2,:))/(dx^2);
d(nx,:) = (r(nx,:) - r(nx-1,:))/(dx^2);

%r = (alpha*r + beta*d) * (dx*dt);
r = (alpha*r + beta*d) *     dt ;

g = advect_getu_adj (r, x, v);

return;

%------------------------------------------------------------------
w = rand(size(g));
[u,dx,dt] = advect_getu (x, w);
if ( abs(dot(u(:),r(:))-dot(g,w)) > 0.01 * abs(dot(u(:),r(:))) )
  dot(u(:),r(:))
  dot(g,w)
  error('Ack!');
end;

