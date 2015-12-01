function gv = gtims (v, x, g, accrcy, xnorm, sfun)
%%%%%%%%%%%%%%%%%##################
global bounds v_low v_up miu A1 A2 A3   N
%%%%%%%%%%%%%%%%%##################
%---------------------------------------------------------
% compute the product of the Hessian times the vector v;
% store result in the vector gv 
% (finite-difference version)
%---------------------------------------------------------
%%%%%%%%%%%%%%%%%##################
 delta   = sqrt(accrcy)*(1 + xnorm);
%%%%## delta   = sqrt(accrcy)*(1 + xnorm)/norm(v); 
%%%%## if e=0,will have error showing 'NAN'.

% % %        % delta = eps^(1/3);
% % % %         delta = sqrt(h)*(1+xnorm)/norm(v);
 hg      = x + delta*v;
% % %%## if ( (max(hg) > max(v_up)+1) | (min(hg) < min(v_low)-1) )
% % %%##   format short e
% % %%##   more on
% % %%##   disp('GTIMS: hg')
% % %%##   accrcy
% % %%##   delta
% % %%##   nstep = norm(v)
% % %%##   vmat = [v_low hg v_up]
% % %%##   pause
% % %%## end;
% % %%## if ( (max(x) > max(v_up)+1) | (min(x) < min(v_low)-1) )
% % %%##   format short e
% % %%##   more on
% % %%##   disp('GTIMS: v')
% % %%##   vmat = [v_low x v_up]
% % %%##   pause
% % %%## end;
% % %%%%%%%%%%%%%%%%%##################
[f, gv] = feval (sfun, hg);
gv      = (gv - g)/delta;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%exact Hessian for CVT_1D%%%%%%
% H=Hessian1d(x);
% % e=eig(H);
% % figure(1);plot(e);
% % if(~isempty(find(e<0))) pause(1);end
% gv=H*v;

%%%%%----------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%exact Hessian for linear control problem%
% n2 = length(v);
% 
% 
% nm = sqrt(n2);h=1/(nm+1);
% if(nm==N(1))
%     A=A1;
% elseif(nm==N(2))
%     A=A2;
% elseif(nm==N(3))
%     A=A3;
% end
%  p1 = miu*v;
%     p2 = A\v;
%     p3 = A\p2;
%     gv = (p3+p1)*h^2;