function [v_low,v_up] = set_bounds(j)
%---------------------------------------------
global N XY globalN
%---------------------------------------------
n = N(j);
v_low = zeros(n,1);
v_up  = 100*ones(n,1);