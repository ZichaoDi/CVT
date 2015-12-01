function E=energy(data,v,c);
global mminx mminy mmaxx mmaxy ntot;
% data = centroids of the cells
N = size(data,2);

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
    
    summ = 0;
    vert = v(c{ind},:);  %vertices of ind-th cell
    num = size(vert,1);
    
        
    %bad = length(find(vert(:,1)>mmaxx | vert(:,1)<mminx | vert(:,2)>mmaxy | vert(:,2)<mminy));
    
    %vx = [vert(:,1) ; vert(1,1)]; vy = [vert(:,2) ; vert(1,2)];     
    
    in = inpolygon(vert(:,1),vert(:,2),bd(1,:),bd(2,:));    
    good = length(find(in));
    %if (good==0) vert=[];       
    
    if (good<num)&(size(vert,1)>2) % modifications necessary 
     in1 = inpolygon(bd(1,:),bd(2,:),vert(:,1),vert(:,2));   
     
     vert = cutpoly(vert,in); 
     
     corner = find(in1);
     if (length(corner)>0)           
     vert = [vert; bd(:,corner)'];
     
     vert = vert(convhull(vert(:,1),vert(:,2)),:);     
     end   
     
    % if (ind==22) vert, convhull(vert(:,1),vert(:,2)), end
     
    end 
   % if (ind==22) vert, end
    
     
%      figure(2); hold on;plot(vert(:,1),vert(:,2),'r.-',data(1,ind),data(2,ind),'k*');
%      text(data(1,ind),data(2,ind),num2str(ind));
%      drawnow; 
     
    % pause(2);

    if (size(vert,1)>2&&length(unique(vert,'rows'))>2)
    ind;
        tri  = delaunay(vert(:,1),vert(:,2),{'Qt','Qbb','Qc','Qz'});
        %if (ind==14) figure(7);triplot(tri,vert(:,1),vert(:,2)); end
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
            intTri = areaSmall*(enerdist(vm(1,:),data(:,ind))+enerdist(vm(2,:),data(:,ind))+enerdist(vm(3,:),data(:,ind)))/3;
            summ = summ + intTri;
        end              
        
    end % if size(vert)>2
    
    E = E + summ;

end

%drawnow;

function zz = enerdist(x,z)
d2 = (x(1)-z(1))^2 + (x(2)-z(2))^2;
zz = r2d(x(1),x(2))*d2;

function z = areaTri(vert)
 side1 = norm(vert(1,:)-vert(2,:));%sqrt(sum((vert(1,:)-vert(2,:)).^2))
 side2 = norm(vert(1,:)-vert(3,:));% side2 = sqrt(sum((vert(1,:)-vert(3,:)).^2))
 side3 = norm(vert(2,:)-vert(3,:));%side3 = sqrt(sum((vert(2,:)-vert(3,:)).^2))       
 z = heron(side1,side2,side3);

function z=heron(a,b,c)
p=(a+b+c)/2;
z = sqrt(p*(p-a)*(p-b)*(p-c));


