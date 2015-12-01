function zzz = MG2d
global pp;
global time0;
global A struct N div ss layers total dataExact outer;

format long e; eps = 1e-6;
NGridStep = 5;
total = NGridStep;
Ncycles = 2; mu1=1; mu2=0; mu0=0; epsilon=0.01; param = 0.01;

nu = 5; %number of relaxations on coarsest level
fout = fopen('output_all.txt','a'); fid1 = fopen('rho_nonlin_log.txt','a');

pp=0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Outer cycle = varying the size of the problem
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for div = [64]
    div

N = load('64N.txt');
dataExact = load('64Exact.txt');
 struct = load('64struct.txt');
 layers = load('64layers.txt');
 A = load('64A.txt');

%[N,data,struct,dataExact]=adj;




errorV = zeros(Ncycles,1); error = zeros(Ncycles,1);
engy = zeros(2,1); errAll = zeros(2,1); error0=0; errorLast = error0;

%...........Initialization...............................
% 
%   [struct,N] = formation(div); 
%   dataExact = mapping(struct);
%   size(dataExact);
data = zeros(N,2);
 pert1 = 1e-4;
 pert2 = -1e-4;
%   figure(100);
%    hold on;
 for i=1:N
     pt = zeros(1,2);
     pt(1:2) = dataExact(i,1:2);
  if (isbdry(pt(1),pt(2))) 
      data(i,1)  = pt(1) + rand(1)*pert1;
      data(i,2)  = pt(2) + rand(1)*pert2;
     
      %plot(data(i,1),data(i,2),'ro');
  else    
      data(i,1:2) = pt(1:2);
      %plot(data(i,1),data(i,2),'r.');
  end    
 end


error0 = norm(data-dataExact)/sqrt(N)
data

N = size(data,1)

%drawVor(dataExact,'bo');
%return;

 %[dataTest,Nsec] = formation(div);
% drawVor(data);
% drawVor(mapping(dataTest));
% return;
 
N
time0 = clock;

 %return;
%.........................................................

outer = 1; current_error = 1; time0 = clock;

%------------------------------------------------
% Multigrid cycle begins
%------------------------------------------------
while (outer<=Ncycles)&(current_error>eps)

for ss=NGridStep:-1:2 %------------------------------------------------begin coarsening the grid
   
ss    
if (ss~=NGridStep)  
level = NGridStep - ss;
[dataTest,Nsec] = formation(div/2^level);
%drawVor(mapping(dataTest));
%return;
end
%clf;

if (outer==1)&&(ss==NGridStep)
    error0 = norm(data-dataExact)/sqrt(N);
    errorLast = error0;    
    dataPred = data;
    dataPPred = data;
end    


%...........fprintf('Begin coarsening relaxations\n');...........<<<<<<
for ttt=1:mu1 %........................................relaxation
    
dataPPred = dataPred;    
dataPred = data;    
if (ss==NGridStep)
    data = double(relaxation_full6(data,NGridStep-ss));
else
    data = double(relaxation_full6(data,NGridStep-ss,dataTest, struct));
end


etime(clock,time0), errMessage(data,eps,ss,ttt)
pp=pp+1; 
%engy(pp)=enerTest(data);
errAll(pp) = norm(data-dataPred)/norm(dataPred-dataPPred);
%errAll(pp) = norm(data - dataExact)/sqrt(N);


end  %.............................................end relaxation 
%................................................................<<<<<<
fprintf('\n%2.16f\n',norm(data-dataExact)/sqrt(N));
%p = (p+1)/2;

end %-----------------------------------------------------------------------end coarsening 


%...............COARSEST GRID SOLVE..............................<<<<<<
%clf;
ss = 1;
level = NGridStep - 1;
[dataTest,Nsec] = formation(div/2^level);

for i=1:nu
 fprintf('rel=%d ',i); 
 dataPPred = dataPred;
 dataPred = data;
 %engyPred = enerTest(data);
 data  = double(relaxation_full6(data,NGridStep-1,dataTest, struct)); 
 fprintf('\n');
 fprintf('%2.16f\n',norm(data-dataExact)/sqrt(N));
 errMessage(data,eps,ss,i); 
end
pp=pp+1;
%engy(pp) = enerTest(data);%norm(enerTest(data)-engyPred)/sqrt(N);
%errAll(pp) = norm(data-dataExact)/sqrt(N);
errAll(pp) = norm(data-dataPred)/norm(dataPred-dataPPred);
fprintf('\n%2.16f\n',norm(data-dataExact)/sqrt(N));
%..............END COARSEST GRID SOLVE...........................<<<<<<


for ss=2:NGridStep % ---------------------------------------------begin refining the grid
ss   
if (ss~=NGridStep)  
level = NGridStep - ss;
[dataTest,Nsec] = formation(div/2^level);
end

%clf;
%...........fprintf('Begin refining relaxations\n');..............<<<<<<
for step=1:mu2 %........................................relaxation
 dataPPred = dataPred;
 dataPred = data;
if (ss==NGridStep)
    data = double(relaxation_full6(data,NGridStep-ss));
else
    data = double(relaxation_full6(data,NGridStep-ss,dataTest,struct));
end

errMessage(data,eps,ss,step)
pp=pp+1;
%engy(pp) = enerTest(data);
%errAll(pp) = norm(data-dataExact)/sqrt(N);
errAll(pp) = norm(data-dataPred)/norm(dataPred-dataPPred);

end  %.............................................end relaxation 
%..................................................................<<<<<<
fprintf('\n%2.16f\n',norm(data-dataExact)/sqrt(N));
t1=etime(clock,time0)
 
end %----------------------------------------------------------end refinement

errorV(outer) = errAll(pp); error = abs(log(errorV));
if (outer>1) convergenceV(outer)=error(outer)/error(outer-1); end
if (errorV(outer)~=0) current_error = errorV(outer)/errorV(1); end

outer = outer + 1;
fprintf('cycle %d ended',outer-1);     
end %----------------------------------------------------------end V-cycle

 
 errorV
 cycles_taken = (outer-1);
 %rho = errorV(cycles_taken)/error0;
 %rho = rho^(1/cycles_taken)
 rho = errorV(cycles_taken);
 %rho = rho^(1/pp)
 fprintf(fid1,'%d %f\n',N,rho);
     
end

errorCycles(1) = error0;
errorCycles(2:outer) = errorV(1:cycles_taken);

%save 'error8.txt' -ascii -double -tabs errorCycles;

% figure(1);
% hold on;
% grid on;
% semilogy(1:outer,errorCycles(1:outer),'r.-');

fclose(fout); fclose(fid1);
elapsed_time = etime(clock,time0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  END OF OUTER CYCLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function z = errMessage(data,eps,ss,step)

if (norm(data)<=eps) 
    data;
    z=fprintf('Problem encountered during relaxation at level %d step %d',ss,step);
    return;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

