%clear all;

n = 33;

x = linspace(0, 1, n)';

v = ones(size(x));
v(1) = 0;
v = rand(size(x));

[u,dx,dt] = advect_getu (x, v);

z = rand(size(u));

[w,dx,dt] = advect_getu_adj (z, x, v);

u0 = advect_getu0(x, v);

d1 = dot(u(:), z(:))
d2 = dot(w, u0)

d2/d1


