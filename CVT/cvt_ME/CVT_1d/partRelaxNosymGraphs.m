function new = partRelaxNosymGraphs(data,Jac,level)

%syms s;

graphs = 0;
graphsIter = 0;

level;
N = size(Jac,2);
p = size(Jac,1);
skip=2^level;

old = data;

pp=0;

for i=1:p
    
    ind = 1+(i-1)*(skip);
 
    h = 0; 
    options = optimset('display','none','TolFun',1e-16);
    x0 = h;
    [alpha,fval,exitflag] = fsolve(@enerDeriv,x0,options,data,Jac,level,i);
    
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

new = data;

double(new);
clear sum tau intDouble intSym data0 sol alpha;

%-------------------------------------------
function z = enerDeriv(x,data,Jac,level,i)

N = size(Jac,2);
p = size(Jac,1);
skip=2^level;

% syms s;
% rr = inline('1');

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
         %lower = 0;         
         %upper = 0.5*(Jac(i,j)+Jac(i,j+1))*r(endpt)*(endpt - data(j))^2;                    
        elseif (j==N)
                        %disp('right end');
         startpt = 0.5*(data(j-1)+data(j));
         endpt = 1;
         %lower = 0.5*(Jac(i,j)+Jac(i,j-1))*r(startpt)*(startpt - data(j))^2;
         %upper = 0;        
        else
                        %disp('not an end');
         startpt = 0.5*(data(j-1)+data(j));
         endpt = 0.5*(data(j)+data(j+1));
         %upper = 0.5*(Jac(i,j)+Jac(i,j+1))*r(endpt)*(endpt - data(j))^2;
         %lower = 0.5*(Jac(i,j)+Jac(i,j-1))*r(startpt)*(startpt - data(j))^2;
        end        
%          intSym = int(-2*rr(s)*(s-data(j))*Jac(i,j),s);
%          intDouble = subs(intSym,s,endpt)-subs(intSym,s,startpt);         
         intDouble = quad(@expr,startpt,endpt,1e-12,[],data(j),Jac(i,j));
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

function z = expr(s,data,J)
z =  -2*r(s).*(s-data).*J;