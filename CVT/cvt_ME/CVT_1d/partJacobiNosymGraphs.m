function new = partRelaxationNosym(data,Jac,level)

level
N = size(Jac,2);
p = size(Jac,1);
skip=2^level-1;

old = data;

dataExact = zeros(N,1);
for k=1:N
     dataExact(k)=(2*k-1)/(2*N);
end    

figure(5);
grid on;
axis([1 N -0.1 0.1]);
hold on;

for i=1:p
    i;
    error = data-dataExact;
    norma = ones(N,1)*norm(error)/sqrt(N);
    c = [i/(2*p); 1-i/(2*p); i/(2*p)];
     plot(1:N,error(1:N),'.-','color',c);
     plot(i,error(i),'k.');
     plot(1:N,norma(1:N),':','color',c);
     drawnow;
     pause(1);
    
    options = optimset('display','none');
    x0 = 0;
    
    alpha = fsolve(@enerDeriv,x0,options,old,Jac,level,i);
    
    sz = size(alpha,1);
    sol = 0;
    sum
    if (sz==1)
        sol = alpha(1);
    else    
    for ii=1:sz
     check=subs(diff(sum),alpha(ii));
     if (double(check)>0)
         sol = alpha(ii);
     end    
    end
    end
    
    
    if (imag(sol)~=0)         
        sol
        fprintf('Complex result of minimization!!!');
        new = zeros(N,1);
        return;
    end    
    sol;
    data = data+sol*Jac(i,:)';
    data'
    sol*Jac(i,:)
    
    dd = double(data);
    if (norm(dd-sort(dd))>eps) 
        dd-sort(dd)
        data = data0;
        fprintf('Ordering of points changed during minimization!!!');        
    end    
    pack;
end    

dataExact
old
new = data

double(new);
clear sum tau intDouble intSym data0 sol alpha;

%-------------------------------------------
function z = enerDeriv(x,data,Jac,level,i)

%rr = inline('1');

N = size(Jac,2);
p = size(Jac,1);
skip=2^level-1;

    sum=0;
    ener = 0;
    ind = 1+(i-1)*(skip+1)
    data0 = double(data);
    data = data0 + x*Jac(i,:)';
    
    for j=(ind-skip-1):(ind+skip+1)    
        if (j>0)&(j<=N)
        startpt = zeros(1);
        endpt=zeros(1);
        intDouble = 0;
        intDoubleE = 0;
        lower = 0;
        upper = 0;   
            
        if (j==1)
         startpt = 0;    
         endpt = 0.5*(data(j)+data(j+1));
         lower = 0;
         upper = 0.5*(Jac(i,j)+Jac(i,j+1))*feval(r,endpt)*(endpt - data(j))^2;       
        elseif (j==N)
         startpt = 0.5*(data(j-1)+data(j));
         endpt = 1;
         lower = 0.5*(Jac(i,j)+Jac(i,j-1))*feval(r,startpt)*(startpt - data(j))^2;
         upper = 0;
        else
         startpt = 0.5*(data(j-1)+data(j));
         endpt = 0.5*(data(j)+data(j+1));
         upper = 0.5*(Jac(i,j)+Jac(i,j+1))*feval(r,endpt)*(endpt - data(j))^2;
         lower = 0.5*(Jac(i,j)+Jac(i,j-1))*feval(r,startpt)*(startpt - data(j))^2;
        end        
  
         %intSym = int(-2*rr(s)*(s-data(j))*Jac(i,j),s);
         %intDouble = subs(intSym,s,endpt)-subs(intSym,s,startpt);
         
         intDouble = -2*Jac(i,j)*(0.5*(endpt^2-startpt^2)-data(j)*(endpt - startpt));
         intDouble = intDouble - 2*0.1*Jac(i,j)*((endpt^3-startpt^3)/3 - data(j)*0.5*(endpt^2-startpt^2));
                                          
        sum = sum +  intDouble + upper - lower;

        end
    end

z = sum;