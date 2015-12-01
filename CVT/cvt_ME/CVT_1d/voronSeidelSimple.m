clear all;
clc;
warning off;

global density;
global rmax;
global Nsample;
global epsilon;

format long;
t0=clock;
%N = input('Input the number of generators');
N=513;
fid = fopen('data513.txt');
%fex = fopen('data17exact01x.txt');
Ninit = N;
%eps = input('Input eps=approximation parameter');
eps = 1e-12;
epsilon=0.001;
param = 0.01;
Nsample=0;
x=0:epsilon:1;
y=r(x);
rmax=max(y);
mu = 2; %number of relaxations
window = 0.3;
bigpicture = 0;
pictures = 0;
choice = 1; %1=>linear Gauss-Seidel; 2=> nonlinear Jacobi; 3=> nonlinear Gauss-Seidel 
pp=0;

error0 = 0;
ss=1;
error = 1;
data  = zeros(N,1);
z = zeros(N,1);
nn = ones(N,1);
for i=1:N
    nn(i)=i;
end    

if (bigpicture==1)
 figure(100);
 p2=plot(data,z,'bx','EraseMode','xor','MarkerSize',10);  
end

f(ss)=figure('position',[100, 100, 800, 500],'resize','on','units','normalized');
uicontrol(f(ss),'style','text','foregroundcolor','blue','string','DENSITY FUNCTION','position',[540,475,200,20]);
u1=uicontrol(f(ss),'style','edit','position',[580,450,120,20],'string',density);
uicontrol(f(ss),'style','text','foregroundcolor','blue','string','NUMBER OF GENERATORS','position',[540,425,200,20]);
u2=uicontrol(f(ss),'style','edit','position',[580,400,120,20],'string',N);
uicontrol(f(ss),'style','text','foregroundcolor','blue','string','NUMBER OF SAMPLE POINTS','position',[540,375,200,20]);
u3=uicontrol(f(ss),'style','edit','position',[580,350,120,20],'string',0);
uicontrol(f(ss),'style','text','foregroundcolor','blue','string','STEP NUMBER','position',[540,325,200,20]);
u4=uicontrol(f(ss),'style','edit','position',[580,300,120,20],'string','0');
uicontrol(f(ss),'style','text','foregroundcolor','blue','string','INITIAL ERROR','position',[540,275,200,20]);
u5=uicontrol(f(ss),'style','edit','position',[580,250,120,20],'string','n/a');
uicontrol(f(ss),'style','text','foregroundcolor','blue','string','CURRENT ERROR','position',[540,225,200,20]);
u6=uicontrol(f(ss),'style','edit','position',[580,200,120,20],'string','n/a');
uicontrol(f(ss),'style','text','foregroundcolor','blue','string','METHOD USED','position',[540,175,200,20]);
u7=uicontrol(f(ss),'style','edit','position',[580,150,120,20],'string','n/a');
uicontrol(f(ss),'style','text','foregroundcolor','blue','string','TIME ELAPSED (sec)','position',[540,125,200,20]);
u8=uicontrol(f(ss),'style','edit','position',[580,100,120,20],'string','0');
u9=uicontrol(f(ss),'position',[580,70,120,20],'string','STOP','callback','check=1;');
u10=uicontrol(f(ss),'position',[580,30,120,20],'string','EXIT','callback','clear all; close;');


if (choice==1)
    set(u7,'string','Linear GS');    
end

if (choice==2)
    set(u7,'string','Nonlinear Jacobi');    
end

if (choice==3)
    set(u7,'string','Nonlinear GS');    
end

if (pictures==1)
subplot(2,3,1);
subplot(2,3,2);
hold on;
subplot(2,3,4);
grid on;
hold on;
subplot(2,3,5);
grid on;
hold on;

drawnow;

subplot(2,3,1);
p1=plot(data,z,'bx','EraseMode','xor','MarkerSize',10);  
end

%--------------------------------------
% Cycle begins
%--------------------------------------
while (ss<=mu)%&(error>eps)

    
if (ss==1) %first outer loop iteration => random initialization   
 data = zeros(N,1); 
 dataExact = zeros(N,1);
 data = fscanf(fid,'%f')
 %dataExact = fscanf(fex,'%f')
  
  for k=1:N
     %data(k)=initialize(x);
     %data(k)=(2*k-1)/(2*N);
     dataExact(k)=(2*k-1)/(2*N);
 end    
% data=sort(data)

fclose(fid);
%fclose(fex);

error0 = norm(data - dataExact)/sqrt(N);
 Nsample;
 set(u3,'string',Nsample);
 save initial.dat data -ascii;
end %other iterations => initial guess given by previous iteration

set(u2,'string',N);
set(u4,'string',ss);

data';
dataExact';
T=zeros(N,1);

if (pictures==1)
figure(f(1));
subplot(2,3,1);
hold on;
title('Voronoi tesselation');
y=0;
plot(x,y,'k-');
plot(dataExact,z,'r.','MarkerSize',10);  
set(p1,'XData',data,'YData',z); %draw original distribution
        
subplot(2,3,2);
hold on;
grid on;
axis([1 N -window window]);
title('Coarse relaxation error: x_{rel}(step) - x_{ex}');
end

errRelax = zeros(mu,1);
L = zeros(N);
v = zeros(1,N);
v(1) = 0.25;
v(N) = 0.25;
L = 0.5*diag(ones(1,N)) + 0.25*diag(ones(1,N-1),1) + 0.25*diag(ones(1,N-1),-1) - diag(v);
ff = zeros(N,1);
ff(N) = -0.5;

st = 1/mu; 
fprintf('Begin coarsening relaxations\n');
%--------------------------------------relaxation

