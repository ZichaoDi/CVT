%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A = adjacency2(data);
global A;

warning off;
old = data;
N = size(data,1);

for i=1:N
kk(i) = i;
end
xx = ones(N,1);
A = sparse(kk,kk,xx);

 tri = delaunay(data(:,1),data(:,2));
% figure(3); hold on; trimesh(tri,data(:,1),data(:,2));
% for ii=1:N 
%     text(data(ii,1)+1,data(ii,2),num2str(ii)); 
% end
sz = size(tri,1);
E = sparse(sz,N);

s = 1;
ii = zeros(1);
jj = zeros(1);
%disp('begin');
for ind=1:sz
%if (mod(ind,500)==0) fprintf('%d out of %d\n',ind,sz); end
entries = tri(ind,1:3);
for i=1:3
  index = entries(i);
      ind;
      index;
     ii(s) = ind;
     jj(s) = index;
     s = s+1;
  end
end
ii;
xx = ones(length(ii),1);
E = sparse(ii,jj,xx);
size(E);
AA = E'*E;
[r,c]=find(AA);
A = sparse(r,c,ones(size(r),1));
%A = full(A);
return;