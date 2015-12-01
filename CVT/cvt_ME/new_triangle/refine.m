function [result,N] = refine(data)

N = size(data,1);

new(1:N,:)=data(1:N,:);
tri = delaunay(data(:,1),data(:,2));
nn = size(tri,1);
s=N+1;
for j=1:nn
      i1 = tri(j,1); i2 = tri(j,2); i3 = tri(j,3);
      new(s,1:2)=0.5*(data(i1,1:2)+data(i2,1:2));  new(s,3)=isbdry(new(s,1),new(s,2)); 
      new(s+1,1:2)=0.5*(data(i2,1:2)+data(i3,1:2)); new(s+1,3)=isbdry(new(s+1,1),new(s+1,2)); 
      new(s+2,1:2)=0.5*(data(i1,1:2)+data(i3,1:2)); new(s+2,3)=isbdry(new(s+2,1),new(s+2,2)); 
      s = s+3;
end    

result = zeros(1,1);
%plot(data(:,1),data(:,2),'ro',new(:,1),new(:,2),'m.');
result = removeSame(new,N);
N = size(result,1);

