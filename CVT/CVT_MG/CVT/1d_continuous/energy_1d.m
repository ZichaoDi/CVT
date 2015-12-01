function e = energy_1d(data)
global maxx minx
n = size(data,1);
e=0;
if(n==1)
    startpt = minx; 
    endpt = maxx;
    expr=@(x) r(x).*(x-data(1)).^2;
    e=qk15a(expr,startpt,endpt);
%e=quad(@expr,startpt,endpt,1e-12,[],data(1));
else
for j=1:n
    %j
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
expr=@(x) r(x).*(x-data(j)).^2;
  e = e + qk15a(expr,startpt,endpt);    
  %e=e+exp(-100*(startpt-0.5))*((data(j)-startpt)^2/(-100)+(data(j)-startpt)/5000+1/500000)+exp(-100*(endpt-0.5))*((data(j)-endpt)^2/100-(data(j)-endpt)/5000-1/500000);
 %e = e + quad(@expr,startpt,endpt,1e-12,[],data(j));
 %e = e + (1/3)*(endpt-data(j))^3 - (1/3)*(startpt-data(j))^3;
end
end

% function z = expr(s,data)
% z =  r(s).*(s-data).^2;