%---------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular].
%---------------------------------------------------------------
% MODIFIED: PRE-COMPUTE USTAR ON ALL LEVELS
%

global X N L V_L V_U
global bounds 
global ustar
global grad_type
global beta bounds_con spec_bd bind vvl vvu comp 
global lower upper miu extrap v_low v_up

%--------------------------------------------------
% Select technique for gradient calculation.
%

grad_type = 'adj';  % 'adj' = adjoint/exact
                    % 'fdr' = finite-difference [real]
                    % 'fdi' = finite-difference [complex]
					
%--------------------------------------------
% Initialize arrays for discretizations
%

beta  = 1;
x_L=0;
%x_U=0.9612;
x_U=1;
V_L=0;
V_U=0;
         
N        = [1151 575  287 143 71 35 17]; % discretization levels
N = [257 128];
%N=[575  287];
%N=71;
%N=[7 3];
%N=[35 17];
m        = length(N);
bind=[];
vvl=[];
vvu=[];


for i=1:length(N)
    hh(i)=1/(N(i)+1);
    uuu=laplacian_1d(N(i));
    L{i}= [uuu./hh(i)^2];
end
bounds   = 0;  % no bound constraints
bounds_con=1;
spec_bd=0; %%use the bounds setting from Toint
comp=1;
lower=1;
upper=0;
miu=0;
extrap=1; %% 1: Apply extrapolation for the initial estimate of Barrier method

for j = 1:m;
  X(1:N(j),j) = linspace(x_L,x_U,N(j))';
end;

for j=1:length(N);
    xx = X(1:N(j),j);
    t  = xx(2:end-1);
    ys = 40*( sin(pi*t) + 1.25*sin(4*pi*t) - 4*sin(6*pi*t) + 16*sin(8*pi*t) ) + 32*sin(16*pi*t);
    yy = [0; ys; 0];
    ustar{j} =yy;
end
[v_low,v_up] = set_bounds(1,0);
randn('state',0);
 v0=x_U*randn(N(1),1);
ind=find(v0<=v_low);
v0(ind)=v_low(ind)+0.5;
