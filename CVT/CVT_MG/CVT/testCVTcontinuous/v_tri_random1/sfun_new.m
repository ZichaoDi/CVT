function [E,gradient]=sfun_new(z)
global  N XYbd  current_n
global xlimit ylimit k 
global mminx mminy mmaxx mmaxy;

more off;
nn=length(z)/2;
xy=reshape(z,2,nn);
ind=find(current_n==N);
bond=XYbd{ind};
bdl(1,:) = 4*[-1 2 2 -1]*100;
bdl(2,:) = 4 *[-1 -1 2 2]*100;
mminx=-400;
mminy=-400;
mmaxx=800;
mmaxy=800;
bond=[bond bdl];
index=1:nn;
outdex=nn+1:nn+length(bond);
xytot=zeros(2,nn+length(bond));
xytot(:,index)=xy;
xytot(:,outdex)=bond;

%%%%%%%%%%%%%%%#############################Add a square large boundary
[v,c]=voronoin(xytot');

%%%####################################################################

figure(2)
% % drawnow;
% %plot(bond(1,:),bond(2,:),'ro');
voronoi(xytot(1,:),xytot(2,:),'k')
%plot(xytot(1,:),xytot(2,:),'ro')
hold on;
%plot(xlimit,ylimit,'b-');
for i=1:nn
    text(xy(1,i),xy(2,i),num2str(i));end
for i=1:length(bond)
    text(bond(1,i),bond(2,i),num2str(i));end
hold off;
%pause;
% return;

%%%%%%%%%%%%%%%######################################################
gradient = zeros(2,nn);
E = 0;
temp=cell(length(xytot),1);
vvv=cell(length(xytot),1);
for i=1:length(xytot)
    temp{i}=v(c{i},:);
end

for i=1:nn
    ind=index(i);
    %%%%#####################################################################
    %            figure(2)
    %         drawnow;
    %         voronoi(xytot(1,:),xytot(2,:))
    % %      for j=1:length(xytot)
    % %     text(xytot(1,j),xytot(2,j),num2str(j));end
    %     % return
    %     %     ind
    %     %     i
    %%%#####################################################################
    vert = temp{ind};  %vertices of ind-th cell
    notinf=find(vert(:,1)~=inf);
    if(length(notinf)~=length(vert))
        disp('Interior generator out of bound');
        %pause;
        %vert=vdata(cdata{ind},:);
        vert=vert(notinf,:);
        k2=convhull(vert(:,1),vert(:,2),'simplify',true);
        [outrex,outrey]=polyxpoly(xlimit(k),ylimit(k),vert(k2,1),vert(k2,2));
        IND=find(vert(:,2)<sqrt(3)*vert(:,1)+50*sqrt(3) & vert(:,2)<-sqrt(3)*vert(:,1)+50*sqrt(3) & vert(:,2)>0);
        cut=[outrex,outrey];
        vert=[vert(IND,:);cut];
        
    else
        if (size(vert,1)>2)
            k2=convhull(vert(:,1),vert(:,2),'simplify',true);
            [outrex,outrey]=polyxpoly(xlimit(k),ylimit(k),vert(k2,1),vert(k2,2));
            %%%cut the voronoi set into triangle domain by computing the intersection of voronoi set and triangle domain
            if (~isempty(outrex))
                IND=find(vert(:,2)<sqrt(3)*vert(:,1)+50*sqrt(3) & vert(:,2)<-sqrt(3)*vert(:,1)+50*sqrt(3) & vert(:,2)>0);
                cut=[outrex,outrey];
                vert=[vert(IND,:);cut];  %%replace the out of bound set boundary points by intersection cut in domain
            end
        end
    end
    %%%%##############################################
%                 figure(3);
%                 voronoi(xytot(1,:),xytot(2,:),'k')
%                 hold on;
%                 plot(xlimit,ylimit,'b-');
%                 plot(vert(:,1),vert(:,2),'ro');%triplot(tri,vert(:,1),vert(:,2),'r' )
%                 text(xy(1,i),xy(2,i),num2str(i));
%                 hold off;
%                 pause;
    %%%##############################################
    if(~isempty(vert))
        tri  = delaunay(vert(:,1),vert(:,2),{'Qt','Qbb','Qc','Qz'});
        vvv{ind}=vert;
        numt = size(tri,1);
        summ=0;
        for kk=1:numt             %integration over each triangle
            vv = zeros(1,2);
            vv(1,:) = vert(tri(kk,1),:);    %vertices of the triangle
            vv(2,:) = vert(tri(kk,2),:);    %vertices of the triangle
            vv(3,:) = vert(tri(kk,3),:);    %vertices of the triangle
            vm(1,:) = 0.5*(vv(1,:)+vv(2,:));
            vm(2,:) = 0.5*(vv(1,:)+vv(3,:));
            vm(3,:) = 0.5*(vv(2,:)+vv(3,:));
            areaSmall = areaTri(vv);      %area of the triangle
            intTri = areaSmall*(enerdist(vm(1,:),xy(:,i))+enerdist(vm(2,:),xy(:,i))+enerdist(vm(3,:),xy(:,i)))/3;
            intTri1 = areaSmall*(enerdist1(vm(1,:),xy(:,i))+enerdist1(vm(2,:),xy(:,i))+enerdist1(vm(3,:),xy(:,i)))/3;
            gradient(1,i)= gradient(1,i)+ intTri1;
            intTri2 = areaSmall*(enerdist2(vm(1,:),xy(:,i))+enerdist2(vm(2,:),xy(:,i))+enerdist2(vm(3,:),xy(:,i)))/3;
            gradient(2,i)= gradient(2,i)+ intTri2;
            summ = summ + intTri;
        end
        E = E + summ;
    end
end

%%#####################integral on boundary vertices#######################
for i=1:length(bond)
    ind=outdex(i);
    vert=temp{ind};
    num = size(vert,1);
    
    in = inpolygon(vert(:,1),vert(:,2),bdl(1,:),bdl(2,:));
    good = length(find(in));
    if (good<num)&(size(vert,1)>2) % modifications necessary
        in1 = inpolygon(bdl(1,:),bdl(2,:),vert(:,1),vert(:,2));
        vert = cutpoly(vert,in);
        corner = find(in1);
        if (~isempty(corner))
            if(i<length(bond)-3)
            vert = [vert; bdl(:,corner)'];
            else
            vert=[vert;bond(:,i)']; 
            end
            vert = vert(convhull(vert(:,1),vert(:,2)),:);
        end
        
    end
    
% %     %%%%#######################################################################
%           if(i==19 |i==20 |i==21 |i==22)
%               in
%               in1
%              vert
%              i
%              temp{ind}
%             figure(3);
%             voronoi(xytot(1,:),xytot(2,:),'k')
%             hold on;
%             plot(xlimit,ylimit,'b-');
%             plot(vert(:,1),vert(:,2),'ro');%triplot(tri,vert(:,1),vert(:,2),'r' )
%             text(bond(1,i),bond(2,i),num2str(i));
%             hold off;
%             pause;
%          end
    %%%%#######################################################################
    tri  = delaunay(vert(:,1),vert(:,2),{'Qt','Qbb','Qc','Qz'});
    vvv{ind}=vert;
    numt = size(tri,1);
    summ=0;
    for kk=1:numt             %integration over each triangle
        vv = zeros(1,2);
        vv(1,:) = vert(tri(kk,1),:);    %vertices of the triangle
        vv(2,:) = vert(tri(kk,2),:);    %vertices of the triangle
        vv(3,:) = vert(tri(kk,3),:);    %vertices of the triangle
        vm(1,:) = 0.5*(vv(1,:)+vv(2,:));
        vm(2,:) = 0.5*(vv(1,:)+vv(3,:));
        vm(3,:) = 0.5*(vv(2,:)+vv(3,:));
        areaSmall = areaTri(vv);      %area of the triangle
        intTri = areaSmall*(enerdist(vm(1,:),bond(:,i))+enerdist(vm(2,:),bond(:,i))+enerdist(vm(3,:),bond(:,i)))/3;
        summ = summ + intTri;
    end

    E = E + summ;
end
gradient=reshape(gradient,2*nn,1);


function zz = enerdist1(x,z)
zz = r2d(x(1),x(2))*(-2)*(x(1)-z(1));

function zz = enerdist2(x,z)
zz = r2d(x(1),x(2))*(-2)*(x(2)-z(2));

function zz = enerdist(x,z)
d2 = (x(1)-z(1))^2 + (x(2)-z(2))^2;
zz = r2d(x(1),x(2))*d2;

function z = areaTri(vert)
z=1/2*abs(det([vert';1 1 1]));


