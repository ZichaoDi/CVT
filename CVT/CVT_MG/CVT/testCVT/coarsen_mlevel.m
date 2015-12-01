function [XY2,B,globalind]=coarsen_mlevel(XY,XYcur)
global bdry
globalind=[];
XYtot=[XY,bdry];
nall=size(XY,2);
ntot=size(XYtot,2);
XY2=[XY(:,1:3:end),bdry(:,1:3:end)]; ndown=size(XY2,2);
n=size(XYcur,2);
globalind(1)=1;
for i=2:ndown
    %ind=find(XYtot(1,:)==XY2(1,i)&XYtot(2,:)==XY2(2,i));
    globalind(i)=globalind(i-1)+3;
end
B=zeros(nall,ndown);
tri = delaunay(XY2(1,:),XY2(2,:));
 %figure(3); hold on; trimesh(tri,XY2(1,:),XY2(2,:));
%  for ii=1:ntot 
%     text(XYtot(1,ii)+1,XYtot(2,ii),num2str(ii)); 
%  end

indfine = 1:nall; %setdiff(1:ntot,globalind);
XYfine = XY; %XYtot(:,indfine);

for i=1:length(indfine)
   for j=1:size(tri,1) 
     [test,a,b,c] = insidetri(XY2(:,tri(j,1)),XY2(:,tri(j,2)),XY2(:,tri(j,3)),XYfine(:,i));  
     if (test) B(indfine(i),tri(j,1))=a; B(indfine(i),tri(j,2))=b; B(indfine(i),tri(j,3))=c; end
   end


end
 
 
%  
finalindex = find(globalind<=n);  % index of interior coarse nodes in globalind array
globalind = globalind(finalindex); % index of interior coarse nodes 
B = B(1:nall,finalindex); % relevant part of the interpolation matrix B(i,j) = coef of i-th node wrt globalind(j)-th coarse node
% for i=1:length(finalindex)     
%     ind0 = globalind(i);
%     index  = find(B(:,i));    
%     figure(3); hold on;
%     c = [rand rand rand];
%     plot(XYtot(1,ind0),XYtot(2,ind0),'s','color',c,'linewidth',10);        
%     for ii=1:length(index)
%         %plot(XYtot(1,index(ii)),XYtot(2,index(ii)),'o','color',c,'linewidth',5);                
%         %drawnow;
%         %text(XY(1,i)+1,XY(2,i)-2*ii+2,['\lambda_',num2str(index(ii)),'=',num2str(B(i,index(ii)))]);
%     end
%     
% end
XY2 = XY2(:,finalindex);
    