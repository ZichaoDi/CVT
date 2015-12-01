%----------------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular]
%----------------------------------------------------------------------
% NOTE: THIS TEST PROBLEM CANNOT BE RUN WITH MULTIGRID UNLESS
%       'test_sep_plots = false' IS SET IN mgrid.m
%       BECAUSE OF TEST PLOTS UNRELATED TO THE SEPARABILITY TEST
%----------------------------------------------------------------------
clear  functions
global miu current_n
global N grad_type L hh substitute
%----------------------------------------------------------------------
% Specify technique for calculating gradient
%----------------------------------------------------------------------
grad_type = 'adj';  % 'adj' = adjoint/exact
                    % 'fdr' = finite-difference [real]
                    % 'fdi' = finite-difference [complex]
%----------------------------------------------------------------------
% Initialize arrays for discretizations
%----------------------------------------------------------------------
%N  = [2*(16*nn+31) 2*(8*nn+15) 2*(4*nn+7) 2*(2*nn+3) 2*(nn+1) nn];             % discretization levels
N=[63,31,15];
% #### MUST BE OF THE FORM: [2k+1  k]
%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------
nm = N(1);
for i=1:length(N)
    hh(i)=1/(N(i)+1);
    L{i} = [-delsq(numgrid('S',N(i)+2))/hh(i)^2];
end
n2 = nm*nm;
randn('state',0);
v0 =zeros(2*n2,1);
current_n = N(1);
[A,b,Aeq,beq,lb,ub,nonlcon,options]=setup_par(v0,10);% set up constriant for fmincon;
lambdaeq=[];lambdaineq=[];
miu=1e-4;
substitute=0;


