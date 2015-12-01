function  global_setup(n,v0)
%----------------------------------------------------------------------
% Perform "global" computations for optimization at a
% specified discretization (corresponding to n)
%----------------------------------------------------------------------
global    bond bb IHh IhH XY1
m=length(v0)/2;
XY=reshape(v0,2,m);
[XY1,bond,B0,B,globalind] = coarsen2_mlevel(XY,XY);
in=find(B==1);
%B1=0*B;B1(in)=1;
B1=B;
bb=size(bond,2);
%B1=B0*inv(B0'*B0);%%%downdate modification to B*(B'*B)
IHh{n}=1/4*B0;
IhH{n}=B1;
%XY1=reshape(XY1,size(XY1,2)*2,1);
