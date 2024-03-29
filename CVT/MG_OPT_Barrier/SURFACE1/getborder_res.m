function [x,y,hx,hy,sx0,sy0,sx1,sy1] = getborder_res(nx,ny)
%--------------------------------------------------------------
% specify boundary conditions for soap-film minimal surface
%
% Parameters:
%
% Input:
%	nx	- # of points in x direction
%	ny	- # of points in y direction
% Output:
%	x	- array of x values
%	y	- array of y values
%	hx	- spacing in x direction
%	hy	- spacing in y direction
%	sx0	- z(x ,y0)
%	sy0	- z(x0,y )
%	sx1	- z(x ,y1)
%	sy1	- z(x1,y )
%--------------------------------------------------------------
% usage: [x,y,sx0,sy0,sx1,sy1] = getborder(nx,ny)
%--------------------------------------------------------------
x0 = 0;
x1 = 1;
y0 = 0;
y1 = 1;
hx = (x1 - x0)/(nx-1);
hy = (y1 - y0)/(ny-1);
x  = x0:hx:x1;
y  =(y0:hy:y1)';
%-------------------------------------------------------
sx0= 0*sin(2*pi*x);
sy0= 0*sin(-2*pi*y);
sx1= 0*sin(2*pi*x);
sy1= 0*sin(-2*pi*y);
