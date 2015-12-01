function [f,g]=sfun(data)
global N
nn=length(data);
data=sort(data);
% [low,up] = set_bounds(nn);
% [ipivot, ierror, data] = crash(data, low, up);
 
% % for i=1:nn
% %     text(data(i),1,num2str(i));end
%if(~isempty(find(data>1|data<0)))
% figure(12);plot(data,1,'ro');  
% %end
% for i=1:length(data) text(data(i),1,num2str(i));end 
% pause(1);
% % %if(length(data)==17)pause(2);end
% ind=find(data>1|data<0);
% if(~isempty(ind))pause;return; save('baddata','data');end
% H=Hessian1d(data);
% e=eig(H);
% figure(13);plot(e);
% ind=find(e<=0);
%if(~isempty(ind)&length(data)==17)  return;end
%figure(3);plot(data,1,'r.')
f=energy_1d(data);
g=gradient_energy_1d(data);
f=f*nn^2;
g=g.*nn^2;

