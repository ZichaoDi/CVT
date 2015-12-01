function result = GaussSeidel(A,f,x0)

n = size(x0,1);
result = zeros(n,1);

result = x0;
    
for i=1:n
    sum = 0;
    result';
    for k=1:(i-1)
        k;
     sum = sum + A(i,k)*result(k);
    end    
    for k=(i+1):n
        k;
     sum = sum + A(i,k)*result(k);
    end    
    
    sum;
    result(i) = (f(i) - sum)/A(i,i);
end

      
