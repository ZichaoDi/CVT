%Lloyd's method on unit interval of 1-dimension
%density function r(x)=1

clear all;
m=1e3; 
Nmax = 100000;
epsilon = 1e-6;
x = sort(rand(1,m));

for i=1:m
 xex(i) = (2*i-1)/(2*m);
end

n=1; 
error(1) = 1;

while (error(n)>epsilon)&&(n<Nmax)
    if (mod(n,100)==0) n, end
    
    y(1)=(x(1)+x(2))/4;
    for i=2:m-1
        y(i)=(x(i-1)+2*x(i)+x(i+1))/4;
    end
    y(m)=(x(m-1)+x(m)+2)/4;
    
    x=y;
    n = n+1;
    error(n) = norm(x-xex);
    
end 

 plot(error)