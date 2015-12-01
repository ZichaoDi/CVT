function new = partRelaxationNosym(data,Jac,level)

%syms s;

graphs = 0;
graphsIter = 0;

level;
N = size(Jac,2);
p = size(Jac,1);
skip=2^level;

old = data;

dataExact = zeros(N,1);
for k=1:N
     dataExact(k)=(2*k-1)/(2*N);
end    


pp=0;

for i=1:p
    
    ind = 1+(i-1)*(skip);
    error = data-dataExact;
    norma = ones(N,1)*norm(error)/sqrt(N);    
    c = [i/(2*p); 1-i/(2*p); i/p];
   
    if (graphsIter==1)
    figure(5);
    grid on;
    axis([1 N -0.01 0.05]);
     hold on;
     title(['level=',num2str(level)]);
     plot(1:N,error(1:N),'.-','color',c);
     plot(ind,error(ind),'k.');
     plot(1:N,norma(1:N),':','color',c);
     drawnow;
    end
 
%     mm=0; 
%     for xx=0:0.01:1
%         ee=enerDeriv(xx,data,Jac,level,i,1);
%         if (ee>mm)
%             mm=ee;
%         end
%     end    
%     mm
%     x0 = mm;    

    if (graphs==1)
    figure(111);    
    hold on;
    grid on;
    axis([-1 1 -1 1]);
    ss = -1:0.01:1;
    sum = enerDeriv(ss,data,Jac,level,i);
    plot(ss,sum,'.-','color',c);    
    drawnow;
    end
    
%     coeff = sym2poly(sum);
%     size(coeff)
%     
%     if (size(coeff,2)==3)
%     a = coeff(1);
%     b = coeff(2);
%     c = coeff(3);
%     vertex = -b/(2*a);
%     [root1,root2] = quadRoots(a,b,c);
%     
%     if (2*a*root1+b>0)
%        sol=root1;
%     elseif (2*a*root2+b>0)
%        sol=root2 ; 
%     end        
%     
%     else
%         a = coeff(1);
%         b = coeff(2);
%         sol = -b/a;
%     end
    
    h = 1e-5; 
    options = optimset('display','none');
    x0 = h;
    [alpha,fval] = fzero(@enerDeriv,x0,options,data,Jac,level,i);
    
    
    sz = size(alpha,1);
    sol = 0;
    
    if (sz==1)
        sol = alpha(1);
    else    
     for ii=1:sz         
     check = (enerDeriv(alpha(ii)+h,data,Jac,level,i)-fval(ii))/h;     
     
     %subs(diff(sum),alpha(ii));
     if (double(check)>0)
         sol = alpha(ii);
     end    
     end
    end
    
    
    if (imag(sol)~=0)         
        sol;
        fprintf('Complex result of minimization!!!');
        new = zeros(N,1);
        return;
    end    

    old = data;
    old';
    Jac(i,:);
    data = data + sol*Jac(i,:)';
    data';
    
    
    dd = double(data);
    if (norm(dd-sort(dd))>eps) 
        dd-sort(dd);
        data = old;
        fprintf('Ordering of points changed during minimization!!!');        
    end    
    pack;
end    

error = data-dataExact;
    norma = ones(N,1)*norm(error)/sqrt(N);    
    c = [i/(2*p); 1-i/(2*p); i/p];
    
    if (graphsIter==1)
    figure(5);
    grid on;
    axis([1 N -0.1 0]);
     hold on;
     plot(1:N,error(1:N),'.-','color',c);
     plot(ind,error(ind),'k.');
     plot(1:N,norma(1:N),':','color',c);
     drawnow;
    end 
new = data;

double(new);
clear sum tau intDouble intSym data0 sol alpha;

%-------------------------------------------
function z = enerDeriv(x,data,Jac,level,i)

N = size(Jac,2);
p = size(Jac,1);
skip=2^level;

    sum=0;
    coeffA = 0;
    coeffB = 0;
    coeffC = 0;
    
    ener = 0;
    ind = 1+(i-1)*(skip);
    data0 = double(data);
    data = data0 + x*Jac(i,:)';
    
    for j=(ind-skip):(ind+skip)
        
        j;
        
        if (j>0)&(j<=N)
        startpt = zeros(1);
        endpt=zeros(1);
        intDouble = 0;
        intDoubleE = 0;
        lower = 0;
        upper = 0;   
            
        if (j==1)
            %disp('left end');
         startpt = 0;    
         endpt = 0.5*(data(j)+data(j+1));
         lower = 0;
         %lower = 0.5*(Jac(i,j))*subs(rr,startpt)*(startpt - data(j))^2
         upper = 0.5*(Jac(i,j)+Jac(i,j+1))*r(endpt)*(endpt - data(j))^2;   
         
