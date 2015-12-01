%----------------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular]
%----------------------------------------------------------------------
clear  functions
global bounds
global grad_type
global N maxx minx
%----------------------------------------------------------------------
% Specify technique for calculating gradient
%----------------------------------------------------------------------
grad_type = 'adj';  % 'adj' = adjoint/exact
% 'fdr' = finite-difference [real]
% 'fdi' = finite-difference [complex]
%----------------------------------------------------------------------
% Initialize arrays for discretizations
%----------------------------------------------------------------------
maxx=10;
minx=0;
v0=load('data33.txt');
v0=10*v0;
%v0=sort(rand(15,1));
% load vstar33;
% v0=vstar33;
nn=length(v0);
if (mod(nn,2)==0)
%N=[nn,nn/2,nn/4,nn/8];
N=[nn,nn/2];
else
N=[nn,(nn-1)/2,((nn-1)/2)/2,(nn-1)/8];
%N=[nn,(nn-1)/2];
end
%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------

bounds = 0; % no bounds on variables