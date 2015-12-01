
function A = adjacency(data)

%%%%######## Find the neighboring relation for generators################
global tribond

warning off;
N=size(data,1);
data_test=[data;tribond(:,1:2)];
tri = delaunay(data_test(:,1),data_test(:,2),{'Qt','Qbb','Qc','Qz'});
indin=find(tri(:,1)<=N & tri(:,2)<=N & tri(:,3)<=N);
tri=tri(indin,:);
sz = size(tri,1);
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
xx = ones(length(ii),1);
E = sparse(ii,jj,xx);
AA = E'*E;
[r,c]=find(AA);
A = sparse(r,c,ones(size(r),1));
return;