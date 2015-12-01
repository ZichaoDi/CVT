function visualize_sub
figure(1);
x = [-30:1:30];
y = [-30:1:30];
[xx,yy]=meshgrid(x,y);
nt=length(xx);
VXY=[];
VXY(:,1)=reshape(xx,nt^2,1);
VXY(:,2)=reshape(yy,nt^2,1);
cmap=colormap(cool);
a=[-30 30 30 -30];
b=[-30 -30 30 30];
fill(a,b,cmap(6,:));
rand('state',0);
a1=-30+20*rand(20,1);
b1=-20+50*rand(20,1);
dt1 = DelaunayTri(a1,b1);
hold on;
colorbar('location','southoutside')
k1 = convexHull(dt1);
fill(dt1.X(k1,1),dt1.X(k1,2),cmap(40,:));
z=dt1.X(k1,1);t=dt1.X(k1,2);
for i=1:length(z)-1
text(z(i),t(i),['(', num2str(z(i)), ', ', num2str(t(i)), ')']);
end
a2=0+30*rand(20,1);
b2=-30+60*rand(20,1);
dt2 = DelaunayTri(a2,b2);
k2 = convexHull(dt2);
fill(dt2.X(k2,1),dt2.X(k2,2), cmap(60,:));
z=dt2.X(k2,1);t=dt2.X(k2,2);
for i=1:length(z)-1
text(z(i),t(i),['(', num2str(z(i)), ', ', num2str(t(i)), ')']);
end
% a3=20+10*rand(20,1);
% b3=-30+20*rand(20,1);
% dt3 = DelaunayTri(a3,b3);
% k3 = convexHull(dt3);
% fill(dt3.X(k3,1),dt3.X(k3,2), cmap(20,:));
% a7=-20+20*rand(20,1);
% b7=0+10*rand(20,1);
% dt7 = DelaunayTri(a7,b7);
% k7 = convexHull(dt7);
% fill(dt7.X(k7,1),dt7.X(k7,2),cmap(64,:));
% a4=10+10*rand(20,1);
% b4=0+20*rand(20,1);
% dt4 = DelaunayTri(a4,b4);
% k4 = convexHull(dt4);
% fill(dt4.X(k4,1),dt4.X(k4,2), cmap(30,:));
% a5=-20+10*rand(20,1);
% b5=10+20*rand(20,1);
% dt5 = DelaunayTri(a5,b5);
% k5 = convexHull(dt5);
% fill(dt5.X(k5,1),dt5.X(k5,2), cmap(35,:));
% a6=0+10*rand(20,1);
% b6=10+20*rand(20,1);
% dt6 = DelaunayTri(a6,b6);
% k6 = convexHull(dt6);
% fill(dt6.X(k6,1),dt6.X(k6,2), cmap(60,:));
MVXY=ones(nt^2,1);
IN = inpolygon(VXY(:,1),VXY(:,2),dt1.X(k1,1),dt1.X(k1,2));
i1=find(IN==1);
for i=1:length(i1), MVXY(i1(i))= 10; end
IN = inpolygon(VXY(:,1),VXY(:,2),dt2.X(k2,1),dt2.X(k2,2));
i3=find(IN==1);
for i=1:length(i3), MVXY(i3(i))= 19; end
% % IN = inpolygon(VXY(:,1),VXY(:,2),dt4.X(k4,1),dt4.X(k4,2));
% % i4=find(IN==1);
% % for i=1:length(i4), MVXY(i4(i))= 28; end
% % IN = inpolygon(VXY(:,1),VXY(:,2),dt5.X(k5,1),dt5.X(k5,2));
% % i5=find(IN==1);
% % for i=1:length(i5), MVXY(i5(i))=30; end
% % IN = inpolygon(VXY(:,1),VXY(:,2),dt6.X(k6,1),dt6.X(k6,2));
% % i6=find(IN==1);
% % for i=1:length(i6), MVXY(i6(i))= 38; end
% % IN = inpolygon(VXY(:,1),VXY(:,2),dt7.X(k7,1),dt7.X(k7,2));
% % i7=find(IN==1);
% % for i=1:length(i7), MVXY(i7(i))= 45; end
 MVXY2=MVXY;
 save MVXY2 MVXY2
% % %figure(4);plot(MVXY)
% %  cmap = colormap(rand(nt^2,3));
% % for i=1:nt^2
% % col(i,1:3) = cmap(1+round((nt^2-1)*1e-4*MVXY(i)),:);
% % plot(VXY(i,1),VXY(i,2),'marker','.','markersize',18,'color',col(i,1:3));
% % hold on;
% % end
% 
% 
% 
