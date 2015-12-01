function zh = update (zH,res_prob)

global  current_n N Hh XYbd XYfine globalind
n=length(zH)/2;
zH=reshape(zH,2,n);
in=find(current_n==N);
format short e
%%######################################

if(res_prob==4)
   XYfine(:,globalind)=zH;
     [B0,B1,B] = barycentric(XYfine,zH);
    zh=4*B*zH';
%%%++++++++++++++++++++++++++++++++++++++++++++++++++++
% bond=XYbd{in+1};
% XYfull=[zH,bond];
% tri=delaunay(XYfull(1,:),XYfull(2,:),{'Qt','Qbb','Qc','Qz'});
% adm=[];
% for i=1:length(tri)
%     adm(3*i-2,tri(i,1))=1/2;
%     adm(3*i-2,tri(i,2))=1/2;
%     adm(3*i-1,tri(i,1))=1/2;
%     adm(3*i-1,tri(i,3))=1/2;
%     adm(3*i,tri(i,2))=1/2;
%     adm(3*i,tri(i,3))=1/2;
% end
% xyfine=adm*XYfull';
% xyfine=unique(xyfine,'rows');
% z=[];
% for i=1:length(xyfine)
%     z(i)=isbdry(xyfine(i,1),xyfine(i,2));
% end
% innerind= z==1;
% xyfine=xyfine(innerind,:);
% ind=setdiff((1:length(XYfine)),globalind);
% XYfine(:,globalind)=zH;
% XYfine(:,ind)=xyfine';
zh=XYfine';
%%%++++++++++++++++++++++++++++++++++++++++++++++++++++
% % figure(11);
% % triplot(tri,XYfull(1,:),XYfull(2,:));hold on;
% % for i=1:length(XYfull)
% %     text(XYfull(1,i),XYfull(2,i),num2str(i),'FontSize',18);end
% % plot(XYfull(1,:),XYfull(2,:),'ro',xyfine(:,1),xyfine(:,2),'g*')
% 

% %figure(44);plot(xyfine(:,1),xyfine(:,2),'ro');
else
IHh=cell2mat(Hh(in));
zh=IHh*zH';
end
%%#####################################
% bond=XYbd{in+1};
% XYfull=[zH,bond];
% tri=delaunay(XYfull(1,:),XYfull(2,:),{'Qt','Qbb','Qc','Qz'});
% adm=[];
% for i=1:length(tri)
%     adm(3*i-2,tri(i,1))=1/2;
%     adm(3*i-2,tri(i,2))=1/2;
%     adm(3*i-1,tri(i,1))=1/2;
%     adm(3*i-1,tri(i,3))=1/2;
%     adm(3*i,tri(i,2))=1/2;
%     adm(3*i,tri(i,3))=1/2;
% end
% xyfine=adm*XYfull';
% xytot=[xyfine;XYfull'];
% % figure(11);
% % triplot(tri,XYfull(1,:),XYfull(2,:));hold on;
% % for i=1:length(XYfull)
% %     text(XYfull(1,i),XYfull(2,i),num2str(i),'FontSize',18);end
% % plot(XYfull(1,:),XYfull(2,:),'ro',xyfine(:,1),xyfine(:,2),'g*')
% 
% xytot=unique(xytot,'rows');
% z=[];
% for i=1:length(xytot)
%     z(i)=isbdry(xytot(i,1),xytot(i,2));
% end
% innerind=find(z==1);
% zh=xytot(innerind,:);
%%%#######################################
% if(res_prob==4)
% figure(4);
% plot(zh(:,1),zh(:,2),'ro')
% hold on;
% plot(zH(1,:),zH(2,:),'g*')
% pause;
% end
m=size(zh,1);
zh=reshape(zh',2*m,1);
