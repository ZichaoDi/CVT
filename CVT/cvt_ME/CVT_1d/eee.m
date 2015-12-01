
engy = load('engy129.txt');

size(engy);
xx = 64:8:168;
yy = 1:1:168;
figure(1);
hold on;
subplot(2,2,1);
plot(yy,engy(yy),'b.-');
legend('plot full');
subplot(2,2,2);
plot(xx,engy(xx),'b.-');
legend('plot cycle');
subplot(2,2,3);
semilogy(xx,engy(xx),'b.-');
legend('semilogy');
subplot(2,2,4);
loglog(xx,engy(xx),'b.-');
legend('loglog');
