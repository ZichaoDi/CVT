function [x,hx,sx0,sx1] = getborder(nx)
%--------------------------------------------------------------
% specify boundary conditions for optimal control problem
%
% Parameters:
%
% Input:
%	nx	- # of points in x direction
% Output:
%	x	- array of x values
%	hx	- spacing in x direction

x0 = 0;
x1 = 1;
hx = (x1 - x0)/(nx-1);
x1  = (x0:hx:x1)';
x=x1(2:end-1);
sx0=0*x1';
sx1=0*x1';
%-------------------------------------------------------
