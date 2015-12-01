function A=laplacian_1d(n)
A=sparse(n,n);
A(1,1)=-2;
A(1,2)=1;
A(n,n-1)=1;
A(n,n)=-2;
for i=2:n-1
    A(i,i-1)=1;
    A(i,i)=-2;
    A(i,i+1)=1;
end
