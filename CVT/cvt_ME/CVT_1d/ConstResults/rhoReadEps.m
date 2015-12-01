function z = rhoRead
global density;

a1 = zeros(5,2);
%a2 = zeros(5,2);

a1 = load('NrhoTableEps.txt'); 
% a2 = load('NrhoTable1.txt');
% a3 = load('NrhoTable1cyc.txt');
% a4 = load('rhoSimple.txt');

sort(a1,1)

figure;
hold on;
grid on;
axis([1 600 0 1])
xlabel('Number of generators');
%ylabel('\rho=((x_{n+1}-x_{n})/(x_{1}-x_{0}))^{1/n}');
%ylabel('\rho=(e_{n}/e_{0})^{1/n}');
ylabel('\rho=(x_{n+1}-x_{n})/(x_{n}-x_{n-1})');

plot(a1(:,1),a1(:,2),'ro-');%,a2(:,1),a2(:,2),'ko-',a3(:,1),a3(:,2),'go-',a4(:,1),a4(:,2),'bo-');
%legend('MG C=5 rho=1','MG C=5 rho=1+0.1x','MG C=1 rho=1+0.1x','Gauss-Seidel');
%legend('GSmgPart','GS');
title(['density(x)=',density]);