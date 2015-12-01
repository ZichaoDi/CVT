function zzz = voronSeidelComplete(N,eps,NGridStep,Ncycles,mu1,mu2,mu0,fileIN, fileOUT,handles,hObject)

format long e;
t0=clock;

N
eps
NGridStep
Ncycles
mu1
mu2
mu0
fileIN 

ffOUT = [fileOUT,'.txt'];
figOUT = [fileOUT,'.fig']
arrayOUT = ['C:\DOC\MASHA\Du\multigrid\1d\may04\constResults\NrhoTableEps.txt'];

fid = fopen(fileIN);
fout = fopen(ffOUT,'a');
foutArray = fopen(arrayOUT,'a');


Ninit = N;
%eps = input('Input eps=approximation parameter');
%eps = 1e-10;
epsilon=0.01;
param = 0.01;
Nsample=0;

nu = 0; %number of relaxations on coarsest level
coarse = 1; %is exact solve used? 1 if yes

window = 0.01;
pictures = 0;
RelaxV = 2*(mu1+mu2)*(1-0.5^(NGridStep-1)) + (1 + ceil(mu0/(mu0 + 1)))*0.5^(NGridStep) + mu0*0.5^(NGridStep-1); 
RelaxTotal = RelaxV*Ncycles

pp=0;

stt = 1/Ncycles;
Jacobian = jacs(N,NGridStep);
errorV = zeros(Ncycles,1);
error = zeros(Ncycles,1);
engy = zeros(2,1);
errAll = zeros(2,1);
error0=0;
errorLast = error0;
p = N;
outer = 1;
current_error = 1;

t0 = clock;
         
%------------------------------------------------
% Multigrid cycle begins
%------------------------------------------------
while (outer<=Ncycles)&(current_error>eps)

for ss=NGridStep:-1:2 %------------------------------------------------begin coarsening the grid
   
if (outer==1)&&(ss==NGridStep) %first outer loop iteration => random initialization   
 data = zeros(N,1); 
 dataExact = zeros(N,1);
 
 data = fscanf(fid,'%f');
 
 for k=1:N
     %data(k)=initialize(x);
     %data(k)=(2*k-1)/(2*N);     
     dataExact(k)=(2*k-1)/(2*N);
 end  
 engyExact = energy(dataExact);
 
 % data=sort(data)
 data;
 fprintf('Initial error:'); 
 data-dataExact;
 dataFirst = data;
 error0 = norm(data-dataExact)/sqrt(N);
 errorLast = error0;
 
 Nsample;
 save initial.dat data -ascii;
end %other iterations => initial guess given by coarsening previous iteration

errRelax = zeros(mu1,1);
if (ss==NGridStep)  
 p = N;
end

Jac = zeros(p,N);
Jac = Jacobian(1:p,1:N,ss);    

fprintf('Begin coarsening relaxations\n');
energy(data)
for ttt=1:mu1 %--------------------------------------relaxation
    
data = double(partRelaxNosymGraphs(data,Jac,NGridStep-ss));

if (norm(data)<=eps) 
    data
    fprintf('Problem encountered during relaxation at level %d step %d',ss,ttt);
    return;    
end

pp=pp+1
engy(pp)=norm(energy(data)-engyExact)/sqrt(N);
errAll(pp) = norm(data - dataExact)/sqrt(N);

if (outer==1)&&(ss==NGridStep)
    %error0 = norm(data - dataFirst)/sqrt(N);
end    
end  % ------------------------------------------end relaxation  

energy(data)

err = data - dataExact;
nnorm = ones(N,1)*norm(err)/sqrt(N);
errRelax(ttt) = norm(data - dataExact)/sqrt(N);
fftRelax = fft(data-dataExact);
norma = ones(N,1)*norm(fftRelax)/sqrt(N);

if (pictures==1)
figure(100);
subplot(NGridStep-1,2,2*(NGridStep-ss)+1);
axis([1 N -window window]);
hold on;
grid on;
c = [outer*stt; 1-outer*stt; outer*stt]; 
% plot(1:N,fftRelax(1:N),'.-','color',c);
% plot(1:N,norma(1:N),'-','color',c);
plot(1:N,err(1:N),'.-','color',c);
plot(1:N,nnorm(1:N),':','color',c);
drawnow;
end

