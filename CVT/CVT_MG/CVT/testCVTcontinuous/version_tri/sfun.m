function [E,gradient]=sfun(z)
global  N XYbd inner bd
global xlimit ylimit k
more off;
nn=length(z)/2;
ind=find(nn==N);
bond=XYbd{ind};
xy=reshape(z,2,nn);
index=inner{ind};
xytot=zeros(2,nn+length(bond));
xytot(:,index)=xy;
outdex=bd{ind};
xytot(:,outdex)=bond;
TRI=delaunay(xytot(1,:),xytot(2,:));
%%%%%%%%%%%%%%%#############################Add a square large boundary
% bd1(1,:) = 4*[-1 2 2 -1 -1 ]*100;
% bd1(2,:) = 4 *[-1 -1 2 2 -1]*100;
% xydata= [xytot  bd1];
%[v,c]=voronoin(xydata');
[v,c]=voronoin(xytot');
%%%####################################################################
% figure(12)
% % drawnow;
% %plot(bond(1,:),bond(2,:),'ro');hold on;
% voronoi(xytot(1,:),xytot(2,:),'k')
% % %      text(xy(1,490),xy(2,490),num2str(490));
% 
% for i=1:N(1)
%      text(xy(1,i),xy(2,i),num2str(i),'FontSize',18);
% end
% hold off;
% % return;
%%%%%%%%%%%%%%%######################################################
gradient = zeros(2,nn);
E = 0;
donebounds=[];
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
    %     if(length(notinf)~=length(vert))
    %         disp('Interior generator out of bound');
    %     end
    vert=vert(notinf,:);
    if (size(vert,1)>2)
        k2=convhull(vert(:,1),vert(:,2));
        [outrex,outrey]=polyxpoly(xlimit(k),ylimit(k),vert(k2,1),vert(k2,2));
        %%%cut the voronoi set into triangle domain by computing the intersection of voronoi set and triangle domain
        if (~isempty(outrex))
            IND=find(vert(:,2)<sqrt(3)*vert(:,1)+50*sqrt(3) & vert(:,2)<-sqrt(3)*vert(:,1)+50*sqrt(3) & vert(:,2)>0);
            cut=[outrex,outrey];
            vert=[vert(IND,:);cut];  %%replace the out of bound set boundary points by intersection cut in domain
            [adi,adj]=find(TRI==ind);
            adi=unique(TRI(adi,:)); adi=intersect(outdex,adi);
            if(length(adi)>=3)
                tempcom=repmat(xytot(:,ind)',length(adi),1);
                [min2,indmin]=sort(sum((tempcom-xytot(:,adi)').^2,2));
                adi=adi(indmin(1:2));
            end
            if(length(adi)==2)
                if(size(cut,1)==2)  %% Apply the found intersectio to the adjacent boundary generator to avoid repeating calculation
                    %disp('length2')
                    par=[norm(xytot(:,adi(1))-cut(1,:)'),norm(xytot(:,adi(1))-cut(2,:)')];
                    [par, adii]=min(par); %% For the first adjacency
                    vertb1=temp{adi(1)};
                    b1in=find(vertb1(:,1)~=inf);
                    vertb1=vertb1(b1in,:);
                    %                 hold off;
                    %  figure(333);plot(xlimit(k),ylimit(k),'r.-', xytot(1,adi(1)),xytot(2,adi(1)),'bo',vertb1(:,1),vertb1(:,2),'g*');
                    % for i=1:length(vertb1) text(vertb1(i,1),vertb1(i,2),num2str(i));end
                    %                 hold on;
                    % plot(xytot(1,453),xytot(2,453),'ro',xytot(1,1551),xytot(2,1551),'ro',xytot(1,2143),xytot(2,2143),'ro',xytot(1,ind),xytot(2,ind),'go')
                    inb1=find(vertb1(:,2)-sqrt(3)*vertb1(:,1)-50*sqrt(3)>1e-12 | vertb1(:,2)+sqrt(3)*vertb1(:,1)-50*sqrt(3)>1e-12 | vertb1(:,2)<0 );
                    %%%%%##############################################
                    %                  if(142==adi(1))
                    %                             outb=length(inb1)
                    %                             save vertb1 vertb1;
                    %                             disp('1')
                    %                  end
                    %%%%%%%%%%%%###################################
                    
                    [inn2,inn1]=setdiff([1:1:length(vertb1)],inb1);
                    if(length(inb1)>=3)
                        localtri=delaunay(vertb1(:,1),vertb1(:,2));
                        oldvertb1=vertb1;
                        for t=1:length(inb1)
                            [ear1,ear2]=find(localtri==inb1(t));
                            if(~ismember(inn1,localtri(ear1,:)))
                                vertb1=setdiff(vertb1,oldvertb1(inb1(t),:),'rows');
                            end
                        end
                        inb1=find(vertb1(:,2)-sqrt(3)*vertb1(:,1)-50*sqrt(3)>1e-12 | vertb1(:,2)+sqrt(3)*vertb1(:,1)-50*sqrt(3)>1e-12 | vertb1(:,2)<0 );
                    end
                    
                    if(length(inb1)==1)
                        vertb1(inb1,:)=cut(adii,:);
                        [adib1,adjb1]=find(TRI==adi(1));
                        adib1=unique(TRI(adib1,:)); adib1=intersect(outdex,adib1);
                        adib1=setdiff(adib1,adi);
                        if(~isempty(adib1))
                            if(length(adib1)>1);
                                %                         outb=length(adib1)
                                %                         in1=adi(1)
                                %                         ind
                                if (abs((xytot(2,adib1(1))-xytot(2,adi(1)))/(xytot(1,adib1(1))-xytot(1,adi(1)))-(xytot(2,adi(2))-xytot(2,adi(1)))/(xytot(1,adi(2))-xytot(1,adi(1))))<=1e-6); adib1=adib1(1);
                                else adib1=adib1(2);
                                end;
                            end
                            if( ~isempty(b1in))
                                %                         z1=adi(1)
                                %                         adib1
                                mid=(xytot(:,adi(1))+xytot(:,adib1))/2;
                                vertb1=[vertb1;mid'];
                            else
                                %disp('the current boundary generator has two out of bound voronoi set points and one has been cut ')
                            end
                        end
                        
                    elseif (length(inb1)==2)
                        %disp('the current boundary generator has two out of bound voronoi set points and start cutting from the first one')
                        par=[norm(vertb1(inb1(1),:)-xytot(:,ind)'),norm(vertb1(inb1(2),:)-xytot(:,ind)')];
                        [par1, a1]=min(par); %% For the first adjacency
                        vertb1(inb1(a1),:)=cut(adii,:);
                    end
                    temp{adi(1)}=vertb1;
                    %%%%%%%%%%#################################################
                    %%%%%%%%%%###############
                    vertb2=temp{adi(2)};  %% For the second adjacency
                    b1in=find(vertb2(:,1)~=inf);
                    vertb2=vertb2(b1in,:);
                    %                   figure(333);plot(xlimit(k),ylimit(k),'r.-', xytot(1,adi(2)),xytot(2,adi(2)),'bo',vertb2(:,1),vertb2(:,2),'g*'); for i=1:length(vertb2) text(vertb2(i,1),vertb2(i,2),num2str(i));end
                    %                   hold on; plot(xytot(1,adi(2)),xytot(2,adi(2)),'m*')
                    %plot(xytot(1,453),xytot(2,453),'ro',xytot(1,1551),xytot(2,1551),'ro',xytot(1,2143),xytot(2,2143),'ro',xytot(1,ind),xytot(2,ind),'go')
                    inb2=find(vertb2(:,2)-sqrt(3)*vertb2(:,1)-50*sqrt(3)>1e-12 | vertb2(:,2)+sqrt(3)*vertb2(:,1)-50*sqrt(3)>1e-12 | vertb2(:,2)<0);
                    %%%%%##############################################
                    %                  if(142==adi(2))
                    %                             outb=length(inb2)
                    %                             disp('2')
                    %                  end
                    %%%%%%%%%%%%###################################
                    [inn2,inn1]=setdiff([1:1:length(vertb2)],inb2);
                    if(length(inb2)>=3)
                        localtri=delaunay(vertb2(:,1),vertb2(:,2));
                        oldvertb2=vertb2;
                        for t=1:length(inb2)
                            [ear1,ear2]=find(localtri==inb2(t));
                            if(~ismember(inn1,localtri(ear1,:)))
                                vertb2=setdiff(vertb2,oldvertb2(inb2(t),:),'rows');
                            end
                        end
                        inb2=find(vertb2(:,2)-sqrt(3)*vertb2(:,1)-50*sqrt(3)>1e-12 | vertb2(:,2)+sqrt(3)*vertb2(:,1)-50*sqrt(3)>1e-12 | vertb2(:,2)<0 );
                    end
                    
                    if(length(inb2)==1)
                        vertb2(inb2,:)=cut(-adii+3,:);
                        [adib2,adjb2]=find(TRI==adi(2));
                        adib2=unique(TRI(adib2,:)); adib2=intersect(outdex,adib2);
                        adib2=setdiff(adib2,adi);
                        if(~isempty(adib2))
                            if(length(adib2)>1);
                                if (abs((xytot(2,adib2(1))-xytot(2,adi(2)))/(xytot(1,adib2(1))-xytot(1,adi(2)))-(xytot(2,adi(2))-xytot(2,adi(1)))/(xytot(1,adi(2))-xytot(1,adi(1))))<=1e-6); adib2=adib2(1);
                                else adib2=adib2(2);
                                end;
                            end
                            if( ~isempty(b1in))
                                mid=(xytot(:,adi(2))+xytot(:,adib2))/2;
                                vertb2=[vertb2;mid'];
                            else
                                % disp('the current boundary generator has two out of bound voronoi set points and one has been cut ')
                            end
                        end
                    elseif (length(inb2)==2)
                        %disp('the current boundary generator has two out of bound voronoi set points and start cutting from the first one')
                        par=[norm(vertb2(inb2(1),:)-xytot(:,ind)'),norm(vertb2(inb2(2),:)-xytot(:,ind)')];
                        [par2, a2]=min(par); %% For the first adjacency
                        vertb2(inb2(a2),:)=cut(-adii+3,:);
                    end
                    temp{adi(2)}=vertb2;%% End cut voronoi set boundary point to every related generator
                else  %%the current voronoi set has more than 2 intersections with triangle
                    
                    
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            elseif(length(adi)==1)
                if(size(cut,1)>1)
                    A=[norm(xytot(:,adi)-cut(1,:)'),norm(xytot(:,adi)-cut(2,:)')];
                    [n2,m2]=min(A);
                    cut=cut(m2,:);
                end
                vertb1=temp{adi};
                b1in=find(vertb1(:,1)~=inf);
                vertb1=vertb1(b1in,:);
                %                 hold off;
                %  figure(333);plot(xlimit(k),ylimit(k),'r.-', xytot(1,adi(1)),xytot(2,adi(1)),'bo',vertb1(:,1),vertb1(:,2),'g*'); for i=1:length(vertb1) text(vertb1(i,1),vertb1(i,2),num2str(i));end
                %                 hold on; plot(xytot(1,453),xytot(2,453),'ro',xytot(1,1551),xytot(2,1551),'ro',xytot(1,2143),xytot(2,2143),'ro',xytot(1,ind),xytot(2,ind),'go')
                inb1=find(vertb1(:,2)-sqrt(3)*vertb1(:,1)-50*sqrt(3)>1e-12 | vertb1(:,2)+sqrt(3)*vertb1(:,1)-50*sqrt(3)>1e-12 | vertb1(:,2)<0 );
                %%%%%##############################################
                %                  if(142==adi)
                %                             outb=length(inb1)
                %                             disp('3')
                %                  end
                %%%%%%%%%%%%###################################
                [inn2,inn1]=setdiff([1:1:length(vertb1)],inb1);
                if(length(inb1)>=3)
                    localtri=delaunay(vertb1(:,1),vertb1(:,2));
                    oldvertb1=vertb1;
                    for t=1:length(inb1)
                        [ear1,ear2]=find(localtri==inb1(t));
                        if(~ismember(inn1,localtri(ear1,:)))
                            vertb1=setdiff(vertb1,oldvertb1(inb1(t),:),'rows');
                        end
                    end
                    inb1=find(vertb1(:,2)-sqrt(3)*vertb1(:,1)-50*sqrt(3)>1e-12 | vertb1(:,2)+sqrt(3)*vertb1(:,1)-50*sqrt(3)>1e-12 | vertb1(:,2)<0 );
                end
                if(length(inb1)==1)
                    vertb1(inb1,:)=cut;
                    if( ~isempty(b1in))
                        [adib1,adjb1]=find(TRI==adi);
                        adib1=unique(TRI(adib1,:)); adib1=intersect(outdex,adib1);
                        adib1=setdiff(adib1,adi);
                        if(~isempty(adib1))
                            if(length(adib1)>1);
                                if(length(adib1)>2)
                                    for j=1:length(adib1)
                                        slope(j)=(xytot(2,adib1(j))-cut(2))/(xytot(1,adib1(j))-cut(1));
                                    end
                                    for i=1:length(adib1)
                                        for j=i+1:length(adib1)
                                            diff=abs(slope(i)-slope(j)); if(diff<1e-5) adib1=[adib1(i),adib1(j)];break; end
                                        end
                                    end
                                end
                                A=[norm(xytot(:,adib1(1))-cut'),norm(xytot(:,adib1(2))-cut')];
                                [maxx1,maxx]=max(A);
                                adib1=adib1(maxx);
                            end
                            mid=(xytot(:,adi)+xytot(:,adib1))/2;
                            vertb1=[vertb1;mid'];
                        end
                    else
                        % disp('the current boundary generator has two out of bound voronoi set points and one has been cut ')
                    end
                    
                elseif (length(inb1)==2)
                    % disp('the current boundary generator has two out of bound voronoi set points and start cutting from the first one')
                    par=[norm(vertb1(inb1(1),:)-xytot(:,ind)'),norm(vertb1(inb1(2),:)-xytot(:,ind)')];
                    [par1, a1]=min(par); %% For the first adjacency
                    vertb1(inb1(a1),:)=cut;
                end
                temp{adi}=vertb1;
            end
            donebounds=[donebounds;adi];
        end
%         figure(2);
%         voronoi(xytot(1,:),xytot(2,:),'k')
%         hold on;
%         plot(xlimit,ylimit,'b-');
%         plot(vert(:,1),vert(:,2),'ro');%triplot(tri,vert(:,1),vert(:,2),'r' )
%         text(xy(1,i),xy(2,i),num2str(i));
%         hold off;
%         pause;
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
        
    end
    
    E = E + summ;
end
%%%%%%%%%%%integral on boundary vertices
%%########################################################################
mm=length(bond);
for i=1:mm    %% loop of compute energy on the boundary generators
    ind=outdex(i);
    vert = v(c{ind},:);  %vertices of ind-th boundary cell
    if(~ismember(ind,donebounds)) %% cut the boundary voronoi set in triangle domain without effected by interior generators
        realv=find(vert(:,1)~=inf & vert(:,2)~=inf);
        xyind1=ones(1,mm)*bond(1,i);
        xyind2=ones(1,mm)*bond(2,i);
        dd=(xyind1-bond(1,:)).^2+(xyind2-bond(2,:)).^2;
        [dd,ix]=sort(dd);
        vu=(bond(:,i)+bond(:,ix(2)))./2;
        vl=(bond(:,i)+bond(:,ix(3)))./2;
        if (size(vert,1)>2)
            m1=(vl(2)-bond(2,i))/(vl(1)-bond(1,i));
            m2=(vu(2)-bond(2,i))/(vu(1)-bond(1,i));
            if(abs(m1-m2)>1e-8)
                vl=(bond(:,i)+bond(:,ix(4)))./2;
                m1=(vl(2)-bond(2,i))/(vl(1)-bond(1,i));
                m2=(vu(2)-bond(2,i))/(vu(1)-bond(1,i));
            end
            if(abs(m1-m2)>1e-8)
                vl=(bond(:,i)+bond(:,ix(3)))./2;
                vu=(bond(:,i)+bond(:,ix(4)))./2;
            end
            vert=[vert(realv,:);vu';vl'];
        else
            vert=[vert(realv,:);vu';vl';bond(:,i)'];
            
            
            
        end
        subin=find(vert(:,2)-sqrt(3)*vert(:,1)-50*sqrt(3)<=1e-5 & vert(:,2)+sqrt(3)*vert(:,1)-50*sqrt(3)<=1e-5 & vert(:,2)>=0);
        vert=vert(subin,:);
    elseif(ismember(ind,donebounds))
        vert=temp{ind};
    end
%     figure(2);
%     voronoi(xytot(1,:),xytot(2,:),'k')
%     hold on;
%     plot(xlimit,ylimit,'b-');
%     plot(vert(:,1),vert(:,2),'ro');%triplot(tri,vert(:,1),vert(:,2),'r' )
%     text(bond(1,i),bond(2,i),num2str(i));
%     hold off;
%     pause;
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
side1 = norm(vert(1,:)-vert(2,:));%sqrt(sum((vert(1,:)-vert(2,:)).^2))
side2 = norm(vert(1,:)-vert(3,:));% side2 = sqrt(sum((vert(1,:)-vert(3,:)).^2))
side3 = norm(vert(2,:)-vert(3,:));%side3 = sqrt(sum((vert(2,:)-vert(3,:)).^2))
z = heron(side1,side2,side3);

function z=heron(a,b,c)
p=(a+b+c)/2;
z = sqrt(p*(p-a)*(p-b)*(p-c));

