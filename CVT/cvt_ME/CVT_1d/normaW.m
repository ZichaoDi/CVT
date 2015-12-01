function z = normaW(x)
x
N = size(x,1);
z = x(1)^2;
for i=2:N
  z = z + (x(i)-x(i-1))^2;  
end
z = z + (1-x(N))^2;
