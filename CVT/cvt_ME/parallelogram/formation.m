function [data,N] = formation(div)

N=1;

%siz = div*div;
siz = 1;
data = zeros(siz,1);

for i=0:1/div:1
    for j=0:1/div:1
        data(N,1) = i; 
        data(N,2) = j; 
        N = N+1;    
    end
end
data;
N = size(data,1);
%points = zeros(N,2);
%points = mapping(data);
%size(points);

% figure(1);
% hold on;
% grid on;
% for i=1:(N)
% %text(points(i,1)+0.01,points(i,2)+0.01,num2str(i));    
% plot(data(i,1),data(i,2),'r*');
% %plot(points(i,1),points(i,2),'r*');
% end