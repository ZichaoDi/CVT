function z = rhoRead
global density;

a1 = zeros(5,2);
a2 = zeros(5,2);

a1 = load('rhoPartV.txt');
a2 = load('rhoSimple.txt');

figure;
hold on;
grid on;
xlabel('Number of generators');
%ylabel('\rho=((x_{n+1}-x_{n})/(x_{1}-x_{0}))^{1/n}');
%ylabel('\rho=(e_{n}/e_{0})^{1/n}');
ylabel('\rho=(x_{n+1}-x_{n})/(x_{n}-x_{n-1})');

plot(a1(:,1),a1(:,2),'r.-',a2(:,1),a2(:,2),'b.-');
%legend('GSmgPart','GS');
title(['density(x)=',density]);