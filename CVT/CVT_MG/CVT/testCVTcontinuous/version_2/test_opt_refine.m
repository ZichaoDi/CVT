load z1;
load z3;
do_setup;
alpha = linspace(0,1,500);
zval = 0*alpha;
gval = 0*alpha;
for i=1:length(alpha);
    z0 = alpha(i)*z1 + (1-alpha(i))*z2;
    [f0,g0] = sfun(z0);
    zval(i) = f0;
    gval(i) = norm(g0);
end;
figure(1), plot(alpha,zval); title('function values')
figure(2), plot(alpha,gval); title('gradient norms')