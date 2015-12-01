function [XY2,bond,B0,B,globalind] = coarsen2_mlevel(XY,XYcur)
global bdry
% XY2(1:2,:)           are the coordinates of the ncoarse newly found coarse nodes
% B(1:nall, 1:ncoarse) is the interpolation matrix, B(i,j) = coeff of i-th
%                      point with respect to the j-th coarse node on this level's coarse grid
% globalind            is the array containing indices of coarse grid nodes for this level

nall = size(XY,2); % number of finest grid nodes 

n = size(XYcur,2); % number of fine grid nodes for this level
  
XYtot = [XYcur, bdry]; % all nodes involved in coarsening
A = adjacency1(XYtot');
ntot = size(XYtot,2);
bdry1 = [n+1:ntot];% convhull(XY(1,:),XY(2,:))']; % outer layer of generators
forbid = [];%bdry; % list of forbidden nodes includes outer layer
globalind = [];  
taken = [];
array = [bdry1, 1:n]; 
step = 1;
for i=1:ntot
    ind=find(A(:,i)); 
    AA(ind,i)=-1;
    AA(i,i)=length(ind)-1;
end
A; % incidence matrix
AA; % graph Laplacian
B = zeros(ntot,1);
XY2 = [];


while (length(array)>0)

chosen = array(1); % pick first available generator   
ind = find(AA(chosen,:)); %adjacent point indices
ind  = setdiff(ind,taken);
if (length(ind)==0) % if no aggregate can be formed, associate this point to another group
    for i=1:step-1 diff(i) = distance(XYtot(:,chosen),XY2(:,i)); end
    [m,ii]=min(diff);
    B(chosen,ii)=1;
    forbid = [forbid,chosen];
    taken = [taken,chosen];
    array = array(~ismember(array,forbid));
    %step = step + 1;
    continue;
end
XY2(:,step) = XYtot(1:2,chosen);  
globalind = [globalind,chosen];
B(ind,step)=1;

% figure(3);
% hold on;
% % c(step,:) = [rand rand rand];
% plot(XY(1,bdry),XY(2,bdry),'dy','linewidth',2);
% % plot(XYtot(1,ind),XYtot(2,ind),'o','color',c(step,:),'linewidth',5);
% % %plot(XY(1,ind),XY(2,ind),'bo','linewidth',2);
% % plot(XYtot(1,chosen),XYtot(2,chosen),'o','color',c(step,:),'linewidth',10);
% plot(XY(1,chosen),XY(2,chosen),'rs','linewidth',3);
%  drawnow;

%Anew = AA*B;
%ind2 = find(Anew(:,step))';
forbid = [forbid,chosen,ind]; % remove this aggregate and its neighbors from available generators
taken = [taken,chosen,ind];
array = array(~ismember(array,forbid)); %[bdry,setdiff(1:ntot,forbid)];

step = step + 1;      
end

% globalind
% forbid
% taken
% array
% B
 step;

leftout = setdiff(1:ntot,taken);
for jj=1:length(leftout)
    for i=1:step-1 diff(i) = distance(XYtot(:,leftout(jj)),XY2(:,i)); end
    [m,ii]=min(diff);
    B(leftout(jj),ii)=1;    
    %plot(XYtot(1,leftout(jj)),XYtot(2,leftout(jj)),'o','color',c(ii,:),'linewidth',2);
end
B1=B;
B=zeros(size(B1));
globalind;


 tri = delaunay(XY2(1,:),XY2(2,:));
 %figure(3); hold on; trimesh(tri,XY2(1,:),XY2(2,:));
%  for ii=1:ntot 
%     text(XYtot(1,ii)+1,XYtot(2,ii),num2str(ii)); 
%  end

indfine = 1:nall; %setdiff(1:ntot,globalind);
%indfine = setdiff(1:nall,globalind);
XYfine = XY; %XYtot(:,indfine);

for i=1:length(indfine)
   for j=1:size(tri,1) 
        
     [test,a,b,c] = insidetri(XY2(:,tri(j,1)),XY2(:,tri(j,2)),XY2(:,tri(j,3)),XYfine(:,indfine(i)));
     
     if (test)  B(indfine(i),tri(j,1))=a; B(indfine(i),tri(j,2))=b; B(indfine(i),tri(j,3))=c; end
   end


end
 
 
%  
finalindex = find(globalind<=n);  % index of interior coarse nodes in globalind array
final=find(globalind>n);
bond=XY2(:,final);
globalind = globalind(finalindex); % index of interior coarse nodes 
B0=B(1:nall,:);
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


