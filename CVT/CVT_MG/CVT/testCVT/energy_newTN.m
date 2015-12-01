function  energia = energy_newTN(dinvec,XY,VXY,SVXY,EVXY)
warning off MATLAB:divideByZero
%[N,m] = size(dindex);
N1=size(VXY,1);
m=size(XY,2);
energia=0;
MVXY=(SVXY./EVXY);
MVXY(isnan(MVXY))=0;
clear SVXY EVXY
MVXY=MVXY.^2; 
%[v,c] = voronoin(XY');
% mminx=min(VXY(:,1));mmaxx=max(VXY(:,1));
% mminy=min(VXY(:,2));mmaxy=max(VXY(:,2));
%  test1 = find(XY(1,:)<mminx | XY(1,:)>mmaxx);
%                 test2 = find(XY(2,:)<mminy | XY(2,:)>mmaxy);
%                 
%                 if (~isempty(test1) | ~isempty(test2)) XY(1,test1); XY(2,test2); fprintf('out of bound\n'); return; end
for i=1:m
    %ind = find(dindex(:,i)==1);
    
    ind = find(dinvec==i);
   sz = length(ind);  
   distance = sum((VXY(ind,:)-repmat(XY(:,i)',sz,1)).^2,2);
%    vc=v(c{i},:);
%    infind=find(vc(:,1)==inf);
%     if (isempty(infind))
%     subarea=polyarea(vc(:,1),vc(:,2));
% %     else  tri=delaunay(VXY(ind,1),VXY(ind,2));
% %         subarea=0;
% %         for i=1:length(tri)
% %             subarea=subarea+det([VXY(tri(i,1),1) VXY(tri(i,1),2)  1; VXY(tri(i,2),1) VXY(tri(i,2),2) 1; VXY(tri(i,3),1) VXY(tri(i,3),2) 1]);
% %         end
%     %else miny=find(min(VXY(ind,2)));mamy=find(max(VXY(ind,2)));maxx=find(max(VXY(ind,1)));
%     else subarea=1/N1;
%     end
%    if (sz~=0)
%    energia  = energia + (subarea/sz)*sum(sum((MVXY(ind).*distance)));
%    end
    energia  = energia + sum(sum((MVXY(ind).*distance))); 
end
