function [v_low,v_up] = set_bounds1(ind,bind,vlow,vup)
%-----------------------------------------------
%%%%%%%%Apply the bounds set from Toint
%-----------------------------------------------

global N current_n

v_low=-1e10*ones(N(ind),1);
% v_up=1e10*ones(N(ind),1); %%%%%%%%%one side bound
% %%%%%%%%%%%%%%%%%%%%%%%%%%#################################################
% if (ind==2)
% v_low_fine = -0.01.*ones(N(ind-1),1);
% else
% v_low_fine = vlow{ind-1};
% end
% 
% v_low=zeros(N(ind),1);
% finev=bind{ind};
% for i=2:N(ind)-1
%     odd1=v_low_fine(2*i+3)-finev(2*i+3)+1/4*finev(2*i-1)+1/2*finev(2*i)+1/4*finev(2*i+1);
%     odd2=v_low_fine(2*i+1)-finev(2*i+1)+1/4*finev(2*i-1)+1/2*finev(2*i)+1/4*finev(2*i+1);
%     evenn=v_low_fine(2*i)+1/4*finev(2*i-1)-1/2*finev(2*i)+1/4*finev(2*i+1);
%     diffv=[odd1,odd2,evenn];
%     [v_low(i),index]=max(diffv);
% end
% odd1=2*v_low_fine(1)+1/2*finev(2)+1/4*finev(3)-7/4*finev(1);
% evenn=v_low_fine(2)+1/4*finev(1)-1/2*finev(2)+1/4*finev(3);
% v_low(1)=max(odd1,evenn);
% odd1=2*v_low_fine(2*N(ind)+1)+1/2*finev(2*N(ind))+1/4*finev(2*N(ind)-1)-7/4*finev(2*N(ind)+1);
% evenn=v_low_fine(2*N(ind))+1/4*finev(2*N(ind)-1)-1/2*finev(2*N(ind))+1/4*finev(2*N(ind)+1);
% v_low(N(ind))=max(odd1,evenn);
%%%%%%%%%%%%%%%%%%%%%%%%%%#################################################
%%%%%%%%%%%%%%%%%%%%%%%%%%################################################
if (ind==2)
v_up_fine = 15*ones(N(ind-1),1);
else
v_up_fine = vup{ind-1};
end

v_up=zeros(N(ind),1);
finev=bind{ind};
for i=2:N(ind)-1
    odd1=v_up_fine(2*i+3)-finev(2*i+3)+1/4*finev(2*i-1)+1/2*finev(2*i)+1/4*finev(2*i+1);
    odd2=v_up_fine(2*i+1)-finev(2*i+1)+1/4*finev(2*i-1)+1/2*finev(2*i)+1/4*finev(2*i+1);
    evenn=v_up_fine(2*i)+1/4*finev(2*i-1)-1/2*finev(2*i)+1/4*finev(2*i+1);
    diffv=[odd1,odd2,evenn];
    [v_up(i),index]=min(diffv);
end
odd1=2*v_up_fine(1)+1/2*finev(2)+1/4*finev(3)-7/4*finev(1);
evenn=v_up_fine(2)+1/4*finev(1)-1/2*finev(2)+1/4*finev(3);
v_up(1)=min(odd1,evenn);
odd1=2*v_up_fine(2*N(ind)+1)+1/2*finev(2*N(ind))+1/4*finev(2*N(ind)-1)-7/4*finev(2*N(ind)+1);
evenn=v_up_fine(2*N(ind))+1/4*finev(2*N(ind)-1)-1/2*finev(2*N(ind))+1/4*finev(2*N(ind)+1);
v_up(N(ind))=min(odd1,evenn);


