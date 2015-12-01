function zzz=LloydTriag

%data = load('28data.txt');
%dataExact = load('28dataExact.txt');
Ncycles=3;
dataExact = [-0.5     0.0       0;
             -1/3    sqrt(3)/6  0;
             -1/6    sqrt(3)/3  0;
              0.0    sqrt(3)/2  0; 
              1/6    sqrt(3)/3  0;
              1/3    sqrt(3)/6  0;
              1/2    0.0        0;
              1/6    0.0        0;
             -1/6    0.0        0;
              0.0    sqrt(3)/6  1];
           
N = size(dataExact,1);
error = zeros(1);
err = 1;
epsilon = 1e-6;

level=3;   %%-------------------------------- 
for i=1:level
 Nprev = N;   
 dataPrev = dataExact;
 [dataExact,nn] = refine(dataExact);
 N = nn;
end



data=dataExact;
[v,c]=voronoin(data(:,1:2));
drawVorTri(data(:,1:2),v,c);
hold on;

pert1 = 0;%1e-5;
pert2 = -1e-5;
%start = 9*(level+1)+1;
for i=1:1:N
    if (data(i,3)==1)
        
      %plot(data(i,1),data(i,2),'r.');  
      data(i,1)=data(i,1)+pert1*i;
      data(i,2)=data(i,2)+pert2*i;
   else
     % plot(data(i,1),data(i,2),'b.');  
    end
end
[v,c]=voronoin(data(1:N,1:2));
%drawVorTri(data(1:N,1:2),v,c);
pp=1;
%N
%return;
while (pp<=Ncycles)&(err>epsilon)  
    %pp
    
    error(pp) = norm(data(1:N,1:2)-dataExact(1:N,1:2))/sqrt(N);    
    err = error(pp);    
    
    for i=1:N
     func(i) = norm(data(i,1:2)-dataExact(i,1:2))/sqrt(N);
    end
    size(func);
    if (mod(pp-1,5)==0)|(pp==1)
    subplot(3,2,(pp-1)/5+1);
    cla;
    hold on;
    rotate3d on;
    grid on;
    axis([-0.5 0.5 0 0.9 0 1e-4]);
    axis auto;
    axis square;
    %view(3);
    %N
    tri = delaunay(data(1:N,1),data(1:N,2));
    trimesh(tri,data(1:N,1),data(1:N,2),func(1:N));
    drawnow;
    end
    
%     subplot(1,2,1);
%     axis square;
%     cla;    
%     hold on;
%     %plot(data(:,1),data(:,2),'r.');
%     drawVorTri(data,v,c);
%     drawnow;    

     data = centroids2dTri(data,v,c);
     figure(22); voronoi(data(:,1),data(:,2));
     [v,c]=voronoin(data(1:N,1:2));
     pp=pp+1;
end    

%  pp
%  error
%  
 %cycles_taken = pp-2;
 %rho = error(cycles_taken-1)/error(1);
 %rho = rho^(1/cycles_taken)

