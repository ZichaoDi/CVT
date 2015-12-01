function g = gradient_energy_1d(data)
global maxx minx
n = size(data,1);
g=zeros(n,1);
for j=1:n
    
        if (j==1)
         startpt =0.5*(data(1)+minx);    
         endpt = 0.5*(data(j)+data(j+1));
         g(j)=quad(@expr,startpt,endpt,1e-12,[],data(j))-0.5*(startpt-data(j))^2;
         %g(j)=(data(j)-endpt)^2-(data(j)-startpt)^2-1/2*(startpt-data(j))^2;
        elseif (j==n)
         startpt = 0.5*(data(j-1)+data(j));
         endpt = (maxx+data(end))/2;
        g(j)=quad(@expr,startpt,endpt,1e-12,[],data(j))+0.5*(endpt-data(j))^2;
         %g(j)=(data(j)-endpt)^2-(data(j)-startpt)^2+1/2*(endpt-data(j))^2;
        else
         startpt = 0.5*(data(j-1)+data(j));
         endpt = 0.5*(data(j)+data(j+1)); 
         g(j)=quad(@expr,startpt,endpt,1e-12,[],data(j));
         %g(j)=(data(j)-endpt)^2-(data(j)-startpt)^2;
        end        
        

end
function z = expr(s,data)
z =  r(s).*2*(data-s);