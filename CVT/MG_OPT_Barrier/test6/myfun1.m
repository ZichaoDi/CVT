function [f,g,F,G]=myfun1(x)
%%% Test the calculation of the coefficients of the quadratic model in line
%%% barrir search
global miu alpha1
t1 = 0.5;
t2 = 1.7;
t3 = 3.9;
t4 = 9.3;
f=t1+t2*(x-alpha1)+t3*(x-alpha1)^2-miu*log(t4-(x-alpha1));
g=t2+2*t3*(x-alpha1)+miu*1/(t4-(x-alpha1));
F=f;
G=g;
