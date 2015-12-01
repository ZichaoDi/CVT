function z = density(x,y)
global mminx mminy mmaxx mmaxy;

if (x>=mminx & x<=mmaxx & y>=mminy & y<=mmaxy)
    %disp('here');
%     if(x>=0& x<=50& y>=0 & y<=100)
%     z=0.99;
% %     elseif(x>=10 & x<=21 & y>=10 & y<=21)
% %         z=0.01;
% %     elseif(x>=33& x<=55 & y>=66 & y<=80)
% %         z=0.09;
%     else
%         z=0.01;
%     end
z=1;
%z=exp(-20*(x^2+y^2))+0.05*sin(pi*x)^2*sin(pi*y)^2;
z=x;
%    z = exp(-((x-50).^2+(y-50).^2)/1000); % + exp(-((x-100)^2+(y-100)^2)/500);
    %z = z + exp(-((x-100)^2+(y-0)^2)/500) + exp(-((x-0)^2+(y-100)^2)/500);
else
    z = 0;
end