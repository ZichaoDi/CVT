function H=Hessian1d(x)
global minx maxx N
%x=sort([minx x' maxx]);
% h=0.1;
% x=[-h-minx:2*h:maxx+h];
% x=x(2:end-1);h=1/(2*n);
x=sort(x);
n=length(x);

H=zeros(n,n);
if(n==1)
    H=2*(maxx-minx);
else
for i=1:n
    if (i==1)
    xp=(x(i)+x(i+1))/2;
    xn=minx;
    H(i,i)=2*(xp-xn)-(xp-x(i));
    H(i,i+1)=(x(i)-xp);
    elseif(i==n)
       xp=maxx;
    xn=(x(i)+x(i-1))/2; 
    H(i,i)=2*(xp-xn)-(x(i)-xn);
    H(i,i-1)=xn-x(i);
    else
        xp=(x(i)+x(i+1))/2;
    xn=(x(i)+x(i-1))/2;  
     H(i,i)=2*(xp-xn)-(xp-x(i))-(x(i)-xn);
     
    H(i,i+1)=(x(i)-xp);
    H(i,i-1)=xn-x(i);
    end
end
end
ind=find(N==n);
H=H.*n^2;
%%%%H=H(2:end-1,2:end-1);
   