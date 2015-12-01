%---------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular].
%---------------------------------------------------------------
% MODIFIED: PRE-COMPUTE USTAR ON ALL LEVELS
%

global X N
global bounds v_low v_up bounds_con
global vstar ustar
global grad_type
global test_low test_up
global alpha beta
global my_gradient
global max_maxit
global V_LOW V_UP spec_bd update_tn bind vvl vvu spec_bd

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

N        = [1025 513 257 129 65 33 17];          % discretization levels
%N        = [129 65 33 17]; % discretization levels
N = [129 65];
%N=[33,17];
m        = length(N);
nmax     = N(1);

nv       = N(1);
rand('state',0);
vstar    = 1 + 0.10*rand(nv,1);
V_LOW    = -1e20*ones(nmax,m);
V_UP     =  1e20*ones(nmax,m);
% V_LOW    = -1e20*ones(nmax,m);
% V_UP     =  0.1*ones(nmax,m);
for i=1:length(N);
    nn = N(i);
    V_LOW(nn,i) = 0;
    V_UP(nn,i) = 0;
end;
%bounds   = 0;  % no bound constraints
bounds   = 1;  % bound constraints in use
bounds_con=1;
bind=[];
vvl=[];
vvu=[];
spec_bd=0; %%use the bounds setting from Toint
X        = zeros(nmax,m);         % independent variables
x_L      = 0;
x_U      = 1;
% ustar  = zeros(nmax,m);         % target solution [SEE BELOW]

%----------------------------------------------------------------------
% Compute the independent-variable arrays and the target solution
% arrays on all the grids.
%

for j = 1:m;
    X(1:N(j),j) = linspace(x_L,x_U,N(j))';
end;

x = X(1:N(1),1);
%vv= x.*(1-x);
%plot(vv)
vstar  =vstar .*x .* (1-x);% 
vstar(1) = 0;
vstar(N(1)) = 0;

% v0 = vstar;
% vstar = 0*vstar;

% figure(1); %subplot(3,3,1); 
% plot(X(:,1), vstar); title('v_{*}'); ...
% 	axis([0 1 0 1.5]);

%############################################################
% Form ustar on all levels
%############################################################

% Version 1: compute ustar on all levels, based on X
% [this does not match the old version of getf]

%for j=1:length(N);
%    [ustar{j},dx,dt] = advect_getu( X(1:N(j),j), vstar );
%end;

% Version 2: compute ustar on level 1, then downdate
% to other levels [as in old version of getf]

[uu,dx,dt] = advect_getu( X(1:N(1),1), vstar );
ustar{1} = uu;
for j=2:length(N);
    xx = X(1:N(j),j);
    [uu,dx,dt] = advect_getu(xx,vstar);
    current_u = uu;
    [nx1 nt1] = size(current_u);
    ustar{j} = downdate_u(ustar{1},nx1,nt1);
end;
%plot(X(1:N(1),1), ustar{1});
% for i=1:length(N)
%     subplot(3,3,i);plot(X(1:N(i),i), ustar{i});end
% [nx nt] = size(ustar{1});
%ustar = ustar + 0.05 * rand(nx,nt);

%---------------------------------------------
% Specify initial guess for optimization.
%v0 = rand(nv,1);
v0 = zeros(nv,1);
Aeq=[];beq=[];
a=[];c=[];
[nonl_in,nonl_eq]=mycon(v0);
