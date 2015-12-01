function zzz = voronSeidelComplete(N,eps,NGridStep,Ncycles,mu1,mu2,mu0,fileIN, fileOUT,handles,hObject)

format long e;
t0=clock;

% N
% eps
% NGridStep
% Ncycles
% mu1
% mu2
% mu0
ffOUT = [fileOUT,'.txt'];
ffIN=[fileIN,'.txt'];
figOUT = [fileOUT,'.fig'];
arrayOUT = ['C:\DOC\MASHA\Du\multigrid\1d\may04\ConstResults\NrhoArray11.txt'];

fid = fopen(ffIN,'a+');
fout = fopen(ffOUT,'a');
foutArray = fopen(arrayOUT,'a');


Ninit = N;
epsilon=0.01;
param = 0.01;
Nsample=0;

nu = 0; %number of relaxations on coarsest level
coarse = 0; %is exact solve used? 1 if yes

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
 data = fscanf(fid,'%e');
 dataExact = zeros(N,1);
 for k=1:N
 dataExact(k)=(2*k-1)/(2*N);
 end
 save initial.dat data -ascii;
 engy0 = energy(data);
 engyExact = energy(dataExact);
% error0 = norm(data)/sqrt(N);
end %other iterations => initial guess given by coarsening previous iteration

errRelax = zeros(mu1,1);
if (ss==NGridStep)  
 p = N;
end

Jac = zeros(p,N);
Jac = Jacobian(1:p,1:N,ss);    

fprintf('Begin coarsening relaxations\n');

for ttt=1:mu1 %--------------------------------------relaxation
 ttt;   
%engyPred = energy(data);   
%dataPred = data;
data = double(partRelaxNosymGraphs(data,Jac,NGridStep-ss));

if (norm(data)<=eps) 
    %data
    fprintf('Problem encountered during relaxation at level %d step %d',ss,ttt);
    return;    
end  
end  % ------------------------------------------end relaxation  


  
if (pictures==1)
err = data - dataPred;
nnorm = ones(N,1)*norm(err)/sqrt(N);
errRelax(ttt) = norm(err)/sqrt(N);
fftRelax = fft(err);
norma = ones(N,1)*norm(fftRelax)/sqrt(N);
    
figure(100);
subplot(NGridStep-1,2,2*(NGridStep-ss)+1);
axis([1 N -window window]);
hold on;
grid on;
c = [outer*stt; 1-outer*stt; outer*stt]; 
% plot(1:N,fftRelax(1:N),'.-','color',c);
% plot(1:N,normaW(1:N),'-','color',c);
plot(1:N,err(1:N),'.-','color',c);
plot(1:N,nnorm(1:N),':','color',c);
drawnow;
end

p = (p+1)/2;

end %-----------------------------------------------------------------------end coarsening 

pp=pp+1;
engy(pp)=energy(data);%norm(energy(data)-engyPred)/sqrt(N);
errAll(pp) = norm(data - dataExact)/sqrt(N);
if (outer==1)&&(ss==NGridStep)
     error0 = norm(data-dataExact)/sqrt(N);
     errorE0 = engy0-engy(pp);    
     %errorLast = engy(pp);    
end   
% 
% Jac = zeros(p,N); 
% Jac(1:p,1:N) = Jacobian(1:p,1:N,1);
% %!!!!!!!!! coarsest grid solve!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% 
% % if (coarse==1)
% %  skip = 2^(NGridStep-1);
% % 
% % %  for i=1:p
% % %  ind = 1+(i-1)*skip;
% % %  epss = data(ind)-dataExact(ind);
% % %  T = data;
% % %  data = data - epss*Jac(i,:)';
% % %  end
% % 
% % end
% 
% for i=1:nu
%  rel=i;
%  %dataPred = data;
%  %engyPred = energy(data);
%  data  = double(partRelaxNosymGraphs(data,Jac,NGridStep-1)); 
%  if (norm(data)<=eps) 
%     data;
%     fprintf('Problem encountered during relaxation at coarsest level step %d',i);
%     return;   
%  end
% 
% end
% pp=pp+1;
% engy(pp) = energy(data);%norm(energy(data)-engyPred)/sqrt(N);
% errAll(pp) = norm(data-dataExact)/sqrt(N);
%errorPred = errorLast;
%errorLast = engy(pp);

