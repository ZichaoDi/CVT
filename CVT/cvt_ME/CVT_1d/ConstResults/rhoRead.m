function z = rhoRead
global density;

a1 = zeros(5,2);
%a2 = zeros(5,2);

a1 = load('NrhoArray11.txt'); 
%a2 = load('NrhoTable1.txt');
%a3 = load('NrhoTable1cyc.txt');
%a3 = load('rhoSimple.txt');

%sort(a1,1)

%ylabel('\rho=((x_{n+1}-x_{n})/(x_{1}-x_{0}))^{1/n}');
%ylabel('\rho=(e_{n}/e_{0})^{1/n}');
%ylabel('\rho=(x_{n+1}-x_{n})/(x_{n}-x_{n-1})');

figure(1);

hold on;
grid on;
xlabel('Number of generators');
ylabel('Convergence factor');
title('Convergence analysis in 1d')
plot(a1(:,1),a1(:,2),'bo-');

figure(2);
hold on;
grid on;
xx = 1:140;
xlabel('Number of generators');
ylabel('time(sec)')
title('Computational time needed to reach \epsilon=10^{-16} accuracy');
plot(xx,xx,'y.');
plot(a1(:,1),a1(:,3),'bo-');

figure(3);
hold on;
grid on;
title('Number of cycles needed to reach \epsilon=10^{-16} accuracy');
ylabel('Number of V(1,0) and V(1,1) cycles, respectively');
xlabel('Number of generators');
plot(a1(:,1),a1(:,4),'bo-');
