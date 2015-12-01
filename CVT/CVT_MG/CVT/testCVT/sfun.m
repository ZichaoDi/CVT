function [f,g]=sfun(z)
global  mminx mmaxx mminy mmaxy  globalN VXY SVXY EVXY

ntot=length(z)/2;
xy=reshape(z,2,ntot);
% test1 = find(xy(1,:)<mminx | xy(1,:)>mmaxx);
% test2 = find(xy(2,:)<mminy | xy(2,:)>mmaxy);
% if (length(test1)>0 | length(test2)>0) xy(1,test1), xy(2,test2), 
%     fprintf('out of bound'); 
% end
figure(3);voronoi(xy(1,:),xy(2,:));
for i=1:ntot
    text(xy(1,i),xy(2,i),num2str(i));
end
pause(1);
dvec = dindex_vecTN(xy,VXY);
f=energy_newTN(dvec,xy,VXY,SVXY,EVXY);
g=gradient_energy_newTN(dvec,xy,VXY,SVXY,EVXY);
%-------------------------------------------------
% USE FINITE DIFFERENCING FOR THE GRADIENT
%
% m = length(xy);
% h = eps^(1/3);
% g = 0*xy;
% for i=1:m;
%     xyh = xy;
%     xyh(1,i) = xyh(1,i) + h;
%     f2 = energy_continuousTN(xyh);
%     xyh = xy;
%     xyh(1,i) = xyh(1,i) - h;
%     f1 = energy_continuousTN(xyh);
%     gi = (f2-f1)/(2*h);
%     g(1,i) = gi;
%
%     xyh = xy;
%     xyh(2,i) = xyh(2,i) + h;
%     f2 = energy_continuousTN(xyh);
%     xyh = xy;
%     xyh(2,i) = xyh(2,i) - h;
%     f1 = energy_continuousTN(xyh);
%     gi = (f2-f1)/(2*h);
%     g(2,i) = gi;
% end;
% g = g(:);

%-------------------------------------------------

%##################################################
% if (length(xy) == 107);
%     disp('Entering level for n = 107')
%     save xy
% end;
%##################################################
%  test1 = find(xy(1,:)<mminx | xy(1,:)>mmaxx);
% test2 = find(xy(2,:)<mminy | xy(2,:)>mmaxy);
%
% if (~isempty(test1))
%    if (n==globalN(1)) for m=1:length(test1)
%             xy(1,test1(m))=XY(1,test1(m));end
%    elseif (n==globalN(2))
%     for m=1:length(test1)
%             xy(1,test1(m))=XY1(1,test1(m));end
%     elseif (n==globalN(3))
%       for m=1:length(test1)
%             xy(1,test1(m))=XY2(1,test1(m));end
%         elseif (n==globalN(4))
%       for m=1:length(test1)
%             xy(1,test1(m))=XY3(1,test1(m));end
%    end
% end
% if( ~isempty(test2))
%
%     %XY(1,test1); XY(2,test2); fprintf('out of bound\n');
%     if (n==globalN(1))
%
%         for m=1:length(test2)
%             xy(2,test2(m))=XY(2,test2(m));end
%     elseif (n==globalN(2))
%
%         for m=1:length(test2)
%             xy(2,test2(m))=XY1(2,test2(m));end
%     elseif (n==globalN(3))
%
%         for m=1:length(test2)
%             xy(2,test2(m))=XY3(2,test2(m));end
%      elseif (n==globalN(4))
%
%         for m=1:length(test2)
%             xy(2,test2(m))=XY4(2,test2(m));end
%     end
% end
% test1 = find(xy(1,:)<mminx | xy(1,:)>mmaxx);
% test2 = find(xy(2,:)<mminy | xy(2,:)>mmaxy);
%
% if (~isempty(test1) | ~isempty(test2))
%
%    fprintf('out of bound\n');end






%if (length(xy) == 107); f, error('NaN   NaN   NaN'); end;


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