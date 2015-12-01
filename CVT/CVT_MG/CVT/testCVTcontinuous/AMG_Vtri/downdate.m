function zH = downdate (zh,res_prob)
global  hH  bondgrad

m2=length(zh);
n=m2/2;
zh=reshape(zh,2,n);
if(res_prob==3)
    [zH] = coarsen_mlevel(zh);
 %  [zH] = coarsen_inner(zh);
%    figure(44);
%    plot(zh(1,:),zh(2,:),'ro');hold on;
%    plot(zH(1,:),zH(2,:),'b*');hold off;
%    format short e
%    B
%    pause;
elseif(res_prob==4)
IhH=cell2mat(hH(1));
zh=[zh,bondgrad];
zH=zh*IhH;
else
   IhH=cell2mat(hH(1));
zH=zh*IhH(1:n,:);
end
m1=size(zH,2);
zH=reshape(zH,2*m1,1);


