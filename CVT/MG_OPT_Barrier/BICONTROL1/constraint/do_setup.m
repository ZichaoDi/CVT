%----------------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular]
%----------------------------------------------------------------------
% NOTE: THIS TEST PROBLEM CANNOT BE RUN WITH MULTIGRID UNLESS
%       'test_sep_plots = false' IS SET IN mgrid.m
%       BECAUSE OF TEST PLOTS UNRELATED TO THE SEPARABILITY TEST
%----------------------------------------------------------------------
clear  functions
global bounds miu
global N grad_type A1 A2 A3 A4 A5 A6 h1 h2 h3 h4 h5 h6 L hh constraint nn
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
bounds = 0;         % 0 => no bounds
%----------------------------------------------------------------------
% Initialize arrays for discretizations
%----------------------------------------------------------------------
%N  = [2*(16*nn+31) 2*(8*nn+15) 2*(4*nn+7) 2*(2*nn+3) 2*(nn+1) nn];             % discretization levels
N=[63,31,15];
% #### MUST BE OF THE FORM: [2(k+1)  k]
%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------
% max_maxit = 50;
nm = N(1);
% h1=1/(N(1)+1);
% A1 = -delsq(numgrid('S',N(1)+2))/h1^2;
% h2=1/(N(2)+1);
% A2 = -delsq(numgrid('S',N(2)+2))/h2^2;
% h3=1/(N(3)+1);
% A3 = -delsq(numgrid('S',N(3)+2))/h3^2;
% h4=1/(N(4)+1);
% A4 = -delsq(numgrid('S',N(4)+2))/h4^2;
% h5=1/(N(5)+1);
% A5 = -delsq(numgrid('S',N(5)+2))/h5^2;
% h6=1/(N(6)+1);
% A6 = -delsq(numgrid('S',N(6)+2))/h6^2;
for i=1:length(N)
    hh(i)=1/(N(i)+1);
    L{i} = [-delsq(numgrid('S',N(i)+2))/hh(i)^2];
end
n2 = nm*nm;
randn('state',0);
v0 =zeros(2*n2,1);
a=0;sa=0;c=[];sc=[];lambdaeq=0;lambdaineq=0;
miu=1e-4;



