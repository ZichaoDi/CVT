function e = energy_1d(data)
global maxx minx
n = size(data,1);
e=0;
for j=1:n
    
        if (j==1)
         startpt =(data(1)+minx)*0.5;    
         endpt = 0.5*(data(j)+data(j+1));
        elseif (j==n)
         startpt = 0.5*(data(j-1)+data(j));
         endpt = (maxx+data(end))*0.5;
        else
         startpt = 0.5*(data(j-1)+data(j));
         endpt = 0.5*(data(j)+data(j+1));        
        end        
        
 e = e + quad(@expr,startpt,endpt,1e-12,[],data(j));
 %e = e +(1/3)*(endpt-data(j))^3 -(1/3)*(startpt-data(j))^3;
end

function z = expr(s,data)
z =  r(s).*(s-data).^2;