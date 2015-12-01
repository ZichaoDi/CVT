function E=ener2d(x,data,dataPred,dataExact,Nprev);
global denom;


N = size(data,1);
%p = size(Jac,1);

summ = 0;
    

    data;
    data0 = double(data);    
    xx = [0,x];
    data = pereschet(xx,data,dataPred,dataExact,Nprev);
    
    

epsilon = 0.01;
num = floor(1/epsilon)+1;
dx=epsilon;
x1 = 0:dx:1;
x2 = x1;
engy = zeros(N,1);

    for k=1:num
     for l=1:num
      a=x1(k);
      b=x2(l);
      point = [a b];
      [j,distance]=findClosest(data,point);    
      engy(j) = engy(j) + r2d(a,b)*distance^2; 
     end
    end
   


E=sum(engy)*dx^2;

