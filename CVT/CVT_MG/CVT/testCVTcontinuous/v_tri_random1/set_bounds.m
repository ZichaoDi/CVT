function [v_low,v_up] = set_bounds(n)
%---------------------------------------------
global  current_v N
%---------------------------------------------
v_low=zeros(n,1);
v_up=zeros(n,1);

%if(res_prob==0)
if(n==2*N(1))
v_low =-1e16*ones(n,1);
v_up  = 1e16*ones(n,1); 
else
vv=reshape(current_v,2,n/2);
inu=find(vv(2,:)>=35);
inl=setdiff([1:n/2],inu);
v_low=current_v-3;
v_up=current_v+3;
%%%=========================================================
%     v_low(1:2:n)=-30*ones(n/2,1);
%     v_low(2:2:n)=1*ones(n/2,1);
%     v_up(1:2:n)=30*ones(n/2,1);
%     v_up(2:2:n)=32*ones(n/2,1);
%     v_low(3)=-19;
%     v_low(4)=1;
%     v_up(3)=19;
%     v_up(4)=60;
%     v_low(17)=-19;
%     v_low(18)=1;
%     v_up(17)=19;
%     v_up(18)=60;
%%%=========================================================    
% v_low(2*inu-1)=-19;
% v_up(2*inu-1)=19;
% v_low(2*inu)=1;
% v_up(2*inu)=60;
% v_low(2*inl-1)=-30;
% v_up(2*inl-1)=30;
% v_low(2*inl)=1;
% v_up(2*inl)=32;
%%%=========================================================
end