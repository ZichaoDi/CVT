%----------------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular]
%----------------------------------------------------------------------
clear  functions
global bounds
global grad_type
global N XY 
global  bdry mminx mmaxx mminy mmaxy 
%----------------------------------------------------------------------
% Specify technique for calculating gradient
%----------------------------------------------------------------------
grad_type = 'adj';  % 'adj' = adjoint/exact
                    % 'fdr' = finite-difference [real]
                    % 'fdi' = finite-difference [complex]
%----------------------------------------------------------------------
% Initialize arrays for discretizations
%----------------------------------------------------------------------
 XY = load(['data80.txt']);
%  XY = load(['zstar320.txt']);
%  XY=reshape(XY,2,320);
XY=XY';
mminx = 0; 
 mmaxx = 100;
 mminy = 0;
 mmaxy = 100; 
 %-------------------------------------------------------------------------
bdry(1,:) = 100*[0.0 0.0  0.0 0.0  0.0 0.25 0.5 0.75 1.0 1.0 1.0  1.0  1.0  0.25 0.5 0.75];
bdry(2,:) = 100*[0.0 0.25 0.5 0.75 1.0 1.0  1.0 1.0  1.0 0.0 0.25 0.5 0.75 0.0  0.0 0.0];
%%different data corresponding to different boundary%%
%--------------------------------------------------------------------------
  [XY2,bond,B0,B,globalind] = coarsen2_mlevel(XY,XY);
  [XY3,bond,B0,B,globalind]=coarsen2_mlevel(XY2,XY2);
  [XY4,bond,B0,B,globalind]=coarsen2_mlevel(XY3,XY3);
N=[4,3];%discretization level
m=size(XY,2);

nmax = m;

v0=reshape(XY,2*m,1);
%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------
bounds = 0; % no bounds on variables