% if (mu0>0)
% %--------------W-cycle sweep---------------------------------
% 
% p1 = 2*p-1;
% Jac = zeros(p1,N);
% Jac(1:p1,1:N) = Jacobian(1:p1,1:N,2);
% %data = data';
% Jac;
% for i=1:mu0
%  %dataPred = data;
%  %engyPred = energy(data);   
%  data = double(partRelaxNosymGraphs(data,Jac,NGridStep-2));
%  
%  if (norm(data)<=eps) 
%     data
%     fprintf('Problem encountered during W-part step %d',i);
%     return;    
%  end
% 
%  pp=pp+1
%  engy(pp) = energy(data);%norm(energy(data)-engyPred)/sqrt(N);
%  errAll(pp) = norm(data-dataPred)/sqrt(N);
% end
% 
% %-------------end W-cycle sweep, back to coarsest grid solve
% Jac = zeros(p,N);
% Jac(1:p,1:N) = Jacobian(1:p,1:N,1);
% T = data;
% for i=1:nu
%  rel=i;
%  %dataPred = data;
%  %engyPred = energy(data);
%  data  = double(partRelaxNosymGraphs(data,Jac,NGridStep-1)); 
%  
%  if (norm(data)<=eps) 
%     data
%     fprintf('Problem encountered during relaxation at end of W-part step %d',i);
%     return;    
%  end
% 
% end
% pp=pp+1;
% engy(pp) = energy(data);%norm(energy(data)-engyPred)/sqrt(N);
% errAll(pp) = norm(data-dataExact)/sqrt(N);
% %-----------------------------------------------------------
% %errorPred = errorLast;
% %errorLast = engy(pp);
% end
% 
% for ss=2:NGridStep % ---------------------------------------------begin refining the grid
%     
% pold = p;    
% p = 2*p-1;
% 
% error=zeros(1,1);
% 
% Jac = zeros(p,N);
% Jac(1:p,1:N) = Jacobian(1:p,1:N,ss);
% Jac;
% 
% errRelax = zeros(mu2,1);
% fftRelax = zeros(mu2,1);
% 
% fprintf('Begin refining relaxations\n');
% %-------------------------------------------------
% % Cycle begins
% %-------------------------------------------------
% for step=1:mu2   %relaxations
%     
% %dataPred = data;
% %engyPred = energy(data);
% data = double(partRelaxNosymGraphs(data,Jac,NGridStep-ss));
% 
% if (norm(data)<=eps) 
%     data
%     fprintf('Problem encountered during relaxation at level %d step %d',ss,step);
%     return;    
% end
% 
% 
% %errorPred = errorLast;
% %errorLast = engy(pp);
% 
% end %---------------------------------------------for cycle
% t1=etime(clock,t0);
% 
% pp=pp+1
% engy(pp) = energy(data);%norm(energy(data)-engyPred)/sqrt(N);
% errAll(pp) = norm(data-dataExact)/sqrt(N);
% % 
% % if (pictures==1)
% % err = data-dataPred;
% % errRelax(step) = norm(err)/sqrt(N);
% % nnorm = ones(N,1)*errRelax(step);
% % fftRelax = fft(err);
% % norma = ones(N,1)*norm(fftRelax)/sqrt(N);
% % 
% % figure(100);
% % subplot(NGridStep-1,2,2*(NGridStep-ss) + 2);
% % axis([1 N -window window]);
% % hold on;
% % grid on;
% % c = [outer*stt; 1-outer*stt; outer*stt];
% % % plot(1:N,fftRelax(1:N),'.-','color',c);
% % % plot(1:N,feval(normaW,1:N),'-','color',c);
% % plot(1:N,err(1:N),'.-','color',c);
% % plot(1:N,nnorm(1:N),':','color',c);
% % drawnow;
% % end
% % 
% % if (pictures==1)
% % if (ss==NGridStep)
% % figure(10);
% % axis([1 N -0.1*window 0.1*window]);
% % hold on;
% % grid on;
% % c = [outer*stt; 1-outer*stt; outer*stt];
% % %plot(1:N,fftRelax(1:N),'.-','color',c);
% % plot(1:N,err(1:N),'.-','color',c);
% % plot(1:N,nnorm(1:N),'-','color',c);
% % end
% % end
% %  
% end %----------------------------------------------------------end refinement

errorVE(outer) = abs(engy(pp)-engyExact);
errorE = abs(log(errorVE));
errorV(outer) = errAll(pp);
error = abs(log(errorV));

