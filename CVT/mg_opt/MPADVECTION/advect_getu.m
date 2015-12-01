function [u,dx,dt] = advect_getu (x, v)

%--------------------------------------------------------------------
% This procedure computes u(x,t) for an array of x values, where
% u(x,t) is the solution of
%
%     u_{t}(x,t) + c(x) u_{x}(x,t) = 0  0 <= t <= T.
%
% with the initial condition
%
%       u(x,0) = u0(x).
%

debug = 0;  % This controls graphical monitoring of the time integration.

%------------------------------------
% Impose the stability condition
%
%   c(x) dt/dx <= 1.
%

c = advect_getc(x);

c_max = max(c);

lambda = 0.999999/c_max;
%lambda = 0.9/c_max;

dx = x(2) - x(1);

dt = lambda*dx;

nx = length(x);

%------------------------------------
% We run out to time t_max = 1.
%

t_max = 1.0;
nt = ceil(t_max/dt);

t = linspace(0, nt, nt) * dt;

%---------------------------------------------------
% Apply the forward-time, backwards space scheme.
%

u_now  = advect_getu0(x, v);
u_next = zeros(nx, 1);

u = zeros(nx, nt);

%---------------------------------------
% Plot the initial condition.

if (debug == 1)
  plot(x, u_now(1:nx)');
  axis([0 1 -1 1]);
  title('Initial condition');
  shg;
  pause;

%  M(n) = getframe;
end

for n = 1:nt
  if (debug == 1)
	n
  end

  u_next(2:nx) = ...
   (1 - c(2:nx)*lambda) .* u_now(2:nx) + (c(2:nx)*lambda) .* u_now(1:nx-1);

  u(:,n) = u_next;
  
  if (debug == 1)
    plot(x, u(:,n));
    axis([0 1 -1 1]);
    shg;
	pause;

%    M(n) = getframe;
  end

  u_now = u_next;
end

if (debug == 1)
%   movie(M);
end
