
function A = adjacency1(data)

%%%%######## Find the neighboring relation for generators################

warning off;
size(data)
tri = delaunay(data(:,1),data(:,2));%,'Qz',{'Qt','Qbb','Qc','Qj'}
triplot(tri,data(:,1),data(:,2));
sz=size(tri,1);
s = 1;
ii = zeros(1);
jj = zeros(1);
for ind=1:sz
    entries = tri(ind,1:3);
    for i=1:3
        index = entries(i);
        ii(s) = ind;
        jj(s) = index;
        s = s+1;
    end
end
tri
xx = ones(length(ii),1);
E = sparse(ii,jj,xx);
size(E)
AA = E'*E;
[r,c]=find(AA);
A = sparse(r,c,ones(size(r),1));
return;