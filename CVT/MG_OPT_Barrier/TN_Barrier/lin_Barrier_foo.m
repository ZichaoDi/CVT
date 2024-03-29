function [xnew, fnew, gnew, nf1, ierror, alpha3] = ...
    lin_Barrier_foo (p, x, sfun)

global v_low v_up miu
%---------------------------------------------------------
% line search for barrier method
%---------------------------------------------------------
alpha1=0;
ierror = 3;
back   = false;
maxit  = 10;
alpha2 = step1 (x,p,v_low,v_up);
% %%========================================================
% stpmax=alpha2;
% alp=linspace(-10,stpmax,40);
% func=[];
% for i=1:length(alp)
%     vt=x+alp(i)*p;
%     [ftest,gtest,Ftest,Gtest]=feval(sfun,vt);
%     func(i)=Ftest;
%     if (i==length(alp))
%         [minv,dindex]=min(x+alp(i)*p);
%         dis=abs(minv+0.01);
%         if(imag(Ftest)~=0 | Ftest==inf)%|dis<1e-6
%             disp('close to the boundary')
%             func(i)=1e4;
%         end
%     end
% end
% figure(22);%subplot(2,1,1);
% plot(alp,func,'r*-'); hold on;
%%%#######################################################
alpha=alpha2;
gamma = 0.5;
%---------------------------------------------------------
% trial points: x, x+alpha*p;
%---------------------------------------------------------
x1=x+alpha1*p;
x2=x+alpha2*p;
if (min(x2)==-0.01) %#################################
    x2=x+0.8*alpha2*p;
end
format long e
[f1, g1, F1, G1] = feval (sfun, x1);
[f2, g2, F2, G2] = feval (sfun, x2);
F0=F1;
xnew   = x2;
fnew   = F2;
gnew   = G2;
xzero=x1;
fzero=F1;
gzero=G1;
if(F1==inf)
    F1
    pause;
end

%%========================================================
% log-quadratic model: B(x,miu)~t1+t2*alpha+t3+alpha^2-miu*ln(t4-alpha)
%%========================================================
q1=p'*G1;
q0=q1;
q2=p'*G2;
m=-log(1e-5);
%---------------------------------------------------------
% line search
%---------------------------------------------------------
for itcnt = 1:maxit;
    if(itcnt>3)
        back=true;
    end
    if(back == false)

        if(fnew<F0+1e-4*alpha*q0 && abs(p'*gnew)<0.25*abs(q0))  %% Wolfe condition
            ierror = 0;
            alpha3=alpha;
            break;
        else
            
            k3=1/miu*((alpha2-alpha1)/2*(q0+q2)-F2+F0);
            if(k3>=0) %##############################################
                %disp('minimum exists')
                options=optimset('Display','off','MaxFunEvals',500,'TolFun',1e-10);
                v=fsolve(@(x)(exp(x)-exp(-x))/2-x+k3,-m,options);
                
                if(abs(v)<=1e-6)
                    disp('v is too small')
                    v=(-6*k3)^(1/3);
                end
                t4=(alpha2-alpha1)/(1-exp(v));
                t2=q0-miu/t4;
                t3=1/(2*(alpha2-alpha1))*(q2-q0+miu/t4-miu/(t4-(alpha2-alpha1)));
                alpha=(t2-2*t3*t4+sqrt((2*t3*t4+t2)^2+8*t3*miu))/(-4*t3)+alpha1;
            else
                back = true;
            end
        end
        
    else % Back-tracking line search

        if (fnew<F0+1e-4*alpha*q0) %%  Armijo condition
            ierror = 0;
            alpha3=alpha;
            break;
        end
        alpha=gamma*alpha;
        
    end
    
    %-------------------------------------------
    % AFTER "break"
    %-------------------------------------------
    x4= x + alpha*p;
    [f4, g4, F4, G4] = feval (sfun, x4);
    q4=p'*G4;
    %%========================================== update x1 and  x2
    if(q4>=0) % replace q2, etc., with q4, etc.
        x2=x4;
        alpha2=alpha;
        F2 = F4;
        G2 = G4;
        q2 = p'*G2;
        xnew=x2;
        fnew=F2;
        gnew=G2;
    else % replace q1, etc., with q4, etc.
        x1=x4;
        alpha1=alpha;
        F1 = F4;
        G1 = G4;
        q1 = p'*G1;
        xnew=x1;
        fnew=F1;
        gnew=G1;
    end
    
end
if (ierror == 3);
    alpha3 = 0;
    xnew=xzero;
    fnew=fzero;
    gnew=gzero;
end;
nf1 = itcnt;
% plot(alpha3,fnew,'bo');
% hold off; %pause;
