function T = calcT(X);

global N;

X
lower = zeros(N,1);
upper = zeros(N,1);
T = zeros(N,1);

for k=1:N
if k==N    
    lower(k) = 0.5*(X(k-1)+X(k));
    upper(k) = 1;
    T(k)=double(TJ(lower(k),upper(k)));
    
elseif k==1 
    lower(k) = 0;
    upper(k) = 0.5*(X(k)+X(k+1));
    T(k)=double(TJ(lower(k),upper(k)));        
    
else
    lower(k) = 0.5*(X(k-1)+X(k));
    upper(k) = 0.5*(X(k)+X(k+1));
    
    T(k)=double(TJ(lower(k),upper(k)));    
    
end 
 
end

