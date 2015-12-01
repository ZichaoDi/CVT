function  global_setup(n,v0)
%----------------------------------------------------------------------
% Perform "global" computations for optimization at a
% specified discretization (corresponding to n)
%----------------------------------------------------------------------
global  Hh hH  bond N current_n
m=length(v0)/2;
XY=reshape(v0,2,m);
[XY2,bond,B0,B,globalind] = coarsen2_mlevel(XY,XY);
B0=B;
B1=1/4*B;
in=find(current_n==N);
    Hh{in}=B0;
    hH{1}=B1;
