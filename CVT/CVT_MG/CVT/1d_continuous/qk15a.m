function int_est = qk15a(myfun,a,b)
%---------------------------------------------------------------
% Estimate integral using a 15-point Gauss-Kronrod rule
% Adapted from a Fortran procedure written by
%   Robert Piessens (Appl. Math. & Progr. Div., K.U. Leuven)
%   Elise de Doncker (Appl. Math. & Progr. Div., K.U. Leuven)
% This function estimates
%   integral of f over (a,b)
% Parameters
%       myfun   - function defining the integrand
%       a       - lower limit of integration
%       b       - upper limit of integration
%       int_est - approximation to the integral
%---------------------------------------------------------------

% Define abscissae and weights for interval [0,1]
%
%    xgk    - abscissae of the 15-point Kronrod rule
%    wgk    - weights of the 15-point Kronrod rule

xgk = [...
       0.9914553711208126e+00
       0.9491079123427585e+00
       0.8648644233597691e+00
       0.7415311855993944e+00
       0.5860872354676911e+00
       0.4058451513773972e+00
       0.2077849550078985e+00
       0.0e+00];

wgk = [...
       0.2293532201052922e-01
       0.6309209262997855e-01
       0.1047900103222502e+00
       0.1406532597155259e+00
       0.1690047266392679e+00
       0.1903505780647854e+00
       0.2044329400752989e+00
       0.2094821410847278e+00];

% Scale weights and abscissae to interval [a,b]
   
xg  = [-xgk 
       xgk(7:-1:1)];
wg  = [wgk
       wgk(7:-1:1)];

xg = a + 0.5*(b-a)*(1+xg);
wg = 0.5*(b-a)*wg;

int_est = 0;
for i=1:length(xg);
    fval = feval(myfun,xg(i));
    int_est = int_est + wg(i)*fval;
end
