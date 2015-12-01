function setup_prob
% Set up problem data for quadratics based on the 1-D Laplacian;
% there are implicit boundary conditions (=0) at the
% endpoints of the interval.

% Reset the random nmber generator to its default initial state.
rand('twister', 5489);

% A is 3-point 1-D Laplacian

n = 1023;
spA = 1; % Use spA=1 for a sparse A, spA=0 for a dense A

if (spA);
   e = ones(n,1);
   A = spdiags([e -2*e e], -1:1, n, n);
else
   A = 2*eye(n) - diag(ones(n-1,1),1) - diag(ones(n-1,1),-1);
end;

h = 1/(n+1);
A = A / (h^2);

%---------------------------------------------------------
% Form matrices and right-hand sides for test of Multigrid
% on a problem that we think will cause MG to do poorly
%---------------------------------------------------------
B = -A;
b = randn(n,1);

% Generate starting point

v0 = 20*rand(n,1);
save v0.mat v0;

% Form sub problems
  
for i=1:8;
    [b,B] = project(b,B);
end;
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function [bH,BH] = project(bh,Bh)

% save bh and Bh

nh = length(bh);

fname1=sprintf('AA%i',nh);
fname2=sprintf('A%i',nh);

save(fname1,'Bh');
save(fname2,'bh');

% Projection

nH = (nh-1)/2;
P  = getp(nH,nh);
BH = 0.5*P'*Bh*P;
bH = 0.5*P'*bh;
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function P = getp(nH,nh)
%---------------------------------
% Form projection matrix P
% to go from nh to nH variables
%---------------------------------
% Usage: P = getp(nH,nh)
%---------------------------------
xh = linspace(0, 1, nh+2)';
xH = linspace(0, 1, nH+2)';
yH = zeros(size(xH))';
U = zeros(nh,nH);

for j = 2:(nH+1)
	yH(j) = 1;
	yh = interp1(xH, yH, xh);
	U(:,j-1) = yh(2:(end-1));
	yH = 0*yH;
end

P = U;
return