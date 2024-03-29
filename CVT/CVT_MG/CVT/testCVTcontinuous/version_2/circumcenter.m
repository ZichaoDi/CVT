function [CC,D]=circumcenter(vert,data,nearind)
global N
%%%  usage:compute the derivate of each vertice of the cell with respect to its
%%%  neighboring generators at the stationary point
%%%  input:vert:vertices of current cell
%%%  data:the set of generators
%%%  nearind:index of the neighboring generators
%---------------------------------------------------------------------
%%% output:CC:the matrix showing which generators are the neighborhood of
%%% corresponding vertice,i.e.the vertice will be the circumcenter of the
%%% circle formed by the three neighboring generators
%%% D: the derivative of vertice to the generators corresponding to the
%%% current cell
tri=delaunay(data(1,nearind),data(2,nearind),{'Qt','Qbb','Qc','Qz'});
figure(7);
triplot(tri,data(1,nearind),data(2,nearind));hold on;plot(vert(2,1),vert(2,2),'ro');
numt=size(tri,1);
nn=length(nearind);
nm=size(vert,1);
CC=zeros(nm,nn);
D=zeros(2*nm,2*N);
for i=1:nm
    for j=1:numt
        sub=data(:,nearind(tri(j,:)));
        in=inpolygon(vert(i,1),vert(i,2),sub(1,:),sub(2,:));
        if(in),CC(i,tri(j,:))=1;       
        D(2*i-1,2*nearind(tri(j,1))-1)=((vert(i,1)-sub(1,1)-sub(1,2))*(sub(2,1)-sub(2,3))-(vert(i,1)-sub(1,1)-sub(1,3)*(sub(2,1)-sub(2,2))))/((sub(1,1)-sub(1,3)*(sub(2,1)-sub(2,2)))-(sub(1,1)-sub(1,2)*(sub(2,1)-sub(2,3))))+1;
        D(2*i,2*nearind(tri(j,1))-1)=((1-D(2*i-1,2*nearind(tri(j,1))-1))*(sub(1,1)-sub(1,3))-vert(i,1)+sub(1,1)+sub(1,2))/(sub(2,1)-sub(2,2));
        D(2*i,2*nearind(tri(j,1)))=(vert(i,2)*sub(1,3)+2*sub(2,1)*sub(1,3)+vert(i,2)*sub(1,2)-2*sub(2,1)*sub(1,2))/(-sub(2,1)*sub(1,2)-sub(2,3)*sub(1,1)+sub(2,3)*sub(1,2)+sub(2,2)+sub(1,1)-sub(2,2)*sub(1,3));
        D(2*i-1,2*nearind(tri(j,1)))=-(vert(i,2)-sub(2,1)-sub(2,3)+(D(2*i,2*nearind(tri(j,1)))-1)*(sub(2,1)-sub(2,3)))/(sub(1,1)-sub(1,3));
        %--------------------------------------------------------------------------
        %--------------------------------------------------------------------------
        D(2*i-1,2*nearind(tri(j,2))-1)=((vert(i,1)-sub(1,2)-sub(1,3))*(sub(2,2)-sub(2,1))-(vert(i,1)-sub(1,2)-sub(1,1)*(sub(2,2)-sub(2,3))))/((sub(1,2)-sub(1,1)*(sub(2,2)-sub(2,3)))-(sub(1,2)-sub(1,3)*(sub(2,2)-sub(2,1))))+1;
        D(2*i,2*nearind(tri(j,2))-1)=((1-D(2*i-1,2*nearind(tri(j,2))-1))*(sub(1,2)-sub(1,1))-vert(i,1)+sub(1,2)+sub(1,3))/(sub(2,2)-sub(2,3));
        D(2*i,2*nearind(tri(j,2)))=(vert(i,2)*sub(1,1)+2*sub(2,2)*sub(1,1)+vert(i,2)*sub(1,3)-2*sub(2,2)*sub(1,3))/(-sub(2,2)*sub(1,3)-sub(2,1)*sub(1,2)+sub(2,1)*sub(1,3)+sub(2,3)+sub(1,2)-sub(2,3)*sub(1,1));
        D(2*i-1,2*nearind(tri(j,2)))=(vert(i,2)-sub(2,2)-sub(2,1)+(D(2*i,2*nearind(tri(j,2)))-1)*(sub(2,2)-sub(2,1)))/(sub(1,2)-sub(1,1));
        %--------------------------------------------------------------------------
        %--------------------------------------------------------------------------
        D(2*i-1,2*nearind(tri(j,3))-1)=((vert(i,1)-sub(1,2)-sub(1,3))*(sub(2,2)-sub(2,1))-(vert(i,1)-sub(1,2)-sub(1,1)*(sub(2,2)-sub(2,3))))/((sub(1,2)-sub(1,1)*(sub(2,2)-sub(2,3)))-(sub(1,2)-sub(1,3)*(sub(2,2)-sub(2,1))))+1;
        D(2*i,2*nearind(tri(j,3))-1)=((1-D(2*i-1,2*nearind(tri(j,3))-1))*(sub(1,2)-sub(1,1))-vert(i,1)+sub(1,2)+sub(1,3))/(sub(2,2)-sub(2,3));
        D(2*i,2*nearind(tri(j,3)))=(vert(i,2)*sub(1,1)+2*sub(2,2)*sub(1,1)+vert(i,2)*sub(1,3)-2*sub(2,2)*sub(1,3))/(-sub(2,2)*sub(1,3)-sub(2,1)*sub(1,2)+sub(2,1)*sub(1,3)+sub(2,3)+sub(1,2)-sub(2,3)*sub(1,1));
        D(2*i-1,2*nearind(tri(j,3)))=(vert(i,2)-sub(2,2)-sub(2,1)+(D(2*i,2*nearind(tri(j,3)))-1)*(sub(2,2)-sub(2,1)))/(sub(1,2)-sub(1,1));
     end
        end
end
% for i=1:2*nm
%     inn=find(D(i,:));if(length(inn)~=6) i,length(inn),end
% end
%((vert(i,2)-sub(2,1)-sub(2,2)*(sub(1,1)-sub(1,3)))-(vert(i,2)-sub(2,1)-sub(2,3)*(sub(1,1)-sub(1,2))))/((sub(1,1)-sub(1,2))*(sub(2,1)-sub(2,3))-(sub(2,1)-sub(2,2))*(sub(1,1)-sub(1,3)))+1;


