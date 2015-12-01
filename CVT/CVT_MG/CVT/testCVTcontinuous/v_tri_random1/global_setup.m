function  global_setup(n,v0)
%----------------------------------------------------------------------
% Perform "global" computations for optimization at a
% specified discretization (corresponding to n)
%----------------------------------------------------------------------
global  Hh hH  bond N current_n 
m=length(v0)/2;
XY=reshape(v0,2,m);
[XY2,bond,B0,B1,B,globalind] = coarsen_mlevel(XY);
in=find(current_n==N);
if(n==0)
    in=in+1;
end
    Hh{in}=4*B;
    hH{1}=B0;
%%=============================================
%%% coarsen without boudary points
% [XY2,B,globalind] = coarsen_inner(XY);
% in=find(current_n==N);
% if(n==0)
%     in=in+1;
% end
%     Hh{in}=4*B;
%     hH{1}=B;