function [B]=coarsen_1d(XY)
global maxx minx

XY=sort(XY);
n=length(XY);
if (mod(n,2)==0)
m=n/2;
else
m=(n-1)/2;
end
B=zeros(n,m);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%Linearly Interpolation%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%coarse from the first node%%%%%%%%%%%%
% for i=1:n
%     if(mod(i,2)~=0)
%         B(i,(i+1)/2)=1;
%     elseif(i==n)
%          B(i,i/2)=(maxx-XY(i))/(maxx-XY(i-1));
%         B(i,(i+2)/2)=(XY(i)-XY(i-1))/(maxx-XY(i-1));
%     else
%         B(i,i/2)=(XY(i+1)-XY(i))/(XY(i+1)-XY(i-1));
%         B(i,(i+2)/2)=(XY(i)-XY(i-1))/(XY(i+1)-XY(i-1));
%     end
% end
%%%%%%%%%%%%%%%%%%%%%%%coarse from the second node%%%%%%%%%%
for i=1:n
    if(mod(i,2)==0)
        B(i,(i)/2)=1;
     elseif(i==1)
        B(i,1)=(XY(1)-minx)/(XY(2)-minx) ;  
    elseif(i==n)
        B(i,m)=(maxx-XY(n))/(maxx-XY(n-1));
    else
        B(i,(i-1)/2)=(XY(i+1)-XY(i))/(XY(i+1)-XY(i-1));
        B(i,(i+1)/2)=(XY(i)-XY(i-1))/(XY(i+1)-XY(i-1));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%-------------------------------%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AMG%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% H=Hessian1d(XY);
% for i=1:n
%     if(mod(i,2)==0)
%         B(i,(i)/2)=1;
%     elseif(i==1)
%         B(i,(i+1)/2)=-H(i,i+1)/H(i,i);
%     elseif(i==n)
%         B(i,(i-1)/2)=-H(i,i-1)/H(i,i);
%     else
%         B(i,(i-1)/2)=-H(i,i-1)/H(i,i);
%         B(i,(i+1)/2)=-H(i,i+1)/H(i,i);
%     end
% end
% %%%%%%%%%%%%%%%%%%%%%%%%---------------------------------%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%simple multigrid interpolation matrix%%%%%%%%%%%
% for i=1:n+2
%     if(mod(i,2)~=0)
%         B(i,(i+1)/2)=1;
%     elseif(i==n+2)
%         B(i,(i)/2)=1/2;
%     else
%         B(i,(i)/2)=1/2;
%         B(i,(i+2)/2)=1/2;
%     end
% end