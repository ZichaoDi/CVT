function vh = update (vH, res_prob)

%--------------------------------------------------------------
% Update to a larger problem
%

global X  N current_n V_L V_U IHh

%--------------------------------------------------------------

j     = find(N==current_n);
if(length(N)==2)
j=1;
end
%%%%#### exclude boundary points
% xh    = X(1:N(j),j);
% xH    = X(1:N(j+1),j+1);
% vh = interp1(xH,vH,xh);
%%%%###########################
IHh=zeros(N(j),N(j+1));
IHh(1,1)=1/2;
for i=1:N(j+1)-1
    IHh(2*i,i)=1;
    IHh(2*i+1,i)=1/2;IHh(2*i+1,i+1)=1/2;
end
IHh(N(j)-1,N(j+1))=1;
IHh(N(j),N(j+1))=1/2;
vh=IHh*vH;%4*
return

%%%%#### include boundary points
% if(res_prob==0)
% vH=[V_L;vH;V_U];
% elseif (res_prob==1)
%     vH=[0;vH;0];
% end
% 
% IHh=zeros(N(j)+2,N(j+1)+2);
% for i=1:N(j+1)+1
%     IHh(2*i-1,i)=1;
%     IHh(2*i,i)=1/2;IHh(2*i,i+1)=1/2;
% end
% IHh(N(j)+2,N(j+1)+2)=1;
% vh=IHh*vH;
% vh=vh(2:end-1);