%          int0 = -2*Jac(i,j)*(0.5*(endpt^2-startpt^2)-data0(j)*(endpt - startpt));
%          
%          coeffA = coeffA + (Jac(i,j))^2*0.5*((Jac(i,j+1)+Jac(i,j))*subs(rr,endpt)-...
%             (Jac(i,j))*subs(rr,startpt));
%         
%         coeffB = coeffB + 2*(Jac(i,j)^2)*(endpt-startpt) - ...
%             0.5*Jac(i,j)*((Jac(i,j)+Jac(i,j+1))*(endpt-data0(j))*subs(rr,endpt)-...
%             (Jac(i,j))*(startpt-data0(j))*subs(rr,startpt));
%         
%         coeffC = 0.5*(Jac(i,j)+Jac(i,j+1))*(endpt-data0(j))^2*subs(rr,endpt) - ...
%             0.5*(Jac(i,j))*(startpt-data0(j))^2*subs(rr,startpt)  + intDouble;
        
        elseif (j==N)
                        %disp('right end');
         startpt = 0.5*(data(j-1)+data(j));
         endpt = 1;
         lower = 0.5*(Jac(i,j)+Jac(i,j-1))*r(startpt)*(startpt - data(j))^2;
         upper = 0;
         %upper = 0.5*(Jac(i,j))*subs(rr,endpt)*(endpt - data(j))^2
         
%          int0 = -2*Jac(i,j)*(0.5*(endpt^2-startpt^2)-data0(j)*(endpt - startpt));
%          
%          coeffA = coeffA + (Jac(i,j))^2*0.5*((Jac(i,j))*subs(rr,endpt)-...
%             (Jac(i,j)+Jac(i,j-1))*subs(rr,startpt));
%         
%         coeffB = coeffB + 2*(Jac(i,j)^2)*(endpt-startpt) - ...
%             0.5*Jac(i,j)*((Jac(i,j))*(endpt-data0(j))*subs(rr,endpt)-...
%             (Jac(i,j)+Jac(i,j-1))*(startpt-data0(j))*subs(rr,startpt));
%         
%         coeffC = 0.5*(Jac(i,j))*(endpt-data0(j))^2*subs(rr,endpt) - ...
%             0.5*(Jac(i,j)+Jac(i,j-1))*(startpt-data0(j))^2*subs(rr,startpt)  + intDouble;
        
        else
                        %disp('not an end');
         startpt = 0.5*(data(j-1)+data(j));
         endpt = 0.5*(data(j)+data(j+1));
         upper = 0.5*(Jac(i,j)+Jac(i,j+1))*r(endpt)*(endpt - data(j))^2;
         lower = 0.5*(Jac(i,j)+Jac(i,j-1))*r(startpt)*(startpt - data(j))^2;
%          int0 = -2*Jac(i,j)*(0.5*(endpt^2-startpt^2)-data0(j)*(endpt - startpt));
%          
%          coeffA = coeffA + (Jac(i,j))^2*0.5*((Jac(i,j+1)+Jac(i,j))*subs(rr,endpt)-...
%             (Jac(i,j)+Jac(i,j-1))*subs(rr,startpt));
%         
%          coeffB = coeffB + 2*(Jac(i,j)^2)*(endpt-startpt) - ...
%             0.5*Jac(i,j)*((Jac(i,j)+Jac(i,j+1))*(endpt-data0(j))*subs(rr,endpt)-...
%             (Jac(i,j)+Jac(i,j-1))*(startpt-data0(j))*subs(rr,startpt));
%         
%          coeffC = 0.5*(Jac(i,j)+Jac(i,j+1))*(endpt-data0(j))^2*subs(rr,endpt) - ...
%             0.5*(Jac(i,j)+Jac(i,j-1))*(startpt-data0(j))^2*subs(rr,startpt)  + intDouble;
%         
        end        
  
         %intSym = int(-2*rr(s)*(s-data(j))*Jac(i,j),s);
         %intDouble = subs(intSym,s,endpt)-subs(intSym,s,startpt);
         %expr = inline('-2*(1+10*s)*(s-data(j))*Jac(i,j)','s');
         intDouble = quad(@expr,startpt,endpt,[],[],data(j),Jac(i,j));
         %intDouble = -2*Jac(i,j)*(0.5*(endpt^2-startpt^2)-data(j)*(endpt - startpt));
         
         %intDouble = intDouble - 2*0.1*Jac(i,j)*((endpt^3-startpt^3)/3 - data(j)*0.5*(endpt^2-startpt^2));
                                          
        sum = sum +  intDouble;% + upper - lower;
        
        end
    end

coeffA;
coeffB;
coeffC;
coeff = [coeffA coeffB coeffC];

%z = coeff;

% s = sym('s');
% poly2sym(coeff,s)
 z = sum;


function [z1,z2]=quadRoots(a,b,c)

discriminant = b^2-4*a*c ; 
z1 = (-b+sqrt(discriminant))/(2*a);
z2 = (-b-sqrt(discriminant))/(2*a);

function z = expr(s,data,J)

%rr = inline('1');
z =  -2*r(s).*(s-data).*J;