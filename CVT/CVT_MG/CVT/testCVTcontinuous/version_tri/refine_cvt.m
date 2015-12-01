function [result,N, B] = refine_cvt(data)
%%% Triangle domain
%%% This function is to refine the coarse generators by adding the inner
%%% point between two neighboring generators to the new data set
%%% result: the new fine data , last column 1: inner; 0: boundary
%%% N: number of inner points
%%% B: interpolation matrix

N = size(data,1);

new(1:N,:)=data(1:N,:);
tri = delaunay(data(:,1),data(:,2));
nn = size(tri,1);
s=N+1;
B=[];
B=sparse(B);
for i=1:N
    B(i,i)=1;
end
for j=1:nn
      i1 = tri(j,1); i2 = tri(j,2); i3 = tri(j,3);
      new(s,1:2)=0.5*(data(i1,1:2)+data(i2,1:2));  new(s,3)=isbdry(new(s,1),new(s,2)); 
      B(s,i1)=1/2;B(s,i2)=1/2;
      new(s+1,1:2)=0.5*(data(i2,1:2)+data(i3,1:2)); new(s+1,3)=isbdry(new(s+1,1),new(s+1,2)); 
      B(s+1,i2)=1/2;B(s+1,i3)=1/2;
      new(s+2,1:2)=0.5*(data(i1,1:2)+data(i3,1:2)); new(s+2,3)=isbdry(new(s+2,1),new(s+2,2)); 
      B(s+2,i1)=1/2;B(s+2,i3)=1/2;
      s = s+3;
end  
result = zeros(1,1);
[result,diff] = removeSame(new,N);
B=B(diff,:);
ind=find(result(:,3)==1);
N = length(ind);

