function zh = update (zH,res_prob)
%global IhH1 IhH2 IhH3 globalN mminx mmaxx mminy mmaxy
global  current_n IHh1  IHh2  IHh3 IHh4 bond
n=length(zH)/2;
zH=reshape(zH,2,n);
zH=[bond,zH];
% if n==globalN(2)
% zh=B2*zH';
% elseif n==globalN(3)
% zh=B3*zH';  
% elseif n==globalN(4)
% zh=B4*zH'; 
% end
% if (n==globalN(2))
%     IHh=IhH1;
% elseif(n==globalN(3))
%     IHh=IhH2;
% elseif(n==globalN(4))
%     IHh=IhH3;
% end
 %fprintf('rowsize=%d,columusize=%d,size(points)=%d\n',size(IHh,1),size(IHh ,2),n);
 if(current_n==1)
zh=IHh1*zH';
 elseif(current_n==2)
   zh=IHh2*zH'; 
 elseif(current_n==3)
     zh=IHh3*zH';
      elseif(current_n==4)
     zh=IHh4*zH';
 end

% 
% if (~isempty(test1))
%    if (n==N(2)) for m=1:length(test1)
%             in1=find(max(B2(test1(m),:)));
%             xy(1,test1(m))=zH(1,in1);end
%    elseif (n==N(3))
%     for m=1:length(test1)
%             in1=find(max(B3(test1(m),:)));
%             xy(1,test1(m))=zH(1,in1);end
%     elseif (n==N(4))
%       for m=1:length(test1)
%              in1=find(max(B4(test1(m),:)));
%             xy(1,test1(m))=zH(1,in1);end
%    end
% end
% if( ~isempty(test2))
%     
%     %xy(1,test1); xy(2,test2); fprintf('out of bound\n');
%     if (n==N(2))
%         
%         for m=1:length(test2)
%             in2=find(max(B2(test2(m),:)));
%             xy(2,test2(m))=zH(2,in2);end
%     elseif (n==N(3))
%         
%         for m=1:length(test2)
%             in2=find(max(B3(test2(m),:)));
%             xy(2,test2(m))=zH(2,in2);end
%     elseif (n==N(4))
%         
%         for m=1:length(test2)
%             in2=find(max(B4(test2(m),:)));
%             xy(2,test2(m))=zH(2,in2);end
%     end
% end
% test1 = find(xy(1,:)<mminx | xy(1,:)>mmaxx);
% test2 = find(xy(2,:)<mminy | xy(2,:)>mmaxy);
% 
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
m=size(zh,1);
zh=reshape(zh',2*m,1);