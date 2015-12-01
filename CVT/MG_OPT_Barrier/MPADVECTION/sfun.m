function [f, g] = sfun (v)

%----------------------------------------------------
% Compute the objective function and gradient.
%

global grad_type current_n N
global my_gradient

%
%--------------------------------------------------------------

f = getf(v);

if (grad_type == 'adj');
  g = getg_adj(v);        % via adjoint
end;

if (grad_type == 'fdr');
  g = getg_fd (v);        % via finite-difference [real]
end;

if (grad_type == 'fdi');
  g = getg_fdi(v);        % via finite-difference [complex]
end;

% iid=find(current_n==N);
% f=f*1e3;%2^(i-1);
% g=g*1e3;%2^(i-1);

return;

%------------------------------------------------------------------
g1 = getg_fdc (v);        % via finite-difference [real]

if (norm(g - g1) > 0.1 * norm(g1))
  g
  g1
  (g - g1)./(abs(g))
  norm((g-g1)./(abs(g)))
  norm(g1)
  error('Ack!');
end;

return;

[m,n] = size(g);
my_gradient = g;
if (m>0); error('Hi'); end;
