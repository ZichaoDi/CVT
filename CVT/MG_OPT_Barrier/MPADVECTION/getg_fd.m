function g = getg_fd(v)

%-------------------------------------------------------------
% Compute the gradient g(v) via finite-differencing with
% real perturbations.
%-------------------------------------------------------------

h = 1.0e-5;
g = v(:);
f = getf(v);

dv = h * max(ones(size(v)), abs(v));

for j = 1:length(v);
  vh    = v;
  vh(j) = vh(j) + dv(j);
  fh    = getf(vh);
  g(j)  = (fh-f)/h;
end;
