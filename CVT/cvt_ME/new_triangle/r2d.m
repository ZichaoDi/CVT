function z=r2d(x,y);
%z=exp(-20*x.^2-20*y.^2) + 0.05*(sin(pi.*x)).^2.*(sin(pi.*y)).^2;
z=1;% + 0.1*x.^2;
global density;


%density='z=exp()+0.05*sin(pi*x)sin(pi*y)';
%density = 'z=1+x+0.1*x^2';
density = 'z=1';