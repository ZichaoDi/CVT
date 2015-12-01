function y=r(x);
global density;
if (x>=0 && x<=1)
y = 1;
else 
    y=0;
end
%y=1 + 0.1*cos(pi*(x-0.5));
%y = 1 + 0.1*x;
%y = exp(-100*(x-0.01)^2);
%y = exp(x.^2);
%y=1+x;
%y=6.*x.^2.*exp(-2*x.^3);
%density='y=exp(-100*(x-0.5).^2)';
%density='1';
%density='y=1+0.1cos(pi*(x-0.5))';
%density = '1+0.1x';