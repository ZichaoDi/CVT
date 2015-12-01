function z=isbdry(x,y)

sq1 = 100*sqrt(3)/2;
sq2 = sqrt(3);
eps = 1e-12;
if (y==0)|(abs(y-sq1-sq2*x)<eps)|(abs(y-sq1+sq2*x)<eps)
    z = 0;
else
    z = 1; 
end    