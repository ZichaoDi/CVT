function [v_low,v_up] = set_bounds(ind,res_prob)
%-----------------------------------------------
% Set the current upper and lower bounds on
% the variables in the optimization problem,
% based on an index ind into the array N
% containing the list of problem sizes.
%-----------------------------------------------

%-----------------------------------------------
% In some cases (where the number of design
% variables is fixed), the result will be the
% same regardless of the value of ind.
%
% In other cases, it is recommended that
% do_setup.m create rectangular arrays V_LOW
% and V_UP, where the j-th column contains the
% vector of bounds corresponding to N = N(ind).
%-----------------------------------------------

global N 

% v_up=1e50*ones(N(ind),1); %%%%%%%%%one side bound
% v_low  = -0.01*ones(N(ind),1);

%%%%%%%%%#############################################################
v_up=zeros(N(ind),1);
v_low=zeros(N(ind),1);
load intxr;
intx=intxr;
iodd= find(mod((1:N(ind)),2)~=0);
ieven2=find(mod((1:N(ind)),2)==0 & mod((1:N(ind)),4)~=0);
ieven4=find(mod((1:N(ind)),2)==0 & mod((1:N(ind)),4)==0);
v_up(iodd)=100;
v_up(ieven2)=intx(ieven2)-0.1;
v_up(ieven4)=intx(ieven4)+10;
v_low(iodd)=-100;
v_low(ieven2)=intx(ieven2)-10;
v_low(ieven4)=intx(ieven4)+0.1;

