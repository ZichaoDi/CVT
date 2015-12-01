function new = removeSame(data,N)

  sz = size(data,1);

  s = 2;
  new = zeros(1,3);
  new(1,:)=data(1,:);
  
  for i=2:(sz)
      found = 0;
      for j=1:(s-1)          
       if (abs(data(i,1)-new(j,1))<1e-10)&(abs(data(i,2)-new(j,2))<1e-10) 
           found=1; 
           break;
       end                        
      end    
      if (found==0)
          new(s,:)=data(i,:);
          s=s+1;
      end      
  end   
  