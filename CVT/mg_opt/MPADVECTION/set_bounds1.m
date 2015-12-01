function [v_low,v_up] = set_bounds1(ind,bind,vlow,vup)
%-----------------------------------------------
%%%%%%%%Apply the bounds set from Toint
%-----------------------------------------------

global N current_n

%v_low=-1e10*ones(N(ind),1);
%v_up=1e10*ones(N(ind),1); %%%%%%%%%one side bound
%%%%%%%%%%%%%%%%%%%%%%%%%%#################################################

 v_low_fine = vlow{ind-1};

v_low=zeros(N(ind),1);
finev=bind{ind};
for i=2:N(ind)-1
    odd1=v_low_fine(2*i)+1/4*finev(2*i-2)+1/2*finev(2*i-1)-3/4*finev(2*i);
    odd2=v_low_fine(2*i-2)+1/4*finev(2*i)+1/2*finev(2*i-1)-3/4*finev(2*i-2);
    evenn=v_low_fine(2*i-1)+1/4*finev(2*i-2)-1/2*finev(2*i-1)+1/4*finev(2*i);
    diffv=[odd1,odd2,evenn];
    [v_low(i),index]=max(diffv);
end
odd1=v_low_fine(2)+1/2*finev(1)-3/4*finev(2);
evenn=v_low_fine(1)+1/4*finev(2)-1/2*finev(1);
v_low(1)=max(odd1,evenn);
odd1=v_low_fine(2*N(ind)-2)+1/2*finev(2*N(ind)-1)-3/4*finev(2*N(ind)-2);
evenn=v_low_fine(2*N(ind)-1)+1/4*finev(2*N(ind)-2)-1/2*finev(2*N(ind)-1);
v_low(N(ind))=0;%max(odd1,evenn);

%%%%%%%%%%%%%%%%%%%%%%%%%%#################################################
%%%%%%%%%%%%%%%%%%%%%%%%%%################################################
v_up_fine = vup{ind-1};

v_up=zeros(N(ind),1);
finev=bind{ind};
for i=2:N(ind)-1
    odd1=v_up_fine(2*i)+1/4*finev(2*i-2)+1/2*finev(2*i-1)-3/4*finev(2*i);
    odd2=v_up_fine(2*i-2)+1/4*finev(2*i)+1/2*finev(2*i-1)-3/4*finev(2*i-2);
    evenn=v_up_fine(2*i-1)+1/4*finev(2*i-2)-1/2*finev(2*i-1)+1/4*finev(2*i);
    diffv=[odd1,odd2,evenn];
    [v_up(i),index]=min(diffv);
end
odd1=v_up_fine(2)+1/2*finev(1)-3/4*finev(2);
evenn=v_up_fine(1)+1/4*finev(2)-1/2*finev(1);
v_up(1)=min(odd1,evenn);
odd1=v_up_fine(2*N(ind)-2)+1/2*finev(2*N(ind)-1)-3/4*finev(2*N(ind)-2);
evenn=v_up_fine(2*N(ind)-1)+1/4*finev(2*N(ind)-2)-1/2*finev(2*N(ind)-1);
v_up(N(ind))=0;%min(odd1,evenn);


