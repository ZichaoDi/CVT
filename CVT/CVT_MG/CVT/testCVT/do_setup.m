%----------------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular]
%----------------------------------------------------------------------
clear  functions
global bounds
global grad_type
global array N VXY mminx mmaxx mminy mmaxy globalN
global SVXY EVXY bdry
%----------------------------------------------------------------------
% Specify technique for calculating gradient
%----------------------------------------------------------------------
grad_type = 'adj';  % 'adj' = adjoint/exact
                    % 'fdr' = finite-difference [real]
                    % 'fdi' = finite-difference [complex]
%----------------------------------------------------------------------
% Initialize arrays for discretizations
%----------------------------------------------------------------------
array=load('voronoi_2d_binning_example.txt');
% array=load('dataset1e6.txt');
VXY=array(:,1:2);
SVXY=array(:,3);
EVXY=array(:,4);
mminx=min(VXY(:,1));mmaxx=max(VXY(:,1));
mminy=min(VXY(:,2));mmaxy=max(VXY(:,2));
bdry(1,:) = 100*[-0.5 -0.5  -0.5 -0.5  -0.5 -0.25 0.0 0.25 0.5 0.5 0.5  0.5  0.5  0.25 0.0 -0.25];
  bdry(2,:) = 100*[-0.5 -0.25 0.0 0.25 0.5 0.5  0.5 0.5  0.5 0.25 0.0 -0.25 -0.5 -0.5  -0.5 -0.5];
XY=load('coarsencentroid2.txt');
%XY=VXY(1:422,:);
XY=XY';
[XY1,B2,globalind1] = coarsen2_mlevel(XY,XY);
[XY2,B3,globalind2] = coarsen2_mlevel(XY1,XY1);
[XY3,B4,globalind3] = coarsen2_mlevel(XY2,XY2);
N=[4,3,2,1];%%discretization level
m=size(XY,2);

nmax = N(1);

v0=reshape(XY,2*m,1);
%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------
bounds = 0; % no bounds on variables