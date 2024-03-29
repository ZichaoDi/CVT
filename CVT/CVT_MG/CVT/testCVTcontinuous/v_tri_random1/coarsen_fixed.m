function [XY2,B,globalind] = coarsen_fixed(XY)
global current_n XYbd N  XYfine globalind

% XY2(1:2,:)           are the coordinates of the ncoarse newly found coarse nodes
% B(1:nall, 1:ncoarse) is the interpolation matrix, B(i,j) = coeff of i-th
%                      point with respect to the j-th coarse node on this level's coarse grid
% globalind            is the array containing indices of coarse grid nodes for this level

ind=find(current_n==N);

n = size(XY,2); % number of fine grid nodes for this level
A = adjacency(XY'); % incidence matrix

forbid = [];%bdry; % list of forbidden nodes includes outer layer
globalind = [];
taken = [];
array = [1:n];
step = 1;
for i=1:n
    ind=find(A(:,i));
    AA(ind,i)=-1;
    AA(i,i)=length(ind)-1; % graph Laplacian
end
B = zeros(n,1);
XY2 = [];


while (~isempty(array)& step<=10)
    
    chosen = array(1); % pick first available generator
    ind = find(AA(chosen,:)); %adjacent point indices
    ind  = setdiff(ind,taken);
    if (isempty(ind)) % if no aggregate can be formed, associate this point to another group
        for i=1:step-1 diff(i) = distance(XY(:,chosen)',XY2(:,i)'); end
        [m,ii]=min(diff);
        B(chosen,ii)=1;
        forbid = [forbid,chosen];
        taken = [taken,chosen];
        array = array(~ismember(array,forbid));
        continue;
    end
    XY2(:,step) = XY(:,chosen);
    globalind = [globalind,chosen];
    B(ind,step)=1;
    forbid = [forbid,chosen,ind]; % remove this aggregate and its neighbors from available generators
    taken = [taken,chosen,ind];
    array = array(~ismember(array,forbid));
    
    step = step + 1;
end
leftout = setdiff(1:n,taken);
for jj=1:length(leftout)  
    for i=1:step-1

        diff(i) = distance(XY(:,leftout(jj))',XY2(:,i)'); return;
    end
    [m,ii]=min(diff);
    B(leftout(jj),ii)=1;
end
B=zeros(size(B));
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
% figure(33);
% plot(XY(1,:),XY(2,:),'r.'); hold on;
% plot(XY2(1,:),XY2(2,:),'b.');

% for i=1:ntot
%     text(XYtot(1,i),XYtot(2,i),num2str(i));end


