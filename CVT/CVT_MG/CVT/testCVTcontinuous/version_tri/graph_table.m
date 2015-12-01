function graph_table
A=load('A.txt');
figure(1);
subplot(1,3,1);
semilogy(A(1:5,1),A(1:5,2),'r*-',A(6:10,1),A(6:10,2),'b.-',A(11:end,1),A(11:end,2),'g.-');
axis square;
axis([0 A(5,1) 0 max(A(:,2))+5]);
xlabel('# of generators');
ylabel('number of cycles');

subplot(1,3,2);
plot(A(1:5,1),A(1:5,3),'r*-',A(6:10,1),A(6:10,3),'b.-',A(11:end,1),A(11:end,3),'g.-');
axis square;
axis([0 A(5,1) 0 max(A(:,3))]);
%title('red accuracy:norm(f-exactf)<=1e-11;blue accuracy:norm(f-exactf)<=1e-8;green accuracy:gradient value<=1e-6');
xlabel('# of generators');
ylabel('time(sec)');
title({' Red-Star: OPT';' Blue-Dot:MG/OPT';'green dot:lloyd';' uniform density'},'Fontsize',12);


subplot(1,3,3);
plot(A(1:5,1),A(1:5,4),'r*-',A(6:10,1),A(6:10,4),'b.-',A(11:end,1),A(11:end,4),'g.-');
axis square;
axis([0 A(5,1) 0 1]);

xlabel('# of generators');
ylabel('Convergence factor');

