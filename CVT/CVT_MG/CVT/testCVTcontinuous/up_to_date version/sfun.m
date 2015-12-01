function [f,g]=sfun(z)
global  mminx mmaxx mminy mmaxy  globalN VXY SVXY EVXY
global ntot current_n N

ntot=length(z)/2;
xy=reshape(z,2,ntot);
% test1 = find(xy(1,:)<mminx | xy(1,:)>mmaxx);
% test2 = find(xy(2,:)<mminy | xy(2,:)>mmaxy);
% if (length(test1)>0 | length(test2)>0) 
%     xy(1,test1) 
%     test1
%     xy(2,test2) 
%     test2
%     fprintf('out of bound'); 
% end
% cla;
if(ntot==5)
figure(3);voronoi(xy(1,:),xy(2,:));pause(1);
end
bd1(1,:) = 2*[-1 2 2 -1 -1 ]*mmaxx;
bd1(2,:) = 2*[-1 -1 2 2 -1]*mmaxy;
% bd1(1,:)=bd1(1,:)/10;
% bd1(2,:)=bd1(2,:)/10;
% bd1(1,:) = 200*[-mmaxx 2*mmaxx 2*mmaxx -mmaxx -mmaxx ];
% bd1(2,:) = 200*[-mmaxy -mmaxy 2*mmaxy 2*mmaxy -mmaxy];
xydata= [xy  bd1];
% figure(6);voronoi(xy(1,:),xy(2,:));pause(1);
% for i=1:ntot+5
%     text(xydata(1,i),xydata(2,i),num2str(i));end
[v,c]=voronoin(xydata');
f=energy(xydata,v,c);
g=gradient_energy(xydata,v,c);
% i=find(current_n==N);
% f=f/4^(i-1);
% g=g/4^(i-1);

%             if (length(xy) == N(1));  figure(2); hold on;
%                        plot(xy(1,:),xy(2,:),'rx','linewidth',2);
%             elseif (length(xy) == N(2)); figure(3); hold on;
%                 plot(xy(1,:),xy(2,:),'bo','linewidth',2);
%              elseif (length(xy) == N(3)); figure(4); hold on;
%                 plot(xy(1,:),xy(2,:),'g*','linewidth',2);
%             elseif (length(xy) == N(4)); figure(5); hold on;
%                 plot(xy(1,:),xy(2,:),'ro','linewidth',2);
%             end
%                        drawnow;