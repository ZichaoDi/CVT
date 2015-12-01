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
%  load z1;
% XY=reshape(z1,2,80);
% XY=XY';

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
bdry(1,:) = 100*[0.0 0.0  0.0 0.0  0.0 0.25 0.5 0.75 1.0 1.0 1.0  1.0  1.0  0.25 0.5 0.75];
bdry(2,:) = 100*[0.0 0.25 0.5 0.75 1.0 1.0  1.0 1.0  1.0 0.0 0.25 0.5 0.75 0.0  0.0 0.0];
% bdry1 = [0.0 0.0  0.0 0.0  0.0 0.25 0.5 0.75 1.0 1.0 1.0  1.0  1.0  0.25 0.5 0.75];
% bdry2 = [0.0 0.25 0.5 0.75 1.0 1.0  1.0 1.0  1.0 0.0 0.25 0.5 0.75 0.0  0.0 0.0];
% bdry(1,:)=100*(mminx+(mmaxx-mminx)*bdry1);
% bdry(2,:)=100*(mminy+(mmaxy-mminy)*bdry2);
%----different data different boundary

[XY2,bond,B0,B,globalind] = coarsen2_mlevel(XY,XY);
%B1=B0*inv(B0'*B0);Bu=B0';
[XY3,bond,B0,B,globalind]=coarsen2_mlevel(XY2,XY2);
[XY4,bond,B0,B,globalind]=coarsen2_mlevel(XY3,XY3);

N=[4,3,2];%%discretization level

m=size(XY,2);

nmax = m;
% qq=size(XY2,2);
v0=reshape(XY,2*m,1);
%v1=reshape(XY2,2*qq,1);

% [f,g,Hessian1]=sfun(v1);
% Hessian=Bu*Hessian0*B1;
% Hessian(1,1)
% Hessian=Hessian(9:end,9:end);
% Hessian
% Hessian1

%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------
bounds = 1; % no bounds on variables