function [z,a,b,c] = insidetri(x,y,z,s)
format long e;


area = det([x(1) x(2) 1; y(1) y(2) 1; z(1) z(2) 1]);
a = det([s(1) s(2) 1; y(1) y(2) 1; z(1) z(2) 1])/area;
b = det([x(1) x(2) 1; s(1) s(2) 1; z(1) z(2) 1])/area;
c = det([x(1) x(2) 1; y(1) y(2) 1; s(1) s(2) 1])/area;

if(s==x)a=1;b=0;c=0;
elseif(s==y)a=0;b=1;c=0;
elseif(s==z)a=0;b=0;c=1;
end

if (a>=0 & a<=1 & b>=0 & b<=1 & c>=0 & c<=1) z=1;
else z=0; end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%interpolate at the optimal solution%%%%
% if (a>0 & a<1 & b>0 & b<1 & c>0 & c<1)
%     if(a==min([a,b,c])) a=0;b=1/2;c=1/2;
%     elseif(b==min([a,b,c])) a=1/2;b=0;c=1/2;
%     elseif(c==min([a,b,c])) a=1/2;b=1/2;c=0;
%     end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
