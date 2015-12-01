%----------------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular]
%----------------------------------------------------------------------
clear  functions
global bounds
global grad_type
global N maxx minx 
global tn_max_maxit updating nn
%----------------------------------------------------------------------
% Specify technique for calculating gradient
%----------------------------------------------------------------------
grad_type = 'adj';  % 'adj' = adjoint/exact
% 'fdr' = finite-difference [real]
% 'fdi' = finite-difference [complex]
%----------------------------------------------------------------------
% Initialize arrays for discretizations
%----------------------------------------------------------------------
maxx=1;
minx=0;
rand('state',0);
v0=sort(rand(nn,1));
nn=length(v0);
N=[];
if (mod(nn,2)==0)
%N=[nn,nn/2,nn/4,nn/8,nn/16];
for i=0:log2(nn)-1
    N(i+1)=nn/(2^i);
end
% %N=[nn,nn/2];
else
N=[nn,(nn-1)/2,((nn-1)/2)/2,(nn-1)/8];
%N=[511 255  127 63];
%N=[31,15];%,7,3];
%N=[nn,(nn-1)/2];
end

%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------

bounds = 0; % 0:no bounds on variables
tn_max_maxit = 25; % upper bound on # of inner conjugate-gradient iterations
updating=0;%%%%%%%%%0:uniform density simple update;1:linear interpolation update