T=zeros(N,1);
T = data; %calcT(data)

if (choice==1)
 data = GaussSeidel(L-eye(N),ff,T);
elseif (choice==2)
 data = JacobiRelaxation(T);
else 
 data = relaxation(T);
end


 pp=pp+1;
 engy(pp) = double(energy(data));
 errAll(pp) = norm(data-dataExact)/sqrt(N);
 
if (ss==(mu-1))
    errorPred = norm(data-T)/sqrt(N);
end    
if (ss==mu)
    errorLast = norm(data-T)/sqrt(N);
end
errRelax(ss) = norm(data - dataExact)/sqrt(N);
c = [ss*st; 1-ss*st; ss*st];
%plot(1:N,data(1:N)-dataExact(1:N),'.-','color',c);
fftRelax = fft(data-dataExact);
norma = ones(N,1)*norm(fftRelax)/sqrt(N);

if (pictures==1)
plot(1:N,fftRelax(1:N),'.-','color',c);
plot(1:N,norma(1:N),':','color',c);
drawnow;
end


% ------------------------------------------end relaxation  

discr(ss)=norm(data-dataExact,2)/sqrt(N);
error = discr(ss);
if (ss==1)
 set(u5,'string',error);
else 
 set(u6,'string',error);
end
errorT = abs(log(discr));
if (ss>1) 
    convergenceT(ss)=errorT(ss)/errorT(ss-1); 
end

if (pictures==1)
figure(f(1));
subplot(2,3,4);
axis;
hold on;
grid on;
title('||log(errorT_{new})/log(errorT_{old})||');
if (ss>2)
plot([ss-1,ss],[convergenceT(ss-1),convergenceT(ss)],'b.-');
end

figure(f(1));
subplot(2,3,5);
axis;
hold on;
grid on;
title('||errorT_{new}||');
if (ss>1)
plot([ss-1,ss],[discr(ss-1),discr(ss)],'r.-');
else
plot([0,1],[error0,discr(1)],'r.-');    
end

end

t1=etime(clock,t0);

if (bigpicture==1)
figure(100);
axis;
hold on;
title('Voronoi tesselation');
y=0;
plot(x,y,'k-');
plot(dataExact,z,'r.','MarkerSize',10);  
set(p2,'XData',data,'YData',z); 
end

ss = ss+1;
drawnow;
end 
%--------------------------------------
% Cycle ends
%--------------------------------------

if (error<=eps)
    set(u8,'string','eps reached');
else
    set(u8,'string','Max#iter reached');
end

convergenceT'

% convergenceV=[ 0;
%    1.32597259401087;
%    1.23842396667874;
%    1.19237849522713;
%    1.16083682659916;
%    1.13761941422842];
% 
% errorV =[0.07836992244201;
%    0.01146981027416;
%    0.00267315872196;
%    0.00065097720318;
%    0.00015869540783;
%    0.00003885752978;
%    0.00000960508799];
% 
% convergenceVn = [0;
%    1.28108249045879;
%    1.19862870460929;
%    1.16201648928044;
%    1.13890708613362;
%    1.12195222296416];
% 
% errorVn = [0.07836992244201;
%    0.01853143197275;
%    0.00604016109946;
%    0.00218927876360;
%    0.00081168212179;
%    0.00030204927136;
%    0.00011241271952];
% 
% convergenceVm = [0;
%    1.27074982169780;
%    1.20275827924232;
%    1.16256654856612;
%    1.12602297038567;
%    1.08249512301383];
% 
% errorVm = [0.07836992244201;
%    0.01489911493519;
%    0.00477028134047;
%    0.00161379946923;
%    0.00056746529945;
%    0.00022123870070;
%    0.00011049177898];
%    
%    
%    
% conv(1) = log(discr(15))/log(error0);
% convergenceV(1) = 1.75470700619737;
% convergenceVn(1) = 1.56629751513110;
% convergenceVm(1) = 1.65197682003845;
% 
% figure(15);
% title('Convergence rate of linear GS(blue) vs. V-cycles(red) and FullyNonlinV-cycles(magenta)');
% xlabel('Number of relaxations');
% ylabel('||log(error(n+15))/log(error(n))||');
% hold on;
% grid on;
% sz = mu/15;
% for i=2:sz 
%  conv(i) = log(discr(15*i))/log(discr(15*(i-1)));   
%  plot([15*(i-1),15*(i)],[conv(i-1),conv(i)],'b.-');
%  plot([15*(i-1),15*(i)],[convergenceV(i-1),convergenceV(i)],'r.-');
%  plot([15*(i-1),15*(i)],[convergenceVm(i-1),convergenceVm(i)],'m.-');
% end
% 
% figure(16);
% title('Error of linear GS(blue) vs. V-cycles(red) and FullyNonlinV-cycles(magenta)');
% xlabel('Number of relaxations');
% ylabel('||error(n)||');
% hold on;
% grid on;
% sz = mu/15;
% 
% plot([0,15],[error0,discr(15)],'b.-');
% for i=2:sz 
%  plot([15*(i-1),15*(i)],[discr(15*(i-1)),discr(15*i)],'b.-');
% end
% for i=2:(sz+1)
%  plot([15*(i-2),15*(i-1)],[errorV(i-1),errorV(i)],'r.-');
%  plot([15*(i-2),15*(i-1)],[errorVm(i-1),errorVm(i)],'m.-');
% end
% 
error0
discr
rho = discr(mu)/error0
%rho = errorLast/errorPred;
rho = rho^(1/mu)
fout = fopen('rhoSimple.txt','a');
fprintf(fout,'%d  %2.18f\n',N,rho);
fclose(fout);