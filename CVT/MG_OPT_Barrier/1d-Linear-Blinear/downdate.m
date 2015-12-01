function vH = downdate (vh, res_prob)
%-----------------------------------------
% Downdate to a smaller problem.
%

global X  N current_n V_L V_U IhH
j  = find(N==current_n);
% %--------------------------------------------------------------
% vH(1)=vh(1)+1/2*vh(2);
% vH(N(j+1))=vh(end-1)/2+vh(end);
% for i=2:N(j+1)-1
%     vH(i)=vh(2*i-2)/2+vh(2*i-1)+vh(2*i)/2;
% end
% vH=1/2*vH';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if(res_prob)
% for i=1:N(j+1)
%     vH(i)=vh(2*i-1)/2+vh(2*i)+vh(2*i+1)/2;
% end
% vH=1/2*vH';
% else
%     vH=vh(2:2:end);
% end
% % 
for i=1:N(j+1)
    vH(i)=vh(2*i-1)/2+vh(2*i)+vh(2*i+1)/2;
end
vH=1/2*vH';%
% IhH=zeros(N(j+1),N(j));
% for i=1:N(j+1)
%     IhH(i,2*i-1)=1/4;
%     IhH(i,2*i)=1/2;
%     IhH(i,2*i+1)=1/4;
% end
    
% figure(555);plot(vH)
%%%%%%%%%%%%#################################################
%%%%%%%%%%%%%% Include boundary points%%%%%%%%%%%%%%%%%%%%%%
% if(res_prob==0)
%     vh=[V_L;vh;V_U];
% elseif(res_prob==1)
%     vh=[0;vh;0];
% end
% IhH=zeros(N(j+1)+2,N(j)+2);
% IhH(1,1)=1/2;
% IhH(1,2)=1/4;
% for i=2:N(j+1)+1;
%     IhH(i,2*i-2)=1/4;IhH(i,2*i-1)=1/2;IhH(i,2*i)=1/4;
% end
% IhH(N(j+1)+2,N(j)+1)=1/4;
% IhH(N(j+1)+2,N(j)+2)=1/2;
% vH=IhH*vh;
% 
% vH=vH(2:end-1);
% % hold on; plot(vH,'r')
% % pause
% return

