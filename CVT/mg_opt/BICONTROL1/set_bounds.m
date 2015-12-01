function [v_low,v_up] = set_bounds(ind)
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

global N current_n

v_up=37*ones(N(ind)^2,1);
v_low=-1e10*ones(N(ind)^2,1); %%%%%%%%%one side bound
%v_up=1e10*ones(N(ind)^2,1); %%%%%%%%%one side bound
% v_low  = 10*ones(N(ind)^2,1);


