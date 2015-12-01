function [E,gradient]=sfun(z)
global  N XYbd  current_n XY
global xlimit ylimit k bondgrad current_v;
more off;
nn=length(z)/2;
xy=reshape(z,2,nn);

% figure(4);plot(xy(1,:),xy(2,:),'ro');
% hold on;
% voronoi(xy(1,:),xy(2,:));
% plot(xlimit,ylimit,'b-');
% hold off;
ind=find(current_n==N);
bond=XYbd{ind};
index=1:nn;
outdex=nn+1:nn+length(bond);
xytot=zeros(2,nn+length(bond));
xytot(:,index)=xy;
xytot(:,outdex)=bond;
pt1=find(xlimit(1)==bond(1,:)& ylimit(1)==bond(2,:));
pt2=find(xlimit(2)==bond(1,:)& ylimit(2)==bond(2,:));
pt3=find(xlimit(3)==bond(1,:)& ylimit(3)==bond(2,:));
%%%%%%%%%%%%%%%#############################Add a square large boundary
bd1(1,:) = 4*[-1 2 2 -1]*100;
bd1(2,:) = 4 *[-1 -1 2 2]*100;
xydata= [xytot  bd1];
[v,c]=voronoin(xydata');
%%%%%%%%%%%%%%#########################################################
%[v,c]=voronoin(xytot');
%%%####################################################################

% figure(3)
% % % drawnow;
% % %plot(bond(1,:),bond(2,:),'ro');
% voronoi(xytot(1,:),xytot(2,:),'k')
% % hold on;
% % tesp=reshape(current_v,2,length(current_v)/2);
% % plot(tesp(1,:),tesp(2,:),'ro')
% % tes2=XY{2};
% % plot(tes2(1,:),tes2(2,:),'go');
% for i=1:nn
%     text(xy(1,i),xy(2,i),num2str(i),'FontSize',18);end
% % for i=1:length(current_v)/2
% %     text(tesp(1,i),tesp(2,i),num2str(i),'FontSize',14);end
% hold off;
% %  if(current_n==N(2))
%  pause;
% %  end
% %return;

%%%%%%%%%%%%%%%######################################################
gradient = zeros(2,nn);
bondgrad=zeros(2,length(bond));
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
    %vert = v(c{ind},:);  %vertices of ind-th cell
    vert = temp{ind};  %vertices of ind-th cell
    notinf=find(vert(:,1)~=inf);
    if(length(notinf)~=length(vert))
        disp('Interior generator out of bound');
        %return;
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
    %     if(nn==10)
%                 figure(3);
%                 voronoi(xytot(1,:),xytot(2,:),'k')
%                 hold on;
%                 plot(xlimit,ylimit,'b-');
%                 plot(vert(:,1),vert(:,2),'ro');%triplot(tri,vert(:,1),vert(:,2),'r' )
%                 text(xy(1,i),xy(2,i),num2str(i));
%                 hold off;
%                 pause;
    %     end
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
%%%%%%%%%%%integral on boundary vertices
%%########################################################################
mm=length(bond);
for i=1:mm    %% loop of compute energy on the boundary generators
    ind=outdex(i);
    vert = v(c{ind},:);  %vertices of ind-th boundary cell
    infind=find(vert(:,1)==inf);
    IND=find(vert(:,2)<sqrt(3)*vert(:,1)+50*sqrt(3) & vert(:,2)<-sqrt(3)*vert(:,1)+50*sqrt(3) & vert(:,2)>0);
    if(length(infind)==1)
        outind=find(vert(:,2)>sqrt(3)*vert(:,1)+50*sqrt(3) | vert(:,2)>-sqrt(3)*vert(:,1)+50*sqrt(3) | vert(:,2)<0);
        outind=setdiff(outind,infind);
        xyind1=ones(1,mm)*bond(1,i);
        xyind2=ones(1,mm)*bond(2,i);
        dd=(xyind1-bond(1,:)).^2+(xyind2-bond(2,:)).^2;
        [dd,ix]=sort(dd);
        li=ix(2);
        ui=ix(3);
        if(abs(dd(2)-dd(3))<=1e-8 & abs(dd(3)-dd(4))<=1e-8)
            
            sp2=(bond(2,i)-bond(2,ix(2)))/(bond(1,i)-bond(1,ix(2)));
            sp3=(bond(2,i)-bond(2,ix(3)))/(bond(1,i)-bond(1,ix(3)));
            sp4=(bond(2,i)-bond(2,ix(4)))/(bond(1,i)-bond(1,ix(4)));
            if(abs(sp4-sp3)<=1e-8)
                li=ix(4);
                ui=ix(3);
            elseif(abs(sp4-sp2)<=1e-8)
                li=ix(4);
                ui=ix(2);
            else
                li=ix(3);
                ui=ix(2);
            end
        end
        
        if(length(outind)==1)
            adind=[li,ui];
            [vs,inds]=max([norm(vert(outind,:)-bond(:,li)'),norm(vert(outind,:)-bond(:,ui)')]);
            vu=(bond(:,i)+bond(:,adind(inds)))./2;
            vert1=[vert(IND,:);vu';vert(outind,:)];
            if(i==pt1 | i==pt2 |i==pt3)
                vert1=[vert1;bond(:,i)'];
            end
            k2=convhull(vert1(:,1),vert1(:,2),'simplify',true);
            [outrex,outrey]=polyxpoly(xlimit(k),ylimit(k),vert1(k2,1),vert1(k2,2));
            cut=[outrex,outrey];
            vert=[vert(IND,:);vu';cut];  %%replace the out of bound set boundary points by intersection cut in domain
            if(i==pt1 | i==pt2 |i==pt3)
                vert=[vert;bond(:,i)'];
            end
        elseif(isempty(outind))
            vl=(bond(:,i)+bond(:,li))./2;
            vu=(bond(:,i)+bond(:,ui))./2;
            vert=[vert(IND,:);vl';vu'];
            if(i==pt1 | i==pt2 |i==pt3)
                vert=[vert;bond(:,i)'];
            end
            
        else
            if(~isempty(IND))
                vert1=[vert(IND,:);vert(outind,:)];
            else
                vert1=[vert(outind,:)];
            end
            if(i==pt1 | i==pt2 |i==pt3)
                vert1=[vert1;bond(:,i)'];
            end
            k2=convhull(vert1(:,1),vert1(:,2),'simplify',true);
            [outrex,outrey]=polyxpoly(xlimit(k),ylimit(k),vert1(k2,1),vert1(k2,2));
            cut=[outrex,outrey];
            vert=[vert(IND,:);cut];  %%replace the out of bound set boundary points by intersection cut in domain
            if(i==pt1 | i==pt2 |i==pt3)
                vert=[vert;bond(:,i)'];
            end
        end
    else
        k2=convhull(vert(:,1),vert(:,2),'simplify',true);
        [outrex,outrey]=polyxpoly(xlimit(k),ylimit(k),vert(k2,1),vert(k2,2));
        cut=[outrex,outrey];
        vert=[vert(IND,:);cut];
        if(i==pt1 | i==pt2 |i==pt3)
            vert=[vert;bond(:,i)'];
        end
        
    end
    
    %%%%#######################################################################
%      if(i==10)
%         vert
%         i
%         figure(3);
%         voronoi(xytot(1,:),xytot(2,:),'k')
%         hold on;
%         plot(xlimit,ylimit,'b-');
%         plot(vert(:,1),vert(:,2),'ro');%triplot(tri,vert(:,1),vert(:,2),'r' )
%         text(bond(1,i),bond(2,i),num2str(i));
%         hold off;
      
%     end
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
        intTri1 = areaSmall*(enerdist1(vm(1,:),bond(:,i))+enerdist1(vm(2,:),bond(:,i))+enerdist1(vm(3,:),bond(:,i)))/3;
            bondgrad(1,i)= bondgrad(1,i)+ intTri1;
            intTri2 = areaSmall*(enerdist2(vm(1,:),bond(:,i))+enerdist2(vm(2,:),bond(:,i))+enerdist2(vm(3,:),bond(:,i)))/3;
            bondgrad(2,i)= bondgrad(2,i)+ intTri2;
        summ = summ + intTri;        
    end
    %%%#######################################################################
    %
    %             if(i==3 | i==5 | i==14)
    %                 i
    %                 summ
    %             end
    %%%#######################################################################
    
    E = E + summ;
end
gradient=reshape(gradient,2*nn,1);



% gold=gradient;
% Eold=E;
% load fnl2
% E     = E - z'*fnl2;
% gradient     = gradient - fnl2;
% Eold
% E
% figure(34);plot(1:2*nn,gradient,'r.-',1:2*nn,gold,'b*-');
% pause;
% 




function zz = enerdist1(x,z)
zz = r2d(x(1),x(2))*(-2)*(x(1)-z(1));

function zz = enerdist2(x,z)
zz = r2d(x(1),x(2))*(-2)*(x(2)-z(2));

function zz = enerdist(x,z)
d2 = (x(1)-z(1))^2 + (x(2)-z(2))^2;
zz = r2d(x(1),x(2))*d2;

function z = areaTri(vert)
z=1/2*abs(det([vert';1 1 1]));
