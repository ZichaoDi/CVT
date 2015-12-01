function doplot(it,u)
%-------------------------------------
% Plot control and state functions.
%-------------------------------------
global Av fv zv nu IND
global N
%-------------------------------------
% Identify level and get data
%-------------------------------------
n2 = length(u);
n  = sqrt(n2);
k  = find(n==N);
A = Av{k};
f = fv{k};
z = zv{k};
%-------------------------------------
% Compute function and gradient
%-------------------------------------
if (IND==1); % linear problem
    y = -A\(u+f);
    p =  A\(y-z);
    g = nu*u-p;   
    J = 0.5*(y-z)'*(y-z) + 0.5*nu*u'*u;
else         % bilinear problem
    n2 = length(u);
    U  = spdiags(u,0,n2,n2);
    B  = A+U;
    y  = -B\f;
    p  =  B\(y-z);
    g  = nu*u - y.*p;
    J  = 0.5*(y-z)'*(y-z) + 0.5*nu*u'*u;
end;

n2 = length(u);
n  = sqrt(n2);
Y  = reshape(y,n,n);
U  = reshape(u,n,n);
Y  = [zeros(1,n+2)
      zeros(n,1) Y zeros(n,1)
      zeros(1,n+2)];
U  = [zeros(1,n+2)
      zeros(n,1) U zeros(n,1)
      zeros(1,n+2)];
figure(10); mesh(U); title('control')
figure(11); mesh(Y); title('state')