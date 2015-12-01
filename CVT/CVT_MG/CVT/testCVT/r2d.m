function z = density(x,y)
global mminx mminy mmaxx mmaxy;

if (x>=mminx & x<=mmaxx & y>=mminy & y<=mmaxy)
    %disp('here');
    z=1;
    %z = exp(-((x-50).^2+(y-50).^2)/1000); % + exp(-((x-100)^2+(y-100)^2)/500);
    %z = z + exp(-((x-100)^2+(y-0)^2)/500) + exp(-((x-0)^2+(y-100)^2)/500);
else
    z = 0;
end