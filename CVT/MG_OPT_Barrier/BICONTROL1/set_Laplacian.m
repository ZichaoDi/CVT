function A=set_Laplacian(nm)
%---------------------------------------
% Generate 2-d discrete Laplacian
% on the interval [0,1]x[0,1] for
hx = 1/(nm+1);
hy=hx;
%---------------------------------------
% Generate A as a sparse matrix
nmm=nm^2;
A=zeros(nmm,nmm);
for i=2:nm-1
    for j=2:nm-1
        A((j-1)*nm+i,(j-1)*nm+i)=2/hx^2+2/hy^2;
        
        A((j-1)*nm+i,(j-1)*nm+i-1)=-1/hx^2;
        A((j-1)*nm+i,(j-1)*nm+i+1)=-1/hx^2;
        A((j-1)*nm+i,(j-2)*nm+i)=-1/hy^2;
        A((j-1)*nm+i,(j)*nm+i)=-1/hy^2;
    end
end
A(1,1)=2/hx^2+2/hy^2;
A(1,2)=-1/hx^2;
A(1,nm+1)=-1/hy^2;


for i=2:nm-1
    A(i,i)=2/hx^2+2/hy^2;
    A(i,i-1)=-1/hy^2;
    A(i,i+1)=-1/hy^2;
    A(i,nm+i)=-1/hx^2;
end
A(nm,nm)=2/hx^2+2/hy^2;
A(nm,nm-1)=-1/hy^2;
A(nm,2*nm)=-1/hx^2;

for j=2:nm-1
    A(j*nm,j*nm)=2/hx^2+2/hy^2;
    A(j*nm,j*nm-1)=-1/hy^2;
    A(j*nm,(j-1)*nm)=-1/hx^2;
    A(j*nm,(j+1)*nm)=-1/hx^2;
end
A(nmm,nmm)=2/hx^2+2/hy^2;
A(nmm,nmm-1)=-1/hy^2;
A(nmm,(nm-1)*nm)=-1/hx^2;

for j=2:nm-1
    A((nm-1)*nm+j,(nm-1)*nm+j)=2/hx^2+2/hy^2;
    A((nm-1)*nm+j,(nm-1)*nm+j-1)=-1/hy^2;
    A((nm-1)*nm+j,(nm-1)*nm+j-nm)=-1/hx^2;
    A((nm-1)*nm+j,(nm-1)*nm+j+1)=-1/hx^2;
end
A((nm-1)*nm+1,(nm-1)*nm+1)=2/hx^2+2/hy^2;
A((nm-1)*nm+1,(nm-1)*nm+1-nm)=-1/hx^2;
A((nm-1)*nm+1,(nm-1)*nm+1+1)=-1/hy^2;

for j=2:nm-1
    A(nm*(j-1)+1,nm*(j-1)+1)=2/hx^2+2/hy^2;
    A(nm*(j-1)+1,nm*(j-1)+1-nm)=-1/hx^2;
    A(nm*(j-1)+1,nm*(j-1)+1+1)=-1/hy^2;
    A(nm*(j-1)+1,nm*(j-1)+1+nm)=-1/hx^2;
end
A;

