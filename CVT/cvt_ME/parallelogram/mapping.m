function pts = mapping(data) 

N = size(data,1);
pts = zeros(N,2);

ends = [ 0.0     0.0       ;
         0.5    sqrt(3)/2  ; 
         1       0.0       ];

ort1 = ends(3,:);
ort2 = ends(2,:);
     
% hold on;
% plot([ort1(1),0],[ort1(2),0],'b-');
% plot([ort2(1),0],[ort2(2),0],'b-');
% 

for i=1:N
    c1 = data(i,1);
    c2 = data(i,2);
    pts(i,:) = c1*ort1 + c2*ort2;
end    
pts;
% 
% figure(10);
% hold on;
% grid on;
% plot(pts(:,1),pts(:,2),'r*');
