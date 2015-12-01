function zH = downdate (zh,res_prob)
%global IhH1 IhH2 IhH3 globalN
global current_n IhH1 IhH2  IhH3  IhH4 

m2=length(zh);
n=m2/2;
zh=reshape(zh,2,n);
% [XY2,B,globalind]=coarsen2_mlevel(zh,zh);
% if (res_prob==0)
%  
% % if (n==globalN(1))
% %     IhH1=B;
% % elseif(n==globalN(2))
% %     IhH2=B;
% % elseif(n==globalN(3))
% %     IhH3=B; 
% % end
%  zH=XY2;
%  m1=size(zH,2);
%  zH=reshape(zH,2*m1,1);
% else
% IhH=1/4*B';
if(current_n==4)
    size_zhp = size(zh')
    size_IhH4 = size(IhH4)
zH=IhH4*zh';
elseif(current_n==3)
   zH=IhH3*zh'; 
elseif(current_n==2)
    zH=IhH2*zh';
    elseif(current_n==1)
    zH=IhH1*zh';
    
end
m1=size(zH,1);
zH=reshape(zH',2*m1,1);
%end
% % zH=XY';
% % if (length(zh) == N(1));figure(5); hold on;
% %     plot(zh(1,:),zh(2,:),'rx','linewidth',2);
% %     plot(zH(:,1),zH(:,2),'BO','linewidth',2);
% % elseif(length(zh) == N(2));figure(6); hold on;
% %     plot(zh(1,:),zh(2,:),'rx','linewidth',2);
% %     plot(zH(:,1),zH(:,2),'BO','linewidth',2);
% % elseif(length(zh) == N(3));figure(7); hold on;
% %     plot(zh(1,:),zh(2,:),'rx','linewidth',2);
% %     plot(zH(:,1),zH(:,2),'BO','linewidth',2);
% % end
% % drawnow;
% 


