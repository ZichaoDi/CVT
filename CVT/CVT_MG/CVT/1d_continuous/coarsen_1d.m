function [B]=coarsen_1d(XY)
global maxx minx updating

XY=sort(XY);
n=length(XY);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%Linearly Interpolation%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%coarse from the first node%%%%%%%%%%%%
% for i=1:n
%     if(mod(i,2)~=0)
%         B(i,(i+1)/2)=1;
%     elseif(i==n)
%          B(i,i/2)=(maxx-XY(i))/(maxx-XY(i-1,1));
%         B(i,(i+2)/2)=(XY(i)-XY(i-1))/(maxx-XY(i-1));
%     else
%         B(i,i/2)=(XY(i+1)-XY(i))/(XY(i+1)-XY(i-1));
%         B(i,(i+2)/2)=(XY(i)-XY(i-1))/(XY(i+1)-XY(i-1));
%     end
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%-------------------------------%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%coarse from the second node%%%%%%%%%%
if(updating)
if (mod(n,2)==0)
m=n/2+1;
else
m=(n-1)/2+2;
end
B=zeros(n,m);
for i=1:n
    if(mod(i,2)==0)
        B(i,(i+2)/2)=1;
     elseif(i==1)
         B(i,1)=(XY(2)-XY(1))/((XY(2)-minx)+(XY(1)-minx));
        B(i,(i+1)/2+1)=2*(XY(1)-minx)/(2*(XY(1)-minx)+XY(2)-XY(1));   
    elseif(i==n)
        B(i,(i-1)/2+1)=2*(-XY(n)+maxx)/(2*(-XY(n)+maxx)+XY(n)-XY(n-1));
        B(i,m)=(XY(n)-XY(n-1))/((maxx-XY(n-1))+(maxx-XY(n)));
    else
        B(i,(i-1)/2+1)=(XY(i+1)-XY(i))/(XY(i+1)-XY(i-1));
        B(i,(i+1)/2+1)=(XY(i)-XY(i-1))/(XY(i+1)-XY(i-1));
    end
end
% %%%%%%%%%%%%%%%%%%%%%%%%simple multigrid interpolation matrix%%%%%%%%%%%
else
if (mod(n,2)==0)
m=n/2+1;
else
m=(n-1)/2+2;
end
B=zeros(n,m);
for i=1:n
    if(i==1)
        B(1,1)=1/2;B(1,2)=1/2;
    elseif(i==n)
        B(i,(i)/2+1)=1/2; B(i,(i)/2+2)=1/2;
    elseif(mod(i,2)==0)
        B(i,(i+2)/2)=3/4;B(i,(i+4)/2)=1/4;
    elseif(mod(i,2)~=0)
        B(i,(i+1)/2)=1/4;B(i,(i+3)/2)=3/4;
    end
end
end
