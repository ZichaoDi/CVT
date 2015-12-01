function [f,g]=sfun_integration(z)
global v A1 A2 A3  y N
n2 = length(z);
nm = sqrt(n2);
if(nm==N(1))
    A=A1;
elseif(nm==N(2))
    A=A2;
elseif(nm==N(3))
    A=A3;
end
zs = reshape(z,nm,nm);
nx = nm + 2;
ny = nm + 2;
[x,y,hx,hy] = getborder(nx,ny);
f=sin(2*pi*x)*sin(2*pi*y);
fc=reshape(f,n2,1);
targetz=1+sin(2*pi*x)*sin(2*pi*y);
targetzc=reshape(targetz,n2,1);
g=zeros(n2,1);
AA=A;
for i=1:n2
AA(i,i)=A(i,i)+z(i);end
y=-AA\fc;%%constrained case
dy=-AA\y;
for k=1:n2
dJ1=0;
dJ2=0;
for i=1:nm
    for j=1:nm
        dJ1=dJ1+(y((j-1)*nm+i)-targetz(i,j))*2*dy((j-1)*nm+i);
        dJ2=dJ2+zs(i,j)*2;
    end
end
dJ=1/2*dJ1*hx*hy+v/2*dJ2*hx*hy;
g(k)=dJ;
end
J1=0;
J2=0;
for i=1:nm
    for j=1:nm
        
        J1=J1+(y((j-1)*nm+i)-targetz(i,j))^2;
        J2=J2+zs(i,j)^2;
    end
end
J=1/2*J1+v/2*J2;
f=J;