if (outer>1) 
    convergenceE(outer)=errorVE(outer)/errorVE(outer-1); 
    convergence(outer)=errorV(outer)/errorV(outer-1); 
end


if (outer>1) 
    current_error = (engy(pp)-engyExact)/engy0;
else
    current_error = 1;%(engy0-engy(pp))/engy0;    
end 


rrE(outer) = (errorVE(outer)/errorVE(1))^(1/outer);
rr(outer) = (errorV(outer)/errorV(1))^(1/outer);
rho = rrE(outer);
fprintf(fout,'%d  %2.18f\n',N,rho);

sz = size(engy,1);
%figure(500);
set(handles.IterNumber,'String',num2str(outer));
set(handles.CurError,'String',current_error);%num2str(errorV(outer)));
set(handles.CurRho,'String',num2str(rrE(outer)));%(errorV(outer)/error0)^(1/outer)));
guidata(hObject, handles);

axes(handles.axes1)
hold on;
grid on;
ylabel('energy');
plot(1:sz,log(engy),'r.-');

sz = size(errAll,1);
%figure(600);
axes(handles.axes2)
hold on;
grid on;
ylabel('error');
plot(1:sz,log(errAll),'r.-');
drawnow;


outer = outer + 1;
     
end %----------------------------------------------------------end V-cycle
errorVE
rrE
energy(data)
energy(dataExact)
%if (pictures==1)
figure(200);
subplot(1,2,1);
axis;
hold on;
grid on;
title('Convergence factor for E');
if (outer>2)
%plot([outer-1,outer],[convergenceE(outer-1),convergenceE(outer)],'b.-');
%plot([outer-1,outer],[log(engy(outer-1)),log(engy(outer))],'b.-');
plot(N,rrE(outer-1),'b.');
end

subplot(1,2,2);
axis;
hold on;
grid on;
title('Convergence factor for the error');
   if (outer>1)
   %plot([outer-1,outer],[log(errorV(outer-1)),log(errorV(outer))],'r.-');
   %plot([outer-1,outer],[convergence(outer-1),convergence(outer)],'r.-');
   else
   plot([0,1],[error0,errorV(1)],'r.-');    
   end    
plot(N,rr(outer-1),'b.');   
drawnow;
%end

% convergenceV'
 cycles_taken = outer-1
 
 fprintf(fout,'# cycles taken = %d\n',outer-1);
 fprintf(fout,'engy = %2.18f\n',engy);
 fprintf(fout,'errAll = %2.18f\n',errAll);
 fprintf(fout,'errorV = %2.18f\n',errorV);
 fprintf(fout,'error0= %2.18f\n',error0);
 fprintf(fout,'RelaxTotal = %2.3f\n',RelaxTotal);
% rho = errorVE(cycles_taken)/errorE0
% fprintf(fout,'rho = errorV(Ncycles)/error0 = %2.18f\n', rho);
% rho = rho^(1/cycles_taken)
% fprintf(fout,'rho = rho^(1/Ncycles)=%2.18f\n',rho);

%rho = rho^(1/RelaxTotal)

guidata(hObject, handles);
sz = size(engy,1);
%figure(500);
axes(handles.axes1);
cla;
hold on;
grid on;
ylabel('energy');
plot(1:sz,log(engy),'r.-');

sz = size(errAll,1);
%figure(600);
axes(handles.axes2);
cla;
hold on;
grid on;
ylabel('error');
plot(1:sz,log(errAll),'r.-');
 
% errorLast=errAll(sz)
% errorPred=errAll(sz-1)
% rho = errorLast/errorPred
     
%fprintf(foutArray,'%d  %2.18f\n',N,rrE(outer-1));
     
     
fclose(fout);

ds = (mu1+mu2)*(NGridStep-1)+mu0
sz
pts = 1:cycles_taken;%1:ds:sz;
size(engy)
size(engy0)
engy0

figure(101);
hold on;
grid on;
xlabel('# iterations');
ylabel('Convergence factor of energy');
plot(pts,rrE(pts),'r.-');

figure(102);
hold on;
grid on;
xlabel('# iterations');
ylabel('Convergence factor of error');
plot(pts,rr(pts),'b.-');
%semilogy(pts,(errorV(pts)./error0).^(1/pts),'r.-');

rho =rrE(outer-2);
elapsed_time = etime(clock,t0)
rho
fprintf(foutArray,'%d  %2.6f %2.6f %d\n',N,rho,elapsed_time,cycles_taken);

fclose(foutArray);