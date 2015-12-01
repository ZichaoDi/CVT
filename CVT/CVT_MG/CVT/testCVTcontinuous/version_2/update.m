function zh = update (zH,res_prob)

global  current_n   N Hh 
n=length(zH)/2;
zH=reshape(zH,2,n);
 in=find(current_n==N);
 IHh=cell2mat(Hh(in));
 zh=IHh*zH';
m=size(zh,1);
zh=reshape(zh',2*m,1);

% zh=xy';
% if (length(zh) == N(1));figure(2); hold on;
%     plot(zh(:,1),zh(:,2),'rx','linewidth',2);
%     plot(zH(1,:),zH(2,:),'BO','linewidth',2);
% elseif(length(zh) == N(2));figure(3); hold on;
%     plot(zh(:,1),zh(:,2),'rx','linewidth',2);
%     plot(zH(1,:),zH(2,:),'BO','linewidth',2);
% elseif(length(zh) == N(3));figure(4); hold on;
%     plot(zh(:,1),zh(:,2),'rx','linewidth',2);
%     plot(zH(1,:),zH(2,:),'BO','linewidth',2);
% end
% drawnow;
