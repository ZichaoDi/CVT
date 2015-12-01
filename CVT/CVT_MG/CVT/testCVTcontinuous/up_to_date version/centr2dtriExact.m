
function subcen = centr2dtriExact(vert)
vert=vert';
vert = vert(convhull(vert(:,1),vert(:,2)),:);
sumX = 0; sumY = 0;check=0;
tri  = delaunay(vert(:,1),vert(:,2),{'Qt','Qbb','Qc','Qz'});
numt = size(tri,1);
for kk=1:numt             %integration over each triangle
    vv = zeros(1,2);
    vv(1,:) = vert(tri(kk,1),:);    %vertices of the triangle
    vv(2,:) = vert(tri(kk,2),:);    %vertices of the triangle
    vv(3,:) = vert(tri(kk,3),:);    %vertices of the triangle
    vm(1,:) = 0.5*(vv(1,:)+vv(2,:));
    vm(2,:) = 0.5*(vv(1,:)+vv(3,:));
    vm(3,:) = 0.5*(vv(2,:)+vv(3,:));
    %plot(vv(1:3,1),vv(1:3,2),'ro');
    %           drawnow;
    %           hold on;
    %           figure(100);
    %          fill(vv(:,1),vv(:,2),kk);
    %          drawnow;
    areaSmall = areaTri(vv);      %area of the triangle
    volume = areaSmall*(r2d(vm(1,1),vm(1,2))+r2d(vm(2,1),vm(2,2))+r2d(vm(3,1),vm(3,2)))/3 ;
    cenX = areaSmall*(centrX(vm(1,:))+centrX(vm(2,:))+centrX(vm(3,:)))/3; %integral of x over this triangle
    cenY = areaSmall*(centrY(vm(1,:))+centrY(vm(2,:))+centrY(vm(3,:)))/3; %integral of y over this triangle
    sumX = sumX + cenX;
    sumY = sumY + cenY;
    check = check + volume;
end

subcen(1:2) = [sumX/check, sumY/check];



function zz = centrX(x)
zz = r2d(x(1),x(2))*x(1);

function zz = centrY(x)
zz = r2d(x(1),x(2))*x(2);

function z = areaTri(vert)
side1 = norm(vert(1,:)-vert(2,:));%sqrt(sum((vert(1,:)-vert(2,:)).^2))
side2 = norm(vert(1,:)-vert(3,:));% side2 = sqrt(sum((vert(1,:)-vert(3,:)).^2))
side3 = norm(vert(2,:)-vert(3,:));%side3 = sqrt(sum((vert(2,:)-vert(3,:)).^2))
z = heron(side1,side2,side3);

function z=heron(a,b,c)
p=(a+b+c)/2;
z = sqrt(p*(p-a)*(p-b)*(p-c));


