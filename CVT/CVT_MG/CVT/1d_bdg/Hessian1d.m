function H=Hessian1d(x)
global minx maxx N
%x=sort([minx x' maxx]);
x=sort(x);
n=length(x);
ind=find(N==n);
H=zeros(n,n);
for i=1:n
    if (i==1)
    xp=(x(i)+x(i+1))/2;
    xn=(x(1)+minx)/2;
    H(i,i)=2*(xp-xn)-(xp-x(i))-3/2*(x(1)-xn);
    H(i,i+1)=(x(i)-xp);
    elseif(i==n)
       xp=(maxx+x(end))/2;
    xn=(x(i)+x(i-1))/2; 
    H(i,i)=2*(xp-xn)-(x(i)-xn)-3/2*(xp-x(i));
    H(i,i-1)=xn-x(i);
    else
        xp=(x(i)+x(i+1))/2;
    xn=(x(i)+x(i-1))/2;  
     H(i,i)=2*(xp-xn)-(xp-x(i))-(x(i)-xn);
     
    H(i,i+1)=(x(i)-xp);
    H(i,i-1)=xn-x(i);
    end
end
%H=H./4^(ind-1);
%H=H(2:end-1,2:end-1);
   