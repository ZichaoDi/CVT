function z = drawVor(data,str);
global pp;

N = size(data,1);

figure(100);
%clf;
hold on;
grid on;
axis([0 1.5 0 1]);

vor  = zeros(N,2);
vor = data;
    vor(N+1,:) = [-1,-1];
    vor(N+2,:) = [-1, 2];
    vor(N+3,:) = [ 2, 2];
    vor(N+4,:) = [ 2,-1];
    
[v,c] = voronoin(vor);

for ii=1:N
vert = v(c{ii},:);  %vertices of j-th cell
sz = size(vert,1);
for iii=1:(sz-1)
  plot([vert(iii,1),vert(iii+1,1)],[vert(iii,2),vert(iii+1,2)],'b-');
end
plot([vert(1,1),vert(sz,1)],[vert(1,2),vert(sz,2)],'b-');

plot(vor(ii,1),vor(ii,2),str);
text(vor(ii,1),vor(ii,2),num2str(ii));
drawnow;
end
