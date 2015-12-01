data = load('rho.txt');
%data2=load('rhoLloyd.txt');

figure;
hold on;
grid on;
axis([0 35000 0.8 1]);
xlabel('N = number of grid points');
ylabel('\rho = convergence factor');
title('Convergence of the smoother (Lloyd iteration) for 1/4 grid pts fixed');
plot(data(:,1),data(:,2),'r.-');
%plot(data2(:,1),data2(:,2),'bo-');