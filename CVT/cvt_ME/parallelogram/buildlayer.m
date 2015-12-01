%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function layers = buildLayer(level,A,layers,data,ind0);
warning off;
old = data;
N = size(data,1);

%if (level>0) 
    
    
for ii=1:N                        
         index = layers(ind0,ii);
         if (index==level)&(isbdry(data(ii,1),data(ii,2))) 
           neighbor = A(ii,1:N);
           places = find(neighbor);
           for jj=1:size(places,2);
             number = places(jj);  
             if (layers(ind0,number)==0)&(isbdry(data(number,1),data(number,2)))  
                 layers(ind0,number) = level+1;  
             end
           end         
        end
end  
%end                 
layers = sparse(layers);    
return;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

