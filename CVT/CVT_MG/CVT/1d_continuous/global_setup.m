function global_setup (n,v0)
%----------------------------------------------------------------------
% Perform "global" computations for optimization at a
% specified discretization (corresponding to n)
%----------------------------------------------------------------------
global  N minx maxx bdr bdl 
global CIHh CIhH

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nn=length(v0);
ind=find(nn==N);
a=1/2;b=1/2;
B=restric_residule(n);
B=B';
CIHh{ind}=[b*B];
CIhH{ind}=[a*restric_residule(n)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% v0=sort(v0);%
% bdl=v0(1)-2*(v0(1)-minx);
% bdr=2*(maxx-v0(end))+v0(end);

% [B]=coarsen_1d(v0);
% CIHh{ind}=[B];
% CIhH{ind}=[B'];