p = (p+1)/2;

end %-----------------------------------------------------------------------end coarsening 

Jac = zeros(p,N); 
Jac(1:p,1:N) = Jacobian(1:p,1:N,1);
%!!!!!!!!! coarsest grid solve!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

if (coarse==1)
 skip = 2^(NGridStep-1);

%  for i=1:p
%  ind = 1+(i-1)*skip;
%  epss = data(ind)-dataExact(ind);
%  T = data;
%  data = data - epss*Jac(i,:)';
%  end

end

T = data;

energy(data)

for i=1:nu
 rel=i   
 
 data  = double(partRelaxNosymGraphs(data,Jac,NGridStep-1)); 
 if (norm(data)<=eps) 
    data;
    fprintf('Problem encountered during relaxation at coarsest level step %d',i);
    return;   
 end

end
pp=pp+1;
engy(pp) = norm(energy(data)-engyExact)/sqrt(N);
errAll(pp) = norm(data-dataExact)/sqrt(N);
errorPred = errorLast;
errorLast = norm(data-T)/sqrt(N);

energy(data)

if (mu0>0)
%--------------W-cycle sweep---------------------------------

p1 = 2*p-1;
Jac = zeros(p1,N);
Jac(1:p1,1:N) = Jacobian(1:p1,1:N,2);
%data = data';
Jac;
for i=1:mu0
 data = double(partRelaxNosymGraphs(data,Jac,NGridStep-2));
 
 if (norm(data)<=eps) 
    data
    fprintf('Problem encountered during W-part step %d',i);
    return;    
 end

 pp=pp+1
 engy(pp) = norm(energy(data)-engyExact)/sqrt(N);
 errAll(pp) = norm(data-dataExact)/sqrt(N);
end

%-------------end W-cycle sweep, back to coarsest grid solve
Jac = zeros(p,N);
Jac(1:p,1:N) = Jacobian(1:p,1:N,1);
T = data;
for i=1:nu
 rel=i;
 data  = double(partRelaxNosymGraphs(data,Jac,NGridStep-1)); 
 
 if (norm(data)<=eps) 
    data
    fprintf('Problem encountered during relaxation at end of W-part step %d',i);
    return;    
 end

end
pp=pp+1;
engy(pp) = norm(energy(data)-engyExact)/sqrt(N);
errAll(pp) = norm(data-dataExact)/sqrt(N);
%-----------------------------------------------------------
errorPred = errorLast;
errorLast = norm(data-T)/sqrt(N);
end

for ss=2:NGridStep % ---------------------------------------------begin refining the grid
    
pold = p;    
p = 2*p-1;

error=zeros(1,1);

Jac = zeros(p,N);
Jac(1:p,1:N) = Jacobian(1:p,1:N,ss);
Jac;

errRelax = zeros(mu2,1);
fftRelax = zeros(mu2,1);

fprintf('Begin refining relaxations\n');
%-------------------------------------------------
% Cycle begins
%-------------------------------------------------
for step=1:mu2   %relaxations

T = data;
data = double(partRelaxNosymGraphs(data,Jac,NGridStep-ss));

if (norm(data)<=eps) 
    data
    fprintf('Problem encountered during relaxation at level %d step %d',ss,step);
    return;    
end

pp=pp+1
engy(pp) = norm(energy(data)-engyExact)/sqrt(N);
errAll(pp) = norm(data-dataExact)/sqrt(N);

errorPred = errorLast;
errorLast = norm(data-T)/sqrt(N);


errRelax(step) = norm(data-dataExact)/sqrt(N);
err = data-dataExact;
nnorm = ones(N,1)*errRelax(step);
fftRelax = fft(data-dataExact);
norma = ones(N,1)*norm(fftRelax)/sqrt(N);

end %---------------------------------------------for cycle
t1=etime(clock,t0);

