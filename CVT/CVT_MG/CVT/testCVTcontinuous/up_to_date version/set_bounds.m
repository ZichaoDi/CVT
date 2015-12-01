function [v_low,v_up] = set_bounds(jj)
%---------------------------------------------
global N XY globalN
%---------------------------------------------
n=jj;
v_low =zeros(n,1);
v_up  = 100*ones(n,1);