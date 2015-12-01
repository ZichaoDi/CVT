function [f,grad]=sfun(x)
global x1 y1 n2 hx miu 
grad=zeros(2*n2,1);
%z=1+sin(2*pi*x1)*sin(2*pi*y1);  %% target function
z=val(x1,y1);
zc=reshape(z,n2,1);clear z;
f=1/2*(x(1:n2)-zc)'*(x(1:n2)-zc)+miu/2*(x(n2+1:end)')*x(n2+1:end);
f=f*hx^2;
grad(1:n2)=x(1:n2)-zc;
grad(n2+1:end)=miu*x(n2+1:end);
grad=grad*hx^2;
