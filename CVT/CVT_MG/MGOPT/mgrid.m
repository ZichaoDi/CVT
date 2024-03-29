function [v, varargout] = mgrid(v0,fnl,res_prob,step_bnd)
%--------------------------------------------------
% Multigrid algorithm (McCormick, pp. 66-67)
%--------------------------------------------------
% Usage: v = mgrid(v0,fnl,res_prob)
%--------------------------------------------------
global current_fnl
global N current_n
global bounds v_low v_up
global GRAPH_N_OLD GRAPH_INDEX_OLD
global Hess_norm_H % norm of coarse-grid Hessian
%##################################################
global vstar lind XYfine current_v
%##################################################
%----------------------------------------------------------------------
% DECIDE WHETHER TO PRINT ASSESSMENT TEST RESULTS
% AND WHETHER TO PAUSE AFTER PRINTING TESTS
%----------------------------------------------------------------------
assess_print = 0; % 0=false, 1=true
assess_pause = 0; % 0=false, 1=true
%----------------------------------------------------------------------
% update MULTIGRID GRAPH
%----------------------------------------------------------------------
h_MG_graph = findobj('Tag', 'multigrid_graph');
figure(h_MG_graph);

GRAPH_N_NEW = current_n;
IND_OLD = find(N==GRAPH_N_OLD);
IND_NEW = find(N==GRAPH_N_NEW);
plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW]);
plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW],'x');
GRAPH_N_OLD = current_n;
GRAPH_INDEX_OLD = GRAPH_INDEX_OLD+1;

%--------------------------------------------------
n = current_n;
alpha = 0; % added to try to deal with error message
%--------------------------------------------------
% Determine update/downdate constant
if (n>min(N));
    global_setup(n,v0);
    v_test_h = 0*v0;
    v_test_h(1) = 1;
    v_D1     = downdate(v_test_h,1); % downdated test vector (first column of D)
    v_test_H = 0*v_D1;
    v_test_H(1) = 1;
    v_U1     = update(v_test_H,1);   % updated test vector (first column of U)
    IhH_con = v_U1(1)/v_D1(1);
    if (assess_print)
        fprintf('--------------------------------------------------------------\n');
        fprintf('update/downdate Constant: %d\n', IhH_con);
        fprintf('--------------------------------------------------------------\n');
        if (assess_pause); disp('Hit any key to continue'); pause; end;
    end;
end;
%--------------------------------------------------
current_fnl = fnl;
%save current_fnl current_fnl
j           = find(N==current_n);
nmin        = N(end);
if (bounds);
    jj=length(v0);
    [v_low,v_up] = set_bounds(jj);
end;
%--------------------------------------------------
if (res_prob);
    myfun = 'sfun_mg';
else
    myfun = 'sfun';
end;
%--------------------------------------------------
T  = ['In  mgrid: n = ' num2str(current_n)];
disp(T)
%--------------------------------------------------
if (res_prob);
    [F_on_entry, G_on_entry] = sfun_mg(v0);
else
    [F_on_entry, G_on_entry] = sfun(v0);
end;
npts = numel(v0) - 1;
%--------------------------------------------------
%----------------------------------------------------
if (current_n <= nmin);
    %--------------------------------------------------
    % solve (exactly) problem on coarsest grid
    %--------------------------------------------------
    nit_solve = 25;
    %#######################
    %nit_solve = 35;
    %#######################
    if (step_bnd == 0);
        
        if (bounds);
            nit = nit_solve; [v,F,G,ierror]  = tnbcm(v0,myfun,v_low,v_up,nit);
        else
            nit = nit_solve; [v,F,G,ierror]  = tnm  (v0,myfun,nit);
            
        end;
        
    else
        [low1,up1] = get_bnd (v0,step_bnd);
        nit = nit_solve; [v,F,G,ierror]  = tnbcm(v0,myfun,low1,up1,nit);
    end
    %     [ff,gg]=sfun(v);
    %     fprintf('OPT (coarse grid): n = %4i: energy = %d\n',length(v),ff)
