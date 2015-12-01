function global_setup (n,v0)
%----------------------------------------------------------------------
% Perform "global" computations for optimization at a 
% specified discretization (corresponding to n)
%----------------------------------------------------------------------
global  IHh1 IHh2  IHh3 IHh4  IhH1 IhH2 IhH3 IhH4 N minx maxx bdr bdl
bdl=minx;
bdr=maxx;
v0=sort(v0);
[B]=coarsen_1d(v0);
a=1/4;b=1;
if (n==N(1))
    IhH1=a*restric_residule(n);
    IHh1=b*B;
elseif(n==N(2))
    IhH2=a*restric_residule(n);
    IHh2=b*B;
elseif(n==N(3))
    IhH3=a*restric_residule(n);
    IHh3=b*B;
elseif (n==N(4))
    IhH4=a*restric_residule(n);
    IHh4=b*B;
end