function graph_table
A=load('tem.txt');
%figure(1);

subplot(1,3,1);hold on;
semilogy(A(1:9,1),A(1:9,2),'g*-');%,A(6:9,1),A(10:18,2),'b.-');%,A(19:end,1),A(19:end,2),'g.-');
axis square;
axis([0 A(9,1) 0 1000]);
xlabel('# of generators');
ylabel('number of cycles');

subplot(1,3,2);hold on;
plot(A(1:9,1),A(1:9,3),'g*-');%,A(7:11,1),A(7:11,3),'b.-');%,A(19:end,1),A(19:end,2),'g.-');
axis square;
axis([0 A(9,1) 0 56000]);
%title('red accuracy:norm(f-exactf)<=1e-11;blue accuracy:norm(f-exactf)<=1e-8;green accuracy:gradient value<=1e-6');
xlabel('# of generators');
ylabel('time(sec)');
%title({' Multigrid';' Red-Star: Multilevel\Lloyd';' Blue-Dot:MG/OPT';' uniform density'},'Fontsize',12);

subplot(1,3,3);hold on;
plot(A(1:9,1),A(1:9,4),'g*-');%,A(7:11,1),A(7:11,4),'b.-');%,A(19:end,1),A(19:end,2),'g.-');
axis square;
axis([0 A(9,1) 0 1]);

xlabel('# of generators');
ylabel('Convergence factor');