if (pictures==1)
figure(100);
subplot(NGridStep-1,2,2*(NGridStep-ss) + 2);
axis([1 N -window window]);
hold on;
grid on;
c = [outer*stt; 1-outer*stt; outer*stt];
% plot(1:N,fftRelax(1:N),'.-','color',c);
% plot(1:N,norma(1:N),'-','color',c);
plot(1:N,err(1:N),'.-','color',c);
plot(1:N,nnorm(1:N),':','color',c);
drawnow;
end

if (pictures==1)
if (ss==NGridStep)
figure(10);
axis([1 N -0.1*window 0.1*window]);
hold on;
grid on;
c = [outer*stt; 1-outer*stt; outer*stt];
%plot(1:N,fftRelax(1:N),'.-','color',c);
plot(1:N,err(1:N),'.-','color',c);
plot(1:N,nnorm(1:N),'-','color',c);
end
end
 
end %----------------------------------------------------------end refinement

errorV(outer) = errAll(pp);
error = abs(log(errorV));
if (outer>1) 
    convergenceV(outer)=error(outer)/error(outer-1); 
end

errorV;
current_error = errorV(outer);

sz = size(engy,1);
%figure(500);
set(handles.IterNumber,'String',num2str(outer));
set(handles.CurError,'String',num2str(errorV(outer)));
set(handles.CurRho,'String',num2str((errorV(outer)/error0)^(1/outer)));
guidata(hObject, handles);

axes(handles.axes1)
hold on;
grid on;
ylabel('energy');
semilogy(1:sz,engy,'r.-');

sz = size(errAll,1);
%figure(600);
axes(handles.axes2)
hold on;
grid on;
ylabel('error');
semilogy(1:sz,errAll,'r.-');
drawnow;

if (pictures==1)
figure(200);
subplot(1,2,1);
axis;
hold on;
grid on;
title('||log(errorV_{new})/log(errorV_{old})||');
if (outer>2)
plot([outer-1,outer],[convergenceV(outer-1),convergenceV(outer)],'b.-');
end

subplot(1,2,2);
axis;
hold on;
grid on;
title('||errorV||');
   if (outer>1)
   plot([outer-1,outer],[errorV(outer-1),errorV(outer)],'r.-');
   else
   plot([0,1],[error0,errorV(1)],'r.-');    
   end    
drawnow;
end

rho = errorLast/errorPred
fprintf(fout,'%d  %2.18f\n',N,rho);

outer = outer + 1;
     
end %----------------------------------------------------------end V-cycle

% convergenceV'
 cycles_taken = outer-1
 
 fprintf(fout,'# cycles taken = %d\n',outer-1);
 fprintf(fout,'engy = %2.18f\n',engy);
 fprintf(fout,'errAll = %2.18f\n',errAll);
 fprintf(fout,'errorV = %2.18f\n',errorV);
 fprintf(fout,'error0= %2.18f\n',error0);
 fprintf(fout,'RelaxTotal = %2.3f\n',RelaxTotal);
 rho = errorV(cycles_taken)/error0
 fprintf(fout,'rho = errorV(Ncycles)/error0 = %2.18f\n', rho);
 rho = rho^(1/cycles_taken)
 fprintf(fout,'rho = rho^(1/Ncycles)=%2.18f\n',rho);

%rho = rho^(1/RelaxTotal)

sz = size(engy,1);
%figure(500);
axes(handles.axes1)
hold on;
grid on;
ylabel('energy');
semilogy(1:sz,engy,'r.-');

sz = size(errAll,1);
%figure(600);
axes(handles.axes2)
hold on;
grid on;
ylabel('error');
semilogy(1:sz,errAll,'r.-');
 
% errorLast=errAll(sz)
% errorPred=errAll(sz-1)
% rho = errorLast/errorPred
     
fprintf(foutArray,'%d  %2.18f\n',N,rho);
     
     
fclose(fout);
fclose(foutArray);

ds = (mu1+mu2)*(NGridStep-1)+mu0
sz
pts = 1:ds:sz;

figure(101);
hold on;
grid on;
xlabel('# iterations');
ylabel('L_{2} error');
semilogy(pts,errAll(pts),'r.-');

figure(102);
hold on;
grid on;
xlabel('# iterations');
ylabel('Energy');
semilogy(pts,engy(pts),'r.-');

elapsed_time = etime(clock,t0)