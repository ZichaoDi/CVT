%----------------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular]
%----------------------------------------------------------------------
% NOTE: THIS TEST PROBLEM CANNOT BE RUN WITH MULTIGRID UNLESS
%       'test_sep_plots = false' IS SET IN mgrid.m
%       BECAUSE OF TEST PLOTS UNRELATED TO THE SEPARABILITY TEST
%----------------------------------------------------------------------
clear  functions
global bounds
global N grad_type
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
N  = [31 15 7 3];             % discretization levels
% #### MUST BE OF THE FORM: [2(k+1)  k]
%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------
% max_maxit = 50;
nm = N(1);
n2 = nm*nm;
randn('state',0);
v0 = ones(n2,1) + 10.0*randn(n2,1);