else
    %--------------------------------------------------
    % "relax" on current grid
    %--------------------------------------------------
    if (step_bnd == 0);
        
        if (bounds);
            
            nit = 1; [v,F,G,ierror,eig_val]  = tnbcm(v0,myfun,v_low,v_up,nit);
        else
            nit = 1; [v,F,G,ierror,eig_val]  = tnm  (v0,myfun,nit);
        end;
        
    else
        [low1,up1] = get_bnd (v0,step_bnd);
        nit = 1; [v,F,G,ierror,eig_val]  = tnbcm(v0,myfun,low1,up1,nit);
        
    end;
    %     [ff,gg]=sfun(v);
    %     fprintf('AFTER PRE-SMOOTH: n = %4i: energy = %d\n',length(v),ff)
    if (res_prob);
        [F_before_recursion, G_before_recursion] = sfun_mg(v);
        [F_foo, G_before_recursion_reg] = sfun(v);
    else
        [F_before_recursion, G_before_recursion] = sfun(v);
        G_before_recursion_reg = G_before_recursion;
    end;
    
    %--------------------------------------------------
    % Form new "rhs" vector
    %--------------------------------------------------
    
    global_setup(n,v);
    current_v   = downdate(v,3);
    %         figure(13);gen1=reshape(v,2,current_n);gen2=reshape(current_v,2,length(current_v)/2);
    %
    %         plot(gen1(1,:),gen1(2,:),'ro',gen2(1,:),gen2(2,:),'b*')
    %                 for i=1:current_n
    %             text(gen1(1,i),gen1(2,i),num2str(i));
    %         end
    %         pause;
    if (bounds);
        jj = length(current_v);
        [v_low_1,v_up_1] = set_bounds(jj);
        %         figure(112);
        %         plot(current_v(1:2:end),current_v(2:2:end),'ro');
        
        current_v = bound_project(current_v,v_low_1,v_up_1);
        %         hold on; plot(current_v(1:2:end),current_v(2:2:end),'b*');
        %         axis([-50 50 0 90]);
        %         hold off;
        %         pause;
    end;
    [Fv  ,Gv  ] = sfun   (v);
    [Fvmg,Gvmg] = sfun_mg(v);
    dGv         = downdate(Gv,0);
    fnl2        = downdate(fnl,0);
    %%----------------------------------------------------
    test_sep = true;
    j = find(N==current_n);
    if (test_sep)
        %-------------------------------------------------
        % Generate "probe" vector p_h
        %-------------------------------------------------
        % rml randn('state',0);
        % rml p_0h = randn(size(v));
        
        p_0h = 2*(rand(size(v)) - 0.5);
        p_iter_max = 1; % I used "5" instead of "1" here
        p_1h = p_0h;
        for jj = 1:p_iter_max;   % Iterate to accentuate the low "frequencies"
            p_1h = update(downdate(p_1h,0),0);
        end;
        p_h  = p_0h - p_1h;    % This should leave mostly high-frequencies in p_h.
        %------------------------------------------------
        % downdate the probe vector and compute
        % the fine-grid matrix-vector product Ap_h0.
        %------------------------------------------------
        h_diff = sqrt(eps)*norm(p_h);
        [Fvh, Gvh]  = sfun(v + h_diff*p_h);
        Ap_h0 = (Gvh - Gv) / h_diff;
        %------------------------------------------------
        Ap_H = downdate(Ap_h0,0);
        Ap_h = Ap_h0; % RML hack.
        n_Ap_h = norm(Ap_h);
        %-----------------------------------------------
        % Iterate to emphasize the low frequencies.
        % If the Hessian is not separable, then the
        % low frequencies will be large; otherwise
        % they will be small.
        %-----------------------------------------------
        A_iter_max = 1; % RML used "5" here
        for jj = 1:A_iter_max
            Ap_h = update(downdate(Ap_h,0),0);
            Ap_H = downdate(update(Ap_H,0),0);
        end
        %------------------------------------------------
        % Plot the various results
        % In the general case the FFT may not be an
        % appropriate tool to analyze the results.
        %------------------------------------------------
        kkk = numel(eig_val);
        while (kkk > 0 && isempty(eig_val{kkk}))
            kkk = kkk-1;
        end
        if (kkk > 0)
            Hessian_norm = max(abs(eig_val{kkk}));
            sep_denom = norm(p_h) * Hessian_norm;
        else
            sep_denom = n_Ap_h;
        end;
    end;
    %%----------------------------------------------------
    j           = j+1;
    current_n   = N(j);
    %--------------------------------------------------
    n = current_n;
    %--------------------------------------------------
    
    [Fv2 ,Gv2 ] = sfun   (current_v);
    %%----------------------------------------------------
    tau         = Gv2 - dGv;
    fnl2        = fnl2 + tau;
    %--------------------------------------------------
    % Bound step on next-coarser grid
    %--------------------------------------------------
    bnd_1     = norm(fnl2,'inf');
    bnd_2     = norm( Gv2,'inf');
    bnd_3     = norm( dGv,'inf');
    step_bnd1 = 10 * max([bnd_1 bnd_2 bnd_3]);
    %########################################
    % step_bnd1;
    %     step_bnd1 = input('Enter value for step_bnd1:  ')
    no_bounds = 1;  % 1: no extra bound constraint; 0: extra bound constraint
    if (no_bounds);
        step_bnd1 = 0;
        disp(' ')
        disp('#################################')
        disp('### NO EXTRA BOUND CONSTRAINT ###')
        disp('#################################')
        disp(' ')
    end;
    %########################################
    %--------------------------------------------------
    % update solution on current grid (V cycle)
    %--------------------------------------------------
    [e2, pred]  = mgrid(current_v,fnl2,1,step_bnd1);
    
    j           = j-1;
    current_n   = N(j);
    %########################reorder the new adjacency
    e=update(e2,4)-update(current_v,1);%v;
    %##############################################
    %e           = update(e2-current_v,0);
    if (Hess_norm_H > 0)
        sep_denom = norm(p_h) * Hess_norm_H;
        sep_quot = norm(Ap_H) / sep_denom;
        if (assess_print);
            fprintf('--------------------------------------------------------------\n');
            fprintf('SEPARABILITY TEST (nh = %d, using |G_H|) = %f\n', N(j),sep_quot);
        end;
    end
    %--------------------------------------------------
    % Compute approximate Rayleigh quotient.
    %--------------------------------------------------
    kk = numel(eig_val);
    while (kk > 0 && isempty(eig_val{kk}))
        kk = kk-1;
    end
    if (kk > 0)
        Hessian_norm = max(abs(eig_val{kk}));
        Hess_norm_H = Hessian_norm;
        accrcy = 128*eps;
        vnorm  = norm(v, 'inf');
        He = gtims (e, v, G_before_recursion_reg, accrcy, vnorm, @sfun);
        approx_Rayleigh_quot = (dot(He,He)/(Hessian_norm * dot(e,He)));
        if (assess_print);
            fprintf('MESH COMPLEMENTARITY TEST (nh = %d): %f\n',N(j),approx_Rayleigh_quot);
        end;
    else
        if (assess_print);
            fprintf('\n');
            fprintf('MESH COMPLEMENTARITY TEST\n');
            fprintf('  Comparing meshes nh = %d and nH = %d.\n', N(j), N(j+1));
            fprintf('  The test could not be performed because no estimate of the norm\n');
            fprintf('  of the Hessian was available!  This is because modlnp returned\n');
            fprintf('  before the requisite Lanczos information was collected!\n');
        end;
        approx_Rayleigh_quot = -1000; % This is a dummy value to indicate test failure
        Hessian_norm = 0; % This is a dummy value to indicate test failure
        Hess_norm_H = Hessian_norm;
    end
    %----------------------------------------------------------------------
    % update MULTIGRID GRAPH
    %----------------------------------------------------------------------
    figure(findobj('Tag', 'multigrid_graph'));
    GRAPH_N_NEW = current_n;
    IND_OLD = find(N==GRAPH_N_OLD);
    IND_NEW = find(N==GRAPH_N_NEW);
    plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW]);
    plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW],'x');
    GRAPH_N_OLD = current_n;
    GRAPH_INDEX_OLD = GRAPH_INDEX_OLD+1;
    %--------------------------------------------------
    n = current_n;
    %global_setup(n,v0);
    if (bounds);
        jj=length(e);
        [v_low,v_up] = set_bounds(jj);
    end;
    %--------------------------------------------------
    current_fnl = fnl;
    testd       = e'*Gvmg;
    %-------------------------------------------------
    % plot search direction, step to solution
    %-------------------------------------------------
    % load exactEn;
    %     %############################################
    if (current_n==N(1))
        %                 if (n==128); load v128; end;
        %                 if (n== 64); load v64; end;
        %                 if (n== 32); load v32; end;
        %                 if (n== 16); load v16; end;
        load vs55; vstar=vs55;
        %         svstar=sort(vstar);
        %         sv=sort(v);
        %         se=sort(e);
        %         figure(13);
        %         subplot(1,2,1);
        %         plot(e,'r.-'); title('Search direction (fine)')
        %         subplot(1,2,2);
        %         plot(e2-current_v,'b.-'); title('Search direction (coarse)')
        
        tt = linspace(0,1,length(v))'; %tt = tt(2:end-1);
        figure(22);subplot(1,2,1);plot(tt,vstar-v,'b');title('step');subplot(1,2,2);plot(tt,e,'r');title('Direction')
        figure(16); plot(tt,vstar-v,'b',tt,e,'r'); title('Step (blue), Direction (red)')
        
        disp('Hit any key to continue')
        pause
    end
    %     %############################################
    %
    if (testd<0)
        if (bounds)
            alpha0 = stpmax1 (v, e, v_low, v_up);
        else
            alpha0 = 1;
        end;
        [v, Fv, Gv, nf1, alpha, ierror, dfdp] = ...
            lin2 (e, v, Fvmg, alpha0, Gvmg, myfun);
        if (res_prob);
            [F_after_linesearch, G_after_linesearch] = sfun_mg(v);
        else
            [F_after_linesearch, G_after_linesearch] = sfun(v);
        end;
        dfdp = dfdp/npts;
        if (assess_print);
            fprintf('NONLINEARITY TEST (nh = %d, alpha = %8.2e): %8.2e\n',N(j),alpha,dfdp);
        end;
    else
        disp('No descent direction: no step taken')
        v  = v + 0*e;
    end;
    
    if (res_prob);
        [F_after_recursion, G_after_recursion] = sfun_mg(v);
    else
        [F_after_recursion, G_after_recursion] = sfun(v);
    end;
    
    aared = F_before_recursion - F_after_recursion;
    mct_pred   = IhH_con*pred;   % predicted reduction ("raw")
    mct_pred_a = alpha*mct_pred; % predicted reduction ("pro-rated" by alpha)
    mct_act    = aared;          % actual reduction
    mct_err    = abs(mct_act-mct_pred)  /abs(mct_act); % relative error ("raw")
    mct_err_a  = abs(mct_act-mct_pred_a)/abs(mct_act); % relative error ("pro-rated")
    if (assess_print);
        fprintf('MODEL CONSISTENCY TEST: nh = %d\n', N(j));
        fprintf('  Reduction(predicted) (raw/pro-rated): %e / %e\n', mct_pred,mct_pred_a);
        fprintf('  Reduction(actual)                   : %e\n', mct_act);
        fprintf('  Relative error (raw/pro-rated)      : %f / %f\n', mct_err,mct_err_a);
        fprintf('--------------------------------------------------------------\n');
        if (assess_pause); disp('Hit any key to continue'); pause; end;
    end;
    %--------------------------------------------------
    % "relax" on current grid
    %--------------------------------------------------
    disp(T)
    if (step_bnd == 0);
        if (bounds);
            nit = 1; [v,F,G,ierror]  = tnbcm(v,myfun,v_low,v_up,nit);
        else
            nit = 1; [v,F,G,ierror]  = tnm  (v,myfun,nit);
        end;
    else
        [low1,up1] = get_bnd (v,step_bnd);
        nit = 1; [v,F,G,ierror]  = tnbcm(v,myfun,low1,up1,nit);
    end;
    %         [ff,gg]=sfun(v);
    %     fprintf('AFTER POST-SMOOTH: n = %4i: energy = %d\n',length(v),ff)
end

% Compute the actual reduction seen on the current mesh level
% to serve as the predicted reduction on the next finer mesh.
% RML: The scaling by current_n needs to be corrected.
if (res_prob);
    [F_on_exit, G_on_exit] = sfun_mg(v);
else
    [F_on_exit, G_on_exit] = sfun(v);
end;

if (current_n > nmin)
    ared = (F_on_entry - F_on_exit);
else
    ared = (F_on_entry - F_on_exit);
end

if (nargout == 2)
    varargout{1} = ared;
end