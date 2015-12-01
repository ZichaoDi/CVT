rand('state',10);
x = rand(100,2);
st_op=0;
centroid_x=[];centroid_y=[];
while(st_op==0),
    j=j+1;
[v,c]=voronoin(x)
voronoi(x(:,1),x(:,2))
hold on;

% for i = 1:length(c) 
%     disp(c{i})
% end

for i = 1:length(x)
    
    
    p_x=v(c{i},1);
    p_y=v(c{i},2);
    p_x = [p_x' p_x(1)];
    p_y = [p_y' p_y(1)];
     text(x(i,1),x(i,2),num2str(i));
    area=polyarea ( p_x, p_y );
      sum1=0;sum2=0;
      for j=1:length(c{i})
%           p_x(length(c{i})+1)=p_x(1);
%           p_y(length(c{i})+1)=p_y(1);
        sum1=sum1+(p_x(j+1)+p_x(j))*(p_x(j)*p_y(j+1)-p_x(j+1)*p_y(j));
        sum2=sum2+(p_y(j+1)+p_y(j))*(p_x(j)*p_y(j+1)-p_x(j+1)*p_y(j));
      end
%      sum1=sum1+(p_x(1)+p_x(length(c{i})))*(p_x(length(c{i}))*p_y(1)-p_x(1)*p_y(length(c{i})));
%      sum2=sum2+(p_y(1)+p_y(length(c{i})))*(p_x(length(c{i}))*p_y(1)-p_x(1)*p_y(length(c{i})));
    centroid_x(i)=abs(sum1)/(6*area)
    centroid_y(i)=abs(sum2)/(6*area)
%     if (centroid_x<0) | (centroid_y<0)
%         i
%         for j=1: length(c{i})
%             text(p_x(j),p_y(j),num2str(j));
%         end
%         sum1
%         sum2
%         area   
%         %if (i>10) return; end
%     end
%     plot(centroid_x(i),centroid_y(i),'r.','Markersize',5)
%     hold on;

end
newx=[centroid_x;centroid_y];
newx=newx'
%return;
ind = (~isnan(x-newx))&(~isinf(x-newx));
if (norm(x(ind)-newx(ind))/norm(x(ind))<1e-6) fprintf('no movement'); break;
else newx(isnan(newx(:,1)),:)=[]; x=newx
end
end
