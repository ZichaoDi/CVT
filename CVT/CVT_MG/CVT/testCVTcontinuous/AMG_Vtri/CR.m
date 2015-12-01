%%% Test coarsing by Compatible Relaxation
global partial part gap
% N=7;
% h=1/(N+1);
% H = [-delsq(numgrid('S',N+2))/h^2];
% f_h=zeros(N^2,1);
load GS 
load Hess
for t=1:5
H=Hess{t};
f_h=GS{t};
N=length(f_h);
D = diag(diag(H));
L = -tril(H,-1);
U = -triu(H,1);
 
miter=1000;
vs=H\f_h;
%plot(vs)
partial=N;
part=0;
pert=[zeros(part,1);1e-3*[part+1:N]'];
% pert(3+[0:1:6]*7)=0;
% pert(4+[0:1:6]*7)=0;
iteration=[];
convergence=[];
for i=0:20
gap=i;
pert=[zeros(part,1);1e-3*[part+1:N]'];         
pert(1:gap:partial)=0;
x=vs+pert;
[v,iter,conv]=Gauss_Seidel(D,L,U,x,f_h,miter);
% format short
% iter
% conv 
if(i==1)
    conv=0;
end
iteration(i+1)=iter;
convergence(i+1)=conv; 
end
save iteration iteration;
save convergence convergence;
subplot(5,1,t)
%semilogy([1:20],convergence,'r.-')
ind=[0,2:20];
plot([0,2:20] ,convergence(ind+1),'r.-')
pause;
end
