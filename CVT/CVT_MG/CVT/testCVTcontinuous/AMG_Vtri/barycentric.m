function [B0,B1,B] = barycentric(XY,XYc);
global current_n XYbd N finalindex bond

% B(1:nall, 1:ncoarse) is the interpolation matrix, B(i,j) = coeff of i-th
%                      point with respect to the j-th coarse node on this level's coarse grid
% globalind            is the array containing indices of coarse grid nodes for this level

ind=find(current_n==N);
bdry=XYbd{ind};
n = size(XY,2); % number of fine grid nodes for this level
XYtot = [XY, bdry]; % all nodes involved in coarsening
ntot = size(XYtot,2);
XY2=bond;
XY2(:,finalindex)=XYc;
nc=size(XY2,2);
B=zeros(ntot,nc);
tri = delaunay(XY2(1,:),XY2(2,:));

%figure(15);triplot(tri,XY2(1,:),XY2(2,:))

indfine = 1:n; 
XYfine = XY; 

for i=1:length(indfine)
    for j=1:size(tri,1)
        
        [test,a,b,c] = insidetri(XY2(:,tri(j,1)),XY2(:,tri(j,2)),XY2(:,tri(j,3)),XYfine(:,indfine(i)));
        
        if (test)  
            B(indfine(i),tri(j,1))=a; B(indfine(i),tri(j,2))=b; B(indfine(i),tri(j,3))=c; 
        end
    end
    
    
end
B0=B(:,finalindex);
B1=B(1:n,:);
B = B(1:n,finalindex); % relevant part of the interpolation matrix B(i,j) = coef of i-th node wrt globalind(j)-th coarse node
