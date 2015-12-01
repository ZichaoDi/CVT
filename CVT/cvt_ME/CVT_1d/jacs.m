function jacobian = jacs(N,NGridStep)

jacobian = zeros(1,1,NGridStep);

jac = eye(N);
jacobian(1:N,1:N,NGridStep)=jac;
p = N

for ss=NGridStep-1:-1:1
    pold = p;
    p = (p+1)/2;
    
    PP = zeros(p,pold);
    
    for i=2:(p-1)
        PP(i,2*i-1) = 1;
        PP(i,2*i) = 0.5;
        PP(i,2*i-2) = 0.5;
    end
    
    PP(1,1) = 1;
    PP(1,2) = 0.5;
    p;
    PP(p,2*p-1) = 1;
    PP(p,2*p-2) = 0.5;
    
    PP;
    Q = zeros(p,N);    
    Q = PP*jac;    
    jac = zeros(p,N);
    jac = Q;
    
    jacobian(1:p,1:N,ss) = jac(1:p,1:N);
        
end    
