function zzz=LloydTriag

%data = load('28data.txt');
%dataExact = load('28dataExact.txt');
Ncycles=5;
dataExact = [-1/2     0.0       0;
              0.0    sqrt(3)/2  0; 
              1/2    0.0        0];
           
N = size(dataExact,1)
epsilon = 1e-6;
fid1 = fopen('rho.txt','a');
fid2 = fopen('rhoLloyd.txt','a');

for i=1:2
 Nprev = N;   
 dataPred = dataExact;
 [dataExact,nn] = refine(dataExact);
 nn
 data = dataExact;
 %plot(data(:,1),data(:,2),'r.');
 N = nn;
end 
 
return;

for level=1:1
%level=7;   %%-------------------------------- 
%for i=1:level
 error = zeros(1);
 errorL = zeros(1);
 err = 1;

 Nprev = N;   
 dataPred = dataExact;
 [dataExact,nn] = refine(dataExact);
 N = nn;
 %end


dataPred;
data = zeros(N,3);
dataL = zeros(N,3);
data=dataExact;
dataL = data;
size(data);
%[v,c]=voronoin(data(:,1:2));
%drawVorTri(data(:,1:2),v,c);
hold on;

pert1 = 0;%1e-3;
pert2 = 1e-3;
active = 0;
coarse = 0;
%start = 9*(level+1)+1;
%subplot(1,2,1);
hold on;
xx = [pert1,pert2];
data = pereschet(xx,data,dataPred,dataExact,Nprev);

N
[v,c]=voronoin(data(1:N,1:2));
%drawVorTri(data(1:N,1:2),v,c);
dataL(1:N,:) = data(1:N,:);
data;
dataL;
%return;

norm(dataL(1:N,1:2)-dataExact(1:N,1:2))/sqrt(N)

vL=v;
cL=c;
pp=1;
N;

while (pp<=Ncycles)&(err>epsilon)  
    pp;
        
    error(pp) = norm(data(1:N,1:2)-dataExact(1:N,1:2))/sqrt(N);    
    err = error(pp);    
    errorL(pp) = norm(dataL(1:N,1:2)-dataExact(1:N,1:2))/sqrt(N);    
    errL = errorL(pp);    
    
    
    for i=1:N
     func(i) = norm(data(i,1:2)-dataExact(i,1:2))/sqrt(N);
     funcL(i) = norm(dataL(i,1:2)-dataExact(i,1:2))/sqrt(N);
    end
    size(func);
    
    subplot(1,2,1)
    cla;
    hold on;
    rotate3d on;
    grid on;
    axis([-0.5 0.5 0 0.9 0 1e-4]);
    axis auto;
    axis square;
    view(3);
    tri = delaunay(data(1:N,1),data(1:N,2));
    trimesh(tri,data(1:N,1),data(1:N,2),func(1:N));
    drawnow;
    
     subplot(1,2,2)
    cla;
    hold on;
    rotate3d on;
    grid on;
    axis([-0.5 0.5 0 0.9 0 1e-4]);
    axis auto;
    axis square;
    view(3);
    tri = delaunay(dataL(1:N,1),dataL(1:N,2));
    trimesh(tri,dataL(1:N,1),dataL(1:N,2),funcL(1:N));
    drawnow;
    
%     subplot(1,2,1);
%     axis square;
%     %cla;    
%     hold on;
%     plot(data(:,1),data(:,2),'r.');
%     drawVorTri(data,v,c);
%     drawnow;    

     %data = centroids2dTriTest(data,v,c,dataPred,dataExact);
     if (pp==1) x0 = 0.1; else x0 = alph; end
     options = optimset('display','iter','maxiter',5);
     [alph,fval,exitflag] = fminunc(@ener2d,x0,options,data,dataPred,dataExact,Nprev);
     data = pereschet(alph*[0 1],data,dataPred,dataExact,Nprev);
     [v,c]=voronoin(data(1:N,1:2));
     dataL = data;%centroids2dTri(dataL,vL,cL);
     [vL,cL]=voronoin(dataL(1:N,1:2));
     
     pp=pp+1
     
end    

 pp
 error
 errorL
 rho = (error(pp-1)/error(1))^(1/(pp-1))
 rhoL = (errorL(pp-1)/errorL(1))^(1/(pp-1))
 

 fprintf(fid1,'%d %f\n',N,rho);
 fprintf(fid2,'%d %f\n',N,rhoL);
 
end

 fclose(fid1);
 fclose(fid2);
 
 %cycles_taken = pp-2;
 %rho = error(cycles_taken-1)/error(1);
 %rho = rho^(1/cycles_taken)

