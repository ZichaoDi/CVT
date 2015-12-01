function [XY2,bond,B0,B1,B,globalind] = coarsen_mlevel(XY)
global current_n XYbd N finalindex XYfine globalind

% XY2(1:2,:)           are the coordinates of the ncoarse newly found coarse nodes
% B(1:nall, 1:ncoarse) is the interpolation matrix, B(i,j) = coeff of i-th
%                      point with respect to the j-th coarse node on this level's coarse grid
% globalind            is the array containing indices of coarse grid nodes for this level

ind=find(current_n==N);
bdry=XYbd{ind};
n = size(XY,2); % number of fine grid nodes for this level
XYtot = [XY, bdry]; % all nodes involved in coarsening
A = adjacency(XYtot'); % incidence matrix

ntot = size(XYtot,2);
bdry1 = (n+1:ntot);% convhull(XY(1,:),XY(2,:))']; % outer layer of generators
forbid = [];%bdry; % list of forbidden nodes includes outer layer
globalind = [];
taken = [];
array = [bdry1, 1:n];
step = 1;
for i=1:ntot
    ind=find(A(:,i));
    AA(ind,i)=-1;
    AA(i,i)=length(ind)-1; % graph Laplacian
end
B = zeros(ntot,1);
XY2 = [];


while (~isempty(array))
    
    chosen = array(1); % pick first available generator
    ind = find(AA(chosen,:)); %adjacent point indices
    ind  = setdiff(ind,taken);
    if (isempty(ind)) % if no aggregate can be formed, associate this point to another group
        for i=1:step-1 diff(i) = distance(XYtot(:,chosen),XY2(:,i)); end
        [m,ii]=min(diff);
        B(chosen,ii)=1;
        forbid = [forbid,chosen];
        taken = [taken,chosen];
        array = array(~ismember(array,forbid));
        continue;
    end
    XY2(:,step) = XYtot(:,chosen);
    globalind = [globalind,chosen];
    B(ind,step)=1;
    forbid = [forbid,chosen,ind]; % remove this aggregate and its neighbors from available generators
    taken = [taken,chosen,ind];
    array = array(~ismember(array,forbid)); 
    
    step = step + 1;
end
leftout = setdiff(1:ntot,taken);
for jj=1:length(leftout)
    for i=1:step-1 diff(i) = distance(XYtot(:,leftout(jj)),XY2(:,i)); end
    [m,ii]=min(diff);
    B(leftout(jj),ii)=1;
end
B=zeros(size(B));
B=sparse(B);
tri = delaunay(XY2(1,:),XY2(2,:));
%figure(15);triplot(tri,XY2(1,:),XY2(2,:))

indfine = 1:n; 
XYfine = XY; 

for i=1:length(indfine)
    for j=1:size(tri,1)
        
        [test,a,b,c] = insidetri(XY2(:,tri(j,1)),XY2(:,tri(j,2)),XY2(:,tri(j,3)),XYfine(:,indfine(i)));
        
        if (test)  
            B(indfine(i),tri(j,1))=a; B(indfine(i),tri(j,2))=b; B(indfine(i),tri(j,3))=c; end
    end
    
    
end
finalindex = find(globalind<=n);  % index of interior coarse nodes in globalind array
%final=find(globalind>n);
bond=XY2;
globalind = globalind(finalindex); % index of interior coarse nodes
B0=B(:,finalindex);
B1=B(1:n,:);
B = B(1:n,finalindex); % relevant part of the interpolation matrix B(i,j) = coef of i-th node wrt globalind(j)-th coarse node
XY2 = XY2(:,finalindex);
% figure(33);
% plot(XY(1,:),XY(2,:),'r.'); hold on;
% plot(XY2(1,:),XY2(2,:),'b.');
% plot(bdry(1,:),bdry(2,:),'r.');
% plot(bond(1,:),bond(2,:),'b.');
% for i=1:ntot
%     text(XYtot(1,i),XYtot(2,i),num2str(i));end


