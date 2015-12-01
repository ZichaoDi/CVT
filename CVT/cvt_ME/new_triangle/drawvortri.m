function z = drawVorTri(data,v,c);

N = size(data,1);
figure(1);
subplot(1,2,1);
hold on;
axis([-0.5 0.5 0 0.9]);
axis square;
%plot(data(1:N,1),data(1:N,2),'b.');
for i=1:length(c)
    x = v(c{i},:);
    sz = size(x,1);
    x(sz+1,:) = x(1,:);
    plot(x(:,1),x(:,2),'-');
end    
