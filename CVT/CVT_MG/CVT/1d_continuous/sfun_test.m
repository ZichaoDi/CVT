function [f,g]=sfun_test(data)
global N
nn=length(data);
data=sort(data);
%figure(12);plot(data,1,'ro'); 
% for i=1:nn
%     text(data(i),1,num2str(i));end
%pause(1);
%for i=1:length(data) text(1,data(i),num2str(i));end 
%if(length(data)==17)pause(2);end
% ind=find(data>1|data<0);
% if(~isempty(ind))pause;return; save('baddata','data');end
% H=Hessian1d(data);
% e=eig(H);
% figure(13);plot(e);
% ind=find(e<=0);
%if(~isempty(ind)&length(data)==17)  return;end
f=energy_1d(data);
g=gradient_energy_1d(data);

ind=find(N==nn);
% f=f/4^(ind-1);
% g=g/4^(ind-1);
% 
