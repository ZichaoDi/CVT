%----------------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular]
%----------------------------------------------------------------------
% NOTE: THIS TEST PROBLEM CANNOT BE RUN WITH MULTIGRID UNLESS
%       'test_sep_plots = false' IS SET IN mgrid.m
%       BECAUSE OF TEST PLOTS UNRELATED TO THE SEPARABILITY TEST
%----------------------------------------------------------------------
clear  functions
global bounds miu
global N grad_type L hh constraint
global bounds_con nonlinear spec_bd bind vvl vvu
% global max_maxit
%----------------------------------------------------------------------
% Specify technique for calculating gradient
%----------------------------------------------------------------------
grad_type = 'adj';  % 'adj' = adjoint/exact
                    % 'fdr' = finite-difference [real]
                    % 'fdi' = finite-difference [complex]
%----------------------------------------------------------------------
% Bounds on variables?
%----------------------------------------------------------------------
bounds =0;         % 0 => no bounds\
bounds_con=1;
spec_bd=0; %%use the bounds setting from Toint
constraint=0; %% 0 is linear control; 1 is bilear control

%----------------------------------------------------------------------
% Initialize arrays for discretizations
%----------------------------------------------------------------------
%nn=6;
%N  = [2*(16*nn+31) 2*(8*nn+15) 2*(4*nn+7) 2*(2*nn+3) 2*(nn+1) nn];             % discretization levels
N=[63,31 15,7, 3 ];
N=[31,15];
N        = [287 143 71 35 17 8];
%N=[15,7];
%N=[7,3];
%N        = [1151 575  287 143 71 35 17]; 
% #### MUST BE OF THE FORM: [2k+1  k]
bind=[];
vvl=[];
vvu=[];
%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------
% max_maxit = 50;
nm = N(1);
for i=1:length(N)
    hh(i)=1/(N(i)+1);
    L{i} = [-delsq(numgrid('S',N(i)+2))/hh(i)^2];
end
n2 = nm*nm;
randn('state',0);
v0=randn(n2,1);
%v0 =zeros(n2,1);
%  load vstar;
%  v0=vstar;
% load fc15;
% load y;
% v0=-(fc+A1*y)./y;
a=[];c=[];
[nonl_in,nonl_eq]=mycon(v0); 
miu=1e-4;
nonlinear=0;



