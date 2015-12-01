function vH = downdate_variable (vh, res_prob)

%-----------------------------------------
% Downdate to a smaller problem.
%

global X  N current_n

%--------------------------------------------------------------

j  = find(N==current_n);
if(res_prob==1)
vh_y=vh(1:current_n);
vh_u=vh(current_n+1:end);
vH_y(1)=vh_y(1)+1/2*vh_y(2);
vH_y(N(j+1))=vh_y(end-1)/2+vh_y(end);
for i=2:N(j+1)-1
    vH_y(i)=vh_y(2*i-2)/2+vh_y(2*i-1)+vh_y(2*i)/2;
end
vH_u(1)=vh_u(1)+1/2*vh_u(2);
vH_u(N(j+1))=vh_u(end-1)/2+vh_u(end);
for i=2:N(j+1)-1
    vH_u(i)=vh_u(2*i-2)/2+vh_u(2*i-1)+vh_u(2*i)/2;
end
vH=[vH_y,vH_u]';
else
 vH(1)=vh(1)+1/2*vh(2);
vH(N(j+1))=vh(end-1)/2+vh(end);
for i=2:N(j+1)-1
    vH(i)=vh(2*i-2)/2+vh(2*i-1)+vh(2*i)/2;
end
vH=vH';
end   
return

