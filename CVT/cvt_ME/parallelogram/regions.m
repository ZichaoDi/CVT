function towhich = regions(coarse,dataExact)

N = size(dataExact,1);
Nsmall = size(coarse,2);
X  = dataExact(coarse(1:Nsmall),1);
Y = dataExact(coarse(1:Nsmall),2);
tri = delaunay(X,Y);
nxy = prod(size(X));
S = sparse(tri(:,[1 1 2 2 3 3]),tri(:,[2 3 1 3 1 2]),1,nxy,nxy);

for ii=1:N
K = dsearch(X,Y,tri,dataExact(ii,1),dataExact(ii,2),S);
towhich(ii) = coarse(K);
end