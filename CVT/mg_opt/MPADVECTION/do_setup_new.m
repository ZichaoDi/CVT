%---------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular].
%

global X N
global bounds v_low v_up bounds_con
global vstar ustar
global grad_type
global test_low test_up
global alpha beta
global my_gradient
global max_maxit
global V_LOW V_UP  

%--------------------------------------------------
% Select technique for gradient calculation.
%

grad_type = 'adj';  % 'adj' = adjoint/exact
                    % 'fdr' = finite-difference [real]
                    % 'fdi' = finite-difference [complex]
					
%--------------------------------------------
% Initialize arrays for discretizations
%

alpha = 1;
beta  = 1;
max_maxit = 50;

N        = [129 65 33 17] ; %257         % discretization levels
N=[1025 513 257 129 65 33];
m        = length(N);
nmax     = N(1);

nv       = N(1);
rand('state',0);
vstar    = 1 + 0.10*rand(nv,1);
V_LOW    = -1e20*ones(nmax,m);
V_UP     =  1e20*ones(nmax,m);
for i=1:length(N);
   nn = N(i);
   V_LOW(nn,i) = 0;
   V_UP(nn,i) = 0;
end;
 bounds   = 0;  % no bound constraints
%bounds   = 1;  % bound constraints in use
bounds_con=1;
X        = zeros(nmax,m);         % independent variables
x_L      = 0;
x_U      = 1;
% ustar    = zeros(nmax,m);         % target solution

%----------------------------------------------------------------------
% Compute the independent-variable arrays and the target solution
% arrays on all the grids.
%

for j = 1:m;
  X(1:N(j),j) = linspace(x_L,x_U,N(j))';
end;

x = X(1:N(1),1);
vstar = vstar .* x .* (1-x);
vstar(1) = 0;
vstar(N(1)) = 0;

% v0 = vstar;
% vstar = 0*vstar;

% figure(1); subplot(3,3,1); plot(X(:,1), vstar); title('v_{*}'); ...
%	axis([0 1 0 1.5]);

for j=1:length(N);
    [uu,dx,dt] = advect_getu( X(1:N(j),j), vstar );
    ustar{j} = uu;
end;

[nx nt] = size(ustar);
%ustar = ustar + 0.05 * rand(nx,nt);

%---------------------------------------------
% Specify initial guess for optimization.
%

v0 = zeros(nv,1);
%v0 = rand(nv,1);
a=[];c=[];
[nonl_in,nonl_eq]=mycon(v0);
