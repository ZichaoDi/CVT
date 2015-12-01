function z=isbdry(x,y)

sq2 = sqrt(3);
eps = 1e-6;
abs(y-sq2*x);
abs(y-sq2+sq2*x);
if (y==0)|(abs(y-sq2*x)<eps)|(y==(sq2/2))|(abs(y+sq2-sq2*x)<eps)
    z = 0;
else
    z = 1; 
end    