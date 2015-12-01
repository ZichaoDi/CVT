global maxiter
for i=20:40
   maxiter=i;
   opt_con;
    vs=reshape(v,2,N(1));
    xs=[XY{1},XYbd{1}];
    vs=[vs,XYbd{1}];
    e3=sqrt((xs(1,:)-vs(1,:)).^2+(xs(2,:)-vs(2,:)).^2);
    xtt = xs(1,:);
    ytt = xs(2,:);
    gridDelaunay = delaunay(xtt,ytt);
    figure(122);
    trimesh(gridDelaunay,xtt,ytt,e3);
   % pause;
end