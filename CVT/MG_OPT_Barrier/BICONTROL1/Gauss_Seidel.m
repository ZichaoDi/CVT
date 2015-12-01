function x=Gauss_Seidel(A,b)
n=length(b);
x=zeros(n,1);%%initial guess
nn=0;
convergence=0;
while(~convergence)
    nn=nn+1;
    
for i=1:n
    term2=0;term3=0;
    for j=1:i-1
        term2=term2+A(i,j)*x(j);end
    for j=i+1:n
        term3=term3+A(i,j)*x(j);end
    x(i)=1/A(i,i)*(b(i)-term2-term3);
end
convergence=(norm(b-A*x)<=1e-7);
end