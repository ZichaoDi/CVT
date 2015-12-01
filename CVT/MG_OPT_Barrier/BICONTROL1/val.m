function z=val(x,y);
n=length(x);
z=zeros(n,n);
for i=1:n
    for j=1:n
if (x(j)>0.25&&x(j)<0.75&&y(i)>0.25&&y(i)<0.75)
    z(i,j)=2;
else
    z(i,j)=1;
end
    end
end
