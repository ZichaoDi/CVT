%----------------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular]
%----------------------------------------------------------------------
clear  functions
global bounds
global grad_type
global N XY
global  bdry mminx mmaxx mminy mmaxy lind
%----------------------------------------------------------------------
% Specify technique for calculating gradient
%----------------------------------------------------------------------
grad_type = 'adj';  % 'adj' = adjoint/exact
% 'fdr' = finite-difference [real]
% 'fdi' = finite-difference [complex]
%----------------------------------------------------------------------
% Initialize arrays for discretizations
%----------------------------------------------------------------------
rand('state',0);
XY=100*rand(30,2);
%XY=load('data80.txt');
XY=XY';
% mminx = floor(min(XY(1,:)));
% mmaxx = ceil(max(XY(1,:)));
% mminy = floor(min(XY(2,:)));
% mmaxy = ceil(max(XY(1,:)));
mminx=0;
mmaxx=100;
mminy=0;
mmaxy=100;

%-------------------------------------------------------------------------
% bdry(1,:) = mmaxx*[0.0 0.0  0.0 0.0  0.0 0.25 0.5 0.75 1.0 1.0 1.0  1.0  1.0  0.25 0.5 0.75];
% bdry(2,:) = mmaxy*[0.0 0.25 0.5 0.75 1.0 1.0  1.0 1.0  1.0 0.0 0.25 0.5 0.75 0.0  0.0 0.0];
% bdry1 = [0.0 0.0  0.0 0.0  0.0 0.25 0.5 0.75 1.0 1.0 1.0  1.0  1.0  0.25 0.5 0.75];
% bdry2 = [0.0 0.25 0.5 0.75 1.0 1.0  1.0 1.0  1.0 0.0 0.25 0.5 0.75 0.0  0.0 0.0];
bdry(1,:)=[mminx mminx mminx mminx mminx 0.25*mmaxx 0.5*mmaxx 0.75*mmaxx mmaxx mmaxx mmaxx mmaxx mmaxx 0.25*mmaxx 0.5*mmaxx 0.75*mmaxx];

bdry(2,:)=[mminy 0.25*mmaxy 0.5*mmaxy 0.75*mmaxy mmaxy mmaxy mmaxy mmaxy mmaxy mminy 0.25*mmaxy 0.5*mmaxy 0.75*mmaxy mminy mminy mminy];
% bdry(1,:)=100*(mminx+(mmaxx-mminx)*bdry1);
% bdry(2,:)=100*(mminy+(mmaxy-mminy)*bdry2);
%----different data different boundary

[XY2,bond,B0,B,globalind] = coarsen2_mlevel(XY,XY);
[XY3,bond,B0,B,globalind]=coarsen2_mlevel(XY2,XY2);
[XY4,bond,B0,B,globalind]=coarsen2_mlevel(XY3,XY3);

N=[length(XY),length(XY2)];%,length(XY3)%discretization level
m=size(XY,2);

nmax = m;

v0=reshape(XY,2*m,1);
%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------
bounds = 0; % 0:no bounds on variables