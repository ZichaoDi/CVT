function [x, f, g, ierror,varargout] = tn (x, sfun,low,up,maxouter)
%---------------------------------------------------------
% this routine solves:  minimize f(x)
%
% parameters:
%
% ierror <-  error code
%            ( 0 => normal return)
%            ( 2 => more than maxfun evaluations)
%            ( 3 => line search failed (may not be serious)
%            (-1 => error in input parameters)
% x       -> initial estimate of the solution;
% sfun    -> function routine: [f,g] = sfun(x)
% xstar  <-  computed solution.
% g      <-  final value of the gradient
% f      <-  final value of the objective function
%
% This function sets up the parameters for lmqn. They are:
% maxfun - maximum allowable number of function evaluations
% stepmx - maximum allowable step in the linesearch
% accrcy - accuracy of computed function values
% maxit  - maximum number of inner iterations per step
%---------------------------------------------------------
% usage: [xstar, f, g, ierror] = tn (x, sfun)
%---------------------------------------------------------
global tn_max_maxit tn_maxfun miu upper lower extrap row
if (isempty(tn_max_maxit))
    max_maxit=50;
else
    max_maxit = tn_max_maxit;
end;
n      = length(x);
maxit  = 1 + round((n+1)/2);
if (exist('max_maxit'))
    maxit  = min(max_maxit, maxit);
else
    maxit  = min(50, maxit);
end;
if (isempty(tn_maxfun))
    maxfun =150*n;
else
    maxfun = tn_maxfun;
end
stepmx = 10;
accrcy = 100*eps;
%---------------------------------------------------------
%---------------------------------------------------------
%Initialize penalty parameter miu
%---------------------------------------------------------
miu=0;
[f, g] = feval (sfun, x);
if(lower && ~upper)
    q=1./(x-low);
elseif(upper && ~lower)
    q=-1./(up-x);
else
    q=[1./(x-low);-1./(up-x)];
end
miu=norm(g,2)*10/abs(sum(q));
%miu=10/(6.8e-6);
%---------------------------------------------------------
itba=1;
extra=cell(maxouter,maxouter);
row=10;
% load starx287
% starx=starx287;
%starx287=cell(maxouter,1);
oldx=x;
while(itba<=maxouter)
    miu=miu/row;
    xt=x;
    if(extrap)
        if (itba>4)
            order=4;
        else
            order=itba;
        end
        if (itba>2)
            x=xs;%starx{itba};%
            for j=order-1:-1:2
                x=((row^(j-1)-1)*x+extra{itba-1,j-1})/row^(j-1);
            end
            %            xt=starx{15};
            %             for j=order-1:-1:2
            %                 xt=((row^(j-1)-1)*xt+extra{itba-1,j-1})/row^(j-1);
            %             end
        end
        p=x-oldx;
        spe = step1 (oldx,p,low,up);
        x=oldx+spe*p;
%         figure(12);
%         plot(1:length(x),starx{itba}-x,'r.-',1:length(x),starx{itba}-oldx,'go-',1:length(x),starx{itba}-xt ,'b*-');
%         pause;
    end
    %     if(itba==5)
    %         c0=starx{1};
    %         c1=(starx{2}-starx{1})/(miu*row^3-miu*row^4);
    %         c2=(starx{3}-starx{1}-c1*(miu*row^2-miu*row^4))/((miu*row^2-miu*row^4)*(miu*row^2-miu*row^3));
    %         c3=(starx{4}-c0-c1*(miu*row-miu*row^4)-c2*(miu*row-miu*row^4)*(miu*row-miu*row^3))/((miu*row-miu*row^3)*(miu*row-miu*row^4)*(miu*row-miu*row^2));
    %         x=c0+c1.*(miu-miu*row^4)+c2.*(miu-miu*row^4)*(miu-miu*row^3)+c3.*(miu-miu*row^4)*(miu-miu*row^3)*(miu-miu*row^2);
    %     elseif(itba>5)
    %                 x=c0+c1.*(miu-miu*row^(itba-1))+c2.*(miu-miu*row^(itba-1))*(miu-miu*row^(itba-2))+c3.*(miu-miu*row^(itba-1))*(miu-miu*row^(itba-2))*(miu-miu*row^(itba-3));
    %     end
    
    %%%%##################################################################
    
    [x, f, g, F, G, ierror,ipivot, eig_val] = lmqn (x, sfun,low,up, maxit, maxfun, stepmx, accrcy,miu);
    %starx287{itba}=x;
    oldx=x;
    %%===================== Apply Extrapolation================================
    % if(extrap)
    %         if (itba>4)
    %             order=4;
    %         else
    %             order=itba;
    %         end
    %         extra{itba,1}=x;
    %         if(itba==2)
    %             extra{2,2}=(row.*extra{2,1}-extra{1,1})/(row-1);
    %             x=extra{2,2};
    %         elseif(itba>2)
    %             for j=2:order
    %                 extra{itba,j}=(row^(j-1).*extra{itba,j-1}-extra{itba-1,j-1})/(row^(j-1)-1);
    %             end
    %             x=extra{itba,order};
    %         end
    %
    %         infd=find(x<=low);
    %         x(infd)=low(infd)*0.99999;
    %
    % end
    if(extrap)
        extra{itba,1}=x;
        if(itba==2)
            extra{2,2}=(row.*extra{2,1}-extra{1,1})/(row-1);
            xs=extra{2,2};
        elseif(itba>2)
            for j=2:order
                extra{itba,j}=(row^(j-1).*extra{itba,j-1}-extra{itba-1,j-1})/(row^(j-1)-1);
            end
            xs=extra{itba,order};
        else
            xs=x;
        end
%         figure(13);
%         plot(1:length(x),starx{8}-xs,'r.-',1:length(x),starx{8}-oldx,'b*-')
%         pause;
    end
    %%=========================================================================
    conv = cnvtem_outer(x,low,up,sfun);
    g = ztime (g, ipivot);
    gnorm = norm(g,inf);
    fprintf('f=%.8e   gnorm=%.1e    penalty=%.1e   it=%i\n',f, gnorm, miu ,itba);
    if(conv)
        disp('outer iteration converges')
        break;
    end
    itba=itba+1;
end
%save starx287 starx287;
if (nargout == 5)
    varargout{1} = eig_val;
end
