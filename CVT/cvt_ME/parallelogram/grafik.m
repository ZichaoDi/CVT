
a = load('rho_nonlin_log.txt');
f = load('rho_nonlin.txt');
b = load('rho_lin.txt');
%c = load('rhoDiff.txt');

figure(3);
hold on;
grid on;
xlabel('N = number of grid points');
ylabel('\rho = convergence factor');
axis([0 4500 0.1 1])
plot(b(:,1),b(:,2),'o-',f(:,1),f(:,2),'x-',a(:,1),a(:,2),'.-');%,c(:,1),c(:,2),'o-');
legend('MG: \rho=1','MG: \rho=1+x+0.1*x^2','MG: \rho=2-log(x^2+y^2)')
%plot(b(:,1),b(:,2),'o-');


