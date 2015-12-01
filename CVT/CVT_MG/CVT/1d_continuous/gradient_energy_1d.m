function g = gradient_energy_1d(data)
global maxx minx
n = size(data,1);
g=zeros(n,1);
if(n==1)
    startpt = minx;
    endpt = maxx;
    expr=@(s) r(s).*2.*(data(1)-s); 
    g=qk15a(expr,startpt,endpt);
% g=quad(@expr,startpt,endpt,1e-12,[],data(1));
else
for j=1:n
    
        if (j==1)
         startpt = minx;    
         endpt = 0.5*(data(j)+data(j+1));
        elseif (j==n)
         startpt = 0.5*(data(j-1)+data(j));
         endpt = maxx;
        else
         startpt = 0.5*(data(j-1)+data(j));
         endpt = 0.5*(data(j)+data(j+1));
        end        
expr=@(s) r(s).*2.*(data(j)-s);  
g(j)=qk15a(expr,startpt,endpt);
%g(j)=exp(-100*(startpt-0.5))*((data(j)-startpt)/(-50)+1/5000)+exp(-100*(endpt-0.5))*((data(j)-endpt)/50-1/5000);
%g(j)=quad(@expr,startpt,endpt,1e-12,[],data(j));
end
end

% function z = expr(s,data)
% z =  r(s).*2.*(data-s);