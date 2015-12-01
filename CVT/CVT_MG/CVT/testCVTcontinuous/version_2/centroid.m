function A=centroid(k)
for k=3:3000
A=zeros(2,2*k);
for i=1:k
    A(1,1:k)=25;A(1,k+1:2*k)=75;
    A(2,i)=100/(2*k)*(2*i-1);end
A(1,k+1:2*k)=75;A(2,k+1:2*k)=A(2,1:k);
A=reshape(A,4*k,1);
v(k)=sfun(A);
vk=v(k)
if(norm(v(k)-v(k-1))<=1e-5) v;break;end
end
save('energy sequence','v');





% function [Brow,B]=centroid(k,h)
% A1=[];A2=[];B=[];
% for i=1:k
%     A2(2,i)=100/(2*k)*(2*i-1);end 
% for i=1:h
%     A1(1,i)=100/(2*h)*(2*i-1);end 
% B(2,:) = repmat(A2(2,:),1,h);
% B1=repmat(A1(1,1),1,k);
% for i=2:h
%     B1=[B1,repmat(A1(1,i),1,k)];
% end
% B(1,:)=B1;cla;
% B;
% Brow=reshape(B,2*k*h,1);