function z=val(x);
n=length(x);
z=zeros(n,1);

    for i=1:n
if (x(i)>0.25&&x(i)<0.75)
    z(i)=2;
else
    z(i)=1;
end
    end

