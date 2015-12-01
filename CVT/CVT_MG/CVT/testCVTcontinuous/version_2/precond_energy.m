function E=precond__energy(data,v,c);
global mminx mminy mmaxx mmaxy ntot;

% data = centroids of the cells

N = size(data,2);
% data = centroids of the cells
gradient = zeros(2,ntot);
R=zeros(ntot,ntot);
E = 0;
%outer = convhull(data(1,:),data(2,:))'
%outer = [n0+1:N]; 
mmaxx;
%num = floor((mmaxx-mminx)/epsilon)+1;
dx=0.5; %1/sqrt(n0);
[x1,x2]=meshgrid(mminx:dx:mmaxx);
 bd(1,:) = [mminx mmaxx mmaxx mminx mminx ];
 bd(2,:) = [mminy mminy mmaxy mmaxy mminy ];

for ind = 1:ntot
    vert = v(c{ind},:);  %vertices of ind-th cell
    num = size(vert,1);
    
        
    %bad = length(find(vert(:,1)>mmaxx | vert(:,1)<mminx | vert(:,2)>mmaxy | vert(:,2)<mminy));
    
    %vx = [vert(:,1) ; vert(1,1)]; vy = [vert(:,2) ; vert(1,2)];     
    in = inpolygon(vert(:,1),vert(:,2),bd(1,:),bd(2,:));    
    good = length(find(in));
    %vert1=vert;
    %if (good==0) vert=[];        
    if (good<num)&(size(vert,1)>2) % modifications necessary 
     in1 = inpolygon(bd(1,:),bd(2,:),vert(:,1),vert(:,2));   
     vert = cutpoly(vert,in); 
     %vert2=vert;
     corner = find(in1);
     if (length(corner)>0)           
     vert = [vert; bd(:,corner)'];   
     vert = vert(convhull(vert(:,1),vert(:,2)),:);     
     end 
     %vert3=vert;
         %if(ind==3) vert1,vert2,vert3,end
     
    end 
     %figure(2); plot(vert(:,1),vert(:,2),'k*');
     %drawnow;       
    %if (~ismember(ind,outer))
  %if (size(vert,1)>2&&length(unique(vert,'rows'))>2&&length(unique(vert(:,1)))>=2&&length(unique(vert(:,2)))>=2)
  if (size(vert,1)>2&&length(unique(vert,'rows'))>2)
    ind;
        vert;
        tri  = delaunay(vert(:,1),vert(:,2),{'Qt','Qbb','Qc','Qz'});
        numt = size(tri,1); % number of small triangles
        for kk=1:numt             %integration over each triangle
            vv = zeros(1,2);
            vv(1,:) = vert(tri(kk,1),:);    %vertices of the triangle
            vv(2,:) = vert(tri(kk,2),:);    %vertices of the triangle
            vv(3,:) = vert(tri(kk,3),:);    %vertices of the triangle
            vm(1,:) = 0.5*(vv(1,:)+vv(2,:));
            vm(2,:) = 0.5*(vv(1,:)+vv(3,:));
            vm(3,:) = 0.5*(vv(2,:)+vv(3,:));
            %plot(vv(1:3,1),vv(1:3,2),'ro');
            %fill(vv(:,1),vv(:,2),kk);
            areaSmall = areaTri(vv);        %area of the triangle            
            intTri1 = areaSmall*(enerdist1(vm(1,:),data(:,ind))+enerdist1(vm(2,:),data(:,ind))+enerdist1(vm(3,:),data(:,ind)))/3;
            gradient(1,ind)= gradient(1,ind)+ intTri1;
            intTri2 = areaSmall*(enerdist2(vm(1,:),data(:,ind))+enerdist2(vm(2,:),data(:,ind))+enerdist2(vm(3,:),data(:,ind)))/3;
            gradient(2,ind)= gradient(2,ind)+ intTri2;
            R(ind,ind)=R(ind,ind)+areaSmall;
        end              
        
    end % if size(vert)>2
    
end
gradient=gradient;%*inv(R);
gradient=reshape(gradient,2*ntot,1);
E=gradient'*gradient/2;
%drawnow;

function zz = enerdist1(x,z)
d2 = (x(1)-z(1))^2 + (x(2)-z(2))^2;
zz = r2d(x(1),x(2))*(-2)*(x(1)-z(1));

function zz = enerdist2(x,z)
d2 = (x(1)-z(1))^2 + (x(2)-z(2))^2;
zz = r2d(x(1),x(2))*(-2)*(x(2)-z(2));

function z = areaTri(vert)
 side1 = norm(vert(1,:)-vert(2,:));%sqrt(sum((vert(1,:)-vert(2,:)).^2))
 side2 = norm(vert(1,:)-vert(3,:));% side2 = sqrt(sum((vert(1,:)-vert(3,:)).^2))
 side3 = norm(vert(2,:)-vert(3,:));%side3 = sqrt(sum((vert(2,:)-vert(3,:)).^2))       
 z = heron(side1,side2,side3);

function z=heron(a,b,c)
p=(a+b+c)/2;
z = sqrt(p*(p-a)*(p-b)*(p-c));


