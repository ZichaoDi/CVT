%----------------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular]
%----------------------------------------------------------------------
clear  functions
global bounds
global grad_type
global N XY XYbd IHh inner bd IHhtot level
global xlimit ylimit k tribond
%----------------------------------------------------------------------
% Specify technique for calculating gradient
%----------------------------------------------------------------------
grad_type = 'adj';  % 'adj' = adjoint/exact
% 'fdr' = finite-difference [real]
% 'fdi' = finite-difference [complex]
%----------------------------------------------------------------------
% Initialize arrays for discretizations
%----------------------------------------------------------------------
load data28;
dataExact = data28;
dataExact(:,1:2)=100*dataExact(:,1:2);
tribond=[100 100 2;100 -100 2; -100 -100 2; -100 100 2];
level=1;   %%--------------------------------
N=zeros(1,level+1);
IN=find(dataExact(:,3)==1);
N(level+1)=length(IN);
inner=cell(1,level+1);
inner{level+1}=IN;
XY=cell(1,level+1);
XY{level+1}=dataExact(inner{level+1},1:2)';
OUT=find(dataExact(:,3)==0);
bd=cell(1,level+1);
bd{level+1}=OUT;
XYbd=cell(1,level+1);
XYbd{level+1}=dataExact(bd{level+1},1:2)';
IHhtot=cell(1,level);
IHh=cell(1,level);
for i=1:level
    [dataExact,nn,B] = refine_cvt(dataExact);
    IN=find(dataExact(:,3)==1);
    inner{level-i+1}=IN;
    XY{level-i+1}=dataExact(inner{level-i+1},1:2)';
    OUT=find(dataExact(:,3)==0);
    bd{level-i+1}=OUT;
    XYbd{level-i+1}=dataExact(bd{level-i+1},1:2)';
    N(level-i+1)=nn;  %discretization level
    IHhtot{level-i+1}=B;
end
for i=1:level
    inh=inner{i};
inH=inner{i+1};
BB=IHhtot{i};
IHh{i}=BB(inh,inH);
end
%%%%%%%%%%%%%Initial configuration by perturbing the exact solution
% v0=XY{1};
% pert1 = 1e-1;
% pert2 = 0;%-1e-1;
% for i=1:N(1)
%     v1=v0(1,i)+pert1*i;
%     v2=v0(2,i)+pert2*i;
%     if(v2<sqrt(3)*v1+50*sqrt(3) & v2<-sqrt(3)*v1+50*sqrt(3) & v2>0)
%         v0(1,i)=v1;
%         v0(2,i)=v2;
%     end
% end
% %%%%%%%%%%%###########################################################
% %%%%%%%%%%%%%%%generate initial random guess
rand('state',0);
a=rand(N(1),1);
b=rand(N(1),1);
errind=find(a+b>1);
a(errind)=1-a(errind);
b(errind)=1-b(errind);
c=1-a-b;
pert=1e-3;
v0=[(-50+pert).*a+(50-pert).*b+0.*c,  (0+pert).*a+(0+pert).*b+(50*sqrt(3)-pert).*c]';
%%%%%%%%%%%%%%%###########################################################
v0 = reshape(v0,2*N(1),1);
% load vci
% v0=vci;
xlimit=[-50 0 50];
ylimit=[0 sqrt(3)*50 0];
k=convhull(xlimit,ylimit);
% %----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------
bounds = 0; % 0:no bounds on variables