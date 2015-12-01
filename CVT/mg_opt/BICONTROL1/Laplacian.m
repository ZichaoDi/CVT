function y=Laplacian(u,f,nm,hx,hy)
global A
nmm=nm^2;
f=reshape(f,nmm,1);
A=zeros(nmm,nmm);
for i=2:nm-1
    for j=2:nm-1
        A((j-1)*nm+i,(j-1)*nm+i)=2/hx^2+2/hy^2+u(i,j);
        
        A((j-1)*nm+i,(j-1)*nm+i-1)=-1/hx^2;
        A((j-1)*nm+i,(j-1)*nm+i+1)=-1/hx^2;
        A((j-1)*nm+i,(j-2)*nm+i)=-1/hy^2;
        A((j-1)*nm+i,(j)*nm+i)=-1/hy^2;
    end
end
A(1,1)=2/hx^2+2/hy^2+u(1,1);
A(1,2)=-1/hx^2;
A(1,nm+1)=-1/hy^2;


for i=2:nm-1
    A(i,i)=2/hx^2+2/hy^2+u(i,1);
    A(i,i-1)=-1/hy^2;
    A(i,i+1)=-1/hy^2;
    A(i,nm+i)=-1/hx^2;
end
A(nm,nm)=2/hx^2+2/hy^2+u(nm,1);
A(nm,nm-1)=-1/hy^2;
A(nm,2*nm)=-1/hx^2;

for j=2:nm-1
    A(j*nm,j*nm)=2/hx^2+2/hy^2+u(nm,j);
    A(j*nm,j*nm-1)=-1/hy^2;
    A(j*nm,(j-1)*nm)=-1/hx^2;
    A(j*nm,(j+1)*nm)=-1/hx^2;
end
A(nmm,nmm)=2/hx^2+2/hy^2+u(nm,nm);
A(nmm,nmm-1)=-1/hy^2;
A(nmm,(nm-1)*nm)=-1/hx^2;

for j=2:nm-1
    A((nm-1)*nm+j,(nm-1)*nm+j)=2/hx^2+2/hy^2+u(j,nm);
    A((nm-1)*nm+j,(nm-1)*nm+j-1)=-1/hy^2;
    A((nm-1)*nm+j,(nm-1)*nm+j-nm)=-1/hx^2;
    A((nm-1)*nm+j,(nm-1)*nm+j+1)=-1/hx^2;
end
A((nm-1)*nm+1,(nm-1)*nm+1)=2/hx^2+2/hy^2+u(1,nm);
A((nm-1)*nm+1,(nm-1)*nm+1-nm)=-1/hx^2;
A((nm-1)*nm+1,(nm-1)*nm+1+1)=-1/hy^2;

for j=2:nm-1
    A(nm*(j-1)+1,nm*(j-1)+1)=2/hx^2+2/hy^2+u(1,j);
    A(nm*(j-1)+1,nm*(j-1)+1-nm)=-1/hx^2;
    A(nm*(j-1)+1,nm*(j-1)+1+1)=-1/hy^2;
    A(nm*(j-1)+1,nm*(j-1)+1+nm)=-1/hx^2;
end
A;
y=Gauss_Seidel(A,-f);
y=reshape(y,nm,nm);
