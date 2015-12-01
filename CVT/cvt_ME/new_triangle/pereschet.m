function data = pereschet(x,data,dataPred,dataExact,Nprev)

N = size(data,1);
coarse = 0;
active = 0;
for ind=1:N
    found=0;   
        for ii=1:Nprev
                if (norm(dataExact(ind,1:2)-dataPred(ii,1:2))<eps)
                   found=1;             
                   break;
               end   
         end
    if (found==0)&(data(ind,3)==1)   
      active = active +1;
      plot(data(ind,1),data(ind,2),'rx');  
      drawnow;
      data(ind,1)=data(ind,1) + x(1);
      data(ind,2)=data(ind,2) + x(2);
      plot(data(ind,1),data(ind,2),'r.');  
  elseif (found==1)&(data(ind,3)==1)
      coarse = coarse+1;    
      plot(data(ind,1),data(ind,2),'b.');  
      drawnow;
  else
      plot(data(ind,1),data(ind,2),'bo');  
    end
end
