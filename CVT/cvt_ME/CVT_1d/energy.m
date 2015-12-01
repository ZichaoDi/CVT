function e = energy(data)

N = size(data,1);
e=0;
for j=1:N
    
        if (j==1)
         startpt = 0;    
         endpt = 0.5*(data(j)+data(j+1));
        elseif (j==N)
         startpt = 0.5*(data(j-1)+data(j));
         endpt = 1;
        else
         startpt = 0.5*(data(j-1)+data(j));
         endpt = 0.5*(data(j)+data(j+1));        
        end        
        
 e = e + quad(@expr,startpt,endpt,1e-12,[],data(j));
 %e = e + (1/3)*(endpt-data(j))^3 - (1/3)*(startpt-data(j))^3;
end

function z = expr(s,data)
z =  r(s).*(s-data).^2;