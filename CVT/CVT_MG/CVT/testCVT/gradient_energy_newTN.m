function  gradient = gradient_energy_newTN(dinvec,XY,VXY,SVXY,EVXY)
warning off MATLAB:divideByZero
%[N,m] = size(dind);
N1=size(VXY,1);
m=size(XY,2);gradient = zeros(2,m);
MVXY=(SVXY./EVXY);
MVXY(isnan(MVXY))=0;
clear SVXY EVXY
MVXY=MVXY.^2;
% [v,c] = voronoin(XY');
for i=1:m
    %ind = find(dind(:,i)==1);
    ind = find(dinvec==i);
    sz = length(ind);
%     vc=v(c{i},:);
%    infind=find(vc(:,1)==inf);
%     if (isempty(infind))
%     subarea=polyarea(vc(:,1),vc(:,2));
% %     else  tri=delaunay(VXY(ind,1),VXY(ind,2));
% %         subarea=0;
% %         for j=1:length(tri)
% %             subarea=subarea+det([VXY(tri(i,1),1) VXY(tri(i,1),2)  1; VXY(tri(i,2),1) VXY(tri(i,2),2) 1; VXY(tri(i,3),1) VXY(tri(i,3),2) 1]);
% %         end
%     else subarea=1/N1;
%     end

        
    for k=1:sz
%                  gradient(1,i)  = gradient(1,i) -(subarea/sz)*2*MVXY(ind(k))*(VXY(ind(k),1)-XY(1,i));
%                  gradient(2,i)  = gradient(2,i) -(subarea/sz)*2*MVXY(ind(k))*(VXY(ind(k),2)-XY(2,i));
         gradient(1,i)  = gradient(1,i) -2*MVXY(ind(k))*(VXY(ind(k),1)-XY(1,i));
         gradient(2,i)  = gradient(2,i)-2*MVXY(ind(k))*(VXY(ind(k),2)-XY(2,i));
    end
end
gradient=reshape(gradient,2*m,1);