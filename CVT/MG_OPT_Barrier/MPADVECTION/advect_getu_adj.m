function [w,dx,dt] = advect_getu_adj (u, x, v)

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

dx = x(2) - x(1);

dt = lambda*dx;

nx = length(x);

%------------------------------------
% We run out to time t_max = 1.
%

t_max = 1.0;
nt = ceil(t_max/dt);

t = linspace(0, nt, nt) * dt;

%-----------------------------------------------------------------
% Apply the adjoint of the forward-time, backwards space scheme.
%

w_now  = zeros(nx, 1);
w_next = zeros(nx, 1);

u_adj = zeros(nx,nt);

%------------------------------------
% Plot the terminal condition.

if (debug == 1)
  plot(x, u(:,nt));
  title('Terminal condition');
  shg;
  pause;
end

for n = nt:-1:1
  if (debug == 1)
	n
  end
  
  w_now = w_next + u(:,n);

  w_next(1) = lambda * c(2) * w_now(2);
  w_next(2:nx-1) = ...
   (1 - c(2:nx-1)*lambda) .* w_now(2:nx-1) + (c(3:nx)*lambda) .* w_now(3:nx);
  w_next(nx) = (1 - lambda * c(nx)) * w_now(nx);
  
  u_adj(:,n) = w_next;
        
  if (debug == 1)
    plot(x, u_adj(:,n));
    shg;
	pause;
	plot(x, u(:,n));
	pause;
  end
end

w = zeros(nx, 1);
w = u_adj(:,1);
