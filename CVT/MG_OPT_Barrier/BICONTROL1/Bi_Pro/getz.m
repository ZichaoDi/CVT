function z = getz(n);
%--------------------------------------------
% Define the function z for the
% optimal-control problems defined in
% the paper by Vallejos and Borzi (2008)
%--------------------------------------------
z  = ones(n,n);
n1 = n + 1;
t  = linspace(0,1,n1);
for i = 1:n;
    x = t(i);
    for j = 1:n;
        y = t(j);
        if (x>0.25 & x < 0.75 & y > 0.25 & y < 0.75);
            z(i,j) = 2;
        end;
    end;
end;
z = z(:);