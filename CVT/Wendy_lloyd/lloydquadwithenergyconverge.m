m=4;
a = sort(rand(1,m));%density function f(x)=x
energy = [];
for n=1:100
    y(1)=quadl(inline('x.^2'),0,(a(1)+a(2))/2)/quadl(inline('x'),0,(a(1)+a(2))/2);
    for i=2:m-1
        y(i)=quadl(inline('x.^2'),(a(i)+a(i-1))/2,(a(i)+a(i+1))/2)/quadl(inline('x'),(a(i)+a(i-1))/2,(a(i)+a(i+1))/2);
    end
    y(m)=quadl(inline('x.^2'),(a(m)+a(m-1))/2,1)/quadl(inline('x'),(a(m)+a(m-1))/2,1);
    for i=1:m
        a(i)=y(i);
    end
     energy(n)=quadl(@(x)x.*((x-a(1)).^2),0,(a(1)+a(2))/2);
     for i=2:m-1
          energy(n)= energy(n)+quadl(@(x)x.*((x-a(i)).^2),(a(i)+a(i-1))/2,(a(i)+a(i+1))/2);
     end
     energy(n)= energy(n)+quadl(@(x)x.*((x-a(m)).^2),(a(m)+a(m-1))/2,1);
end
plot(energy,'.-');
a
 