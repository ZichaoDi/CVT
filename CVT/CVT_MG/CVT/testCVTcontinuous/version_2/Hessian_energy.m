function [H,DT]=Hessian_energy(XY);
%%% usage: compute the Hessian of 2D-CVT with constant density at the
%%% stationary point
global mminx mminy mmaxx mmaxy N
ntot=size(XY,2);
% data = centroinds of the cells
bd1(1,:) = 2*[-1 2 2 -1 -1 ]*mmaxx;
bd1(2,:) = 2*[-1 -1 2 2 -1]*mmaxy;
data= [XY  bd1];
[v,c]=voronoin(data');
N = size(data,2);
bd(1,:) = [mminx mmaxx mmaxx mminx mminx ];
bd(2,:) = [mminy mminy mmaxy mmaxy mminy ];
A = adjacency1(data');%%find the neighborhood of each generator
DT=zeros(2*N,2*N);
area=[];
for ind = 1:ntot
    vert = v(c{ind},:);  %vertices of ind-th cell
    num = size(vert,1);
    in = inpolygon(vert(:,1),vert(:,2),bd(1,:),bd(2,:));
    good = length(find(in));
    if (good<num)&(size(vert,1)>2) % modifications necessary
        in1 = inpolygon(bd(1,:),bd(2,:),vert(:,1),vert(:,2));
        vert = cutpoly(vert,in);
        corner = find(in1);
        if (length(corner)>0)
            vert = [vert; bd(:,corner)'];
            vert = vert(convhull(vert(:,1),vert(:,2)),:);
        end
    end
    if (size(vert,1)>2&&length(unique(vert,'rows'))>2)
        nearind=find(A(ind,:));%%% index of neighboring generators
        nne=length(nearind);%%% number of neighboring generators
        [CC,D]=circumcenter(vert,data,nearind);
        tri  = delaunay(vert(:,1),vert(:,2),{'Qt','Qbb','Qc','Qz'});
        numt = size(tri,1); % number of small triangles
        for kk=1:numt             
            vv = zeros(1,2);
            vv(1,:) = vert(tri(kk,1),:);    %vertices of the triangle
            vv(2,:) = vert(tri(kk,2),:);    %vertices of the triangle
            vv(3,:) = vert(tri(kk,3),:);    %vertices of the triangle
            dar=vv(1,1)*vv(2,2)-vv(3,1)*vv(2,2)+vv(3,1)*vv(1,2)-vv(1,1)*vv(3,2)+vv(2,1)*vv(3,2)-vv(2,1)*vv(1,2);
            areaSmall(kk) =abs(dar);%area of each triangle
            cx(kk)=vv(1,1)+vv(2,1)+vv(3,1);% x-component of centroid of triangle
            cy(kk)=vv(1,2)+vv(2,2)+vv(3,2);% y-component of centroid of triangle
            for tt=1:nne
                dareax(kk,nearind(tt))=(dar/areaSmall(kk))*(D(2*tri(kk,1)-1,2*nearind(tt)-1)*vv(2,2)+D(2*tri(kk,2),2*nearind(tt)-1)*vv(1,1)-D(2*tri(kk,3)-1,2*nearind(tt)-1)*vv(2,2)-vv(3,1)*D(2*tri(kk,2),2*nearind(tt)-1)+D(2*tri(kk,3)-1,2*nearind(tt)-1)*vv(1,2)...
                    +vv(3,1)*D(2*tri(kk,1),2*nearind(tt)-1)-D(2*tri(kk,1)-1,2*nearind(tt)-1)*vv(3,2)-vv(1,1)*D(2*tri(kk,3),2*nearind(tt)-1)+D(2*tri(kk,2)-1,2*nearind(tt)-1)*vv(3,2)+vv(2,1)*D(2*tri(kk,3),2*nearind(tt)-1)-D(2*tri(kk,2)-1,2*nearind(tt)-1)*vv(1,2)...
                    -vv(2,1)*D(2*tri(kk,1),2*nearind(tt)-1));  %% partial derivative of area with respect to x
                dareay(kk,nearind(tt))=(dar/areaSmall(kk))*(D(2*tri(kk,1)-1,2*nearind(tt))*vv(2,2)+D(2*tri(kk,2),2*nearind(tt))*vv(1,1)-D(2*tri(kk,3)-1,2*nearind(tt))*vv(2,2)-vv(3,1)*D(2*tri(kk,2),2*nearind(tt))+D(2*tri(kk,3)-1,2*nearind(tt))*vv(1,2)...
                    +vv(3,1)*D(2*tri(kk,1),2*nearind(tt))-D(2*tri(kk,1)-1,2*nearind(tt))*vv(3,2)-vv(1,1)*D(2*tri(kk,3),2*nearind(tt))+D(2*tri(kk,2)-1,2*nearind(tt))*vv(3,2)+vv(2,1)*D(2*tri(kk,3),2*nearind(tt))-D(2*tri(kk,2)-1,2*nearind(tt))*vv(1,2)...
                    -vv(2,1)*D(2*tri(kk,1),2*nearind(tt)));    %% partial derivative of area with respect to y
                dcxx(kk,nearind(tt))=D(2*tri(kk,1)-1,2*nearind(tt)-1)+D(2*tri(kk,2)-1,2*nearind(tt)-1)+D(2*tri(kk,3)-1,2*nearind(tt)-1); %% partial derivative of x-component of centroid with respect to x
                dcxy(kk,nearind(tt))=D(2*tri(kk,1)-1,2*nearind(tt))+D(2*tri(kk,2)-1,2*nearind(tt))+D(2*tri(kk,3)-1,2*nearind(tt)); %% partial derivative of x-component of centroid with respect to y
                dcyx(kk,nearind(tt))=D(2*tri(kk,1),2*nearind(tt)-1)+D(2*tri(kk,2),2*nearind(tt)-1)+D(2*tri(kk,3),2*nearind(tt)-1); %% partial derivative of y-component of centroid with respect to x
                dcyy(kk,nearind(tt))=D(2*tri(kk,1),2*nearind(tt))+D(2*tri(kk,2),2*nearind(tt))+D(2*tri(kk,3),2*nearind(tt));  %% partial derivative of y-component of centroid with respect to y
                              
            end
        end
        
        area(2*ind-1)=sum(areaSmall);
        area(2*ind)=sum(areaSmall);
        for tt=1:nne
            DT(2*ind-1,2*nearind(tt)-1)=1/3*((sum(dareax(:,nearind(tt))'.*cx)+sum(areaSmall.*dcxx(:,nearind(tt))'))*(sum(areaSmall))-(sum(areaSmall.*cx))*sum(dareax(:,nearind(tt))'))/(sum(areaSmall))^2;
            DT(2*ind-1,2*nearind(tt))=1/3*((sum(dareay(:,nearind(tt))'.*cx)+sum(areaSmall.*dcxy(:,nearind(tt))'))*(sum(areaSmall))-(sum(areaSmall.*cx))*sum(dareay(:,nearind(tt))'))/(sum(areaSmall))^2;
            DT(2*ind,2*nearind(tt)-1)=1/3*((sum(dareax(:,nearind(tt))'.*cy)+sum(areaSmall.*dcyx(:,nearind(tt))'))*(sum(areaSmall))-(sum(areaSmall.*cy))*sum(dareax(:,nearind(tt))'))/(sum(areaSmall))^2;
            DT(2*ind,2*nearind(tt))=1/3*((sum(dareay(:,nearind(tt))'.*cy)+sum(areaSmall.*dcyy(:,nearind(tt))'))*(sum(areaSmall))-(sum(areaSmall.*cy))*sum(dareay(:,nearind(tt))'))/(sum(areaSmall))^2;
        end
        
    end
end
DT=DT(1:end-10,1:end-10);         
H=2*diag(area)*(eye(2*ntot,2*ntot)-DT); %%following the formula on page 661 of 'review of CVT': H=2M(G(Z))(I-dT/dZ);
% x=reshape(XY,160,1);
% HH= Hessian_sim (x);
% TEST=inv(2*diag(area))*HH;
% e=eig(TEST);
% figure(7);plot(e);


