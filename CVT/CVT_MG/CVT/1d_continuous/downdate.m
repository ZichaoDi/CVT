function z2 = downdate(z,res_prob)
%--------------------------------------------------------------
% Downdate to a smaller problem
% Use explicit formulas for interpolation
%--------------------------------------------------------------
% Usage: z2 = downdate(z,res_prob)
%--------------------------------------------------------------
%--------------------------------------------------------------
global  CIhH N 
n=length(z);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%BY INTERPOLATION MATRIX%%%%%%%%%%%
if(res_prob==3)
    z=sort(z);
    z2=z(2:2:end);
%     %     for i=1:n/2
%     %         z2(i)=(z(2*i)+z(2*i-1))/2;
%     %     end
%     %     z2 = z2(:);
else
    ind=find(n==N);
    IhH=cell2mat(CIhH(ind));
    z2=IhH*z;
end