function z2 = downdate(z,res_prob)
%--------------------------------------------------------------
% Downdate to a smaller problem
% Use explicit formulas for interpolation
%--------------------------------------------------------------
% Usage: z2 = downdate(z,res_prob)
%--------------------------------------------------------------
%--------------------------------------------------------------
global  IhH1 IhH2 IhH3 N 
n=length(z);
% if (mod(n,2)==0)
% z2=z(1:2:end-1);
% else
%    z2=z(1:2:end);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%BY INTERPOLATION MATRIX%%%%%%%%%%%
if(res_prob==3)
    z=sort(z);
z2=z(2:2:end);

else
if(n==N(1))
    IhH=IhH1;
elseif(n==N(2))
    IhH=IhH2;
    elseif(n==N(3))
    IhH=IhH3;
end
z2=IhH*z;
end