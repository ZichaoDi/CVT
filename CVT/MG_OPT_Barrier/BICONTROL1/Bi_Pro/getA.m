function A = getA(n)
%--------------------------------------------
% Define the matrix A (the 5-point discrete
% Laplacian) for the optimal-control problems 
% defined in Vallejos and Borzi (2008).
%
% On the interval [0,1] x [0,1] where
% h = 1/(n+1), so n = # of interior points.
%--------------------------------------------
n1 = n + 1;
h  = 1 / n1;
R = 'S'; % S for a square mesh
G = numgrid(R,n+2);
A = delsq(G);
A = -A/h^2;