function [v_low,v_up] = set_bounds(j)
%---------------------------------------------
global N minx maxx
%---------------------------------------------
n=j;
v_low =zeros(n,1);
v_up  = maxx*ones(n,1);