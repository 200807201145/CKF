function [tgt, trkrs, fc, mse_fc, nees_fc] = main(nstep, ntrkr, q_c, r)
% clear
% clc
% nstep = 100;
% ntrkr = 4;
% q_c = 1;
% r = 1;

% initial target
tgt = init_tgt(nstep, q_c);
% update target
for i = 1:nstep
    tgt = upd_tgt(i, tgt);
end
% initial trackers
trkrs = [];
for i = 1:ntrkr
    trkr = init_trkr(i, nstep, r);
    if i == 1
        trkrs = trkr;
    else
        trkrs = [trkrs, trkr];
    end
    clear trkr
end
% initial fusion center
fc = init_fc(nstep);
% main loop
for i = 1:nstep
    sta_curr = tgt.sta_hst(i, :);
    sta_curr = sta_curr';
    % update measurement
    for j = 1:ntrkr
        trkr = trkrs(j);
        trkr = upd_meas(i, sta_curr, trkr);
        trkrs(j) = trkr;
        clear trkr
    end
    % centralized Kalman filter
    fc = ckf(i, tgt, trkrs, fc);
end
%% calculate mean square error (MSE)
% calculate mse_fc
mse_fc = zeros(length(fc.step_hst), 1);
for i = 1 : length(fc.step_hst)
    mse_fc(i) = (tgt.sta_hst(fc.step_hst(i), :) - fc.m_hst{fc.step_hst(i) } ) * (tgt.sta_hst(fc.step_hst(i), :) - fc.m_hst{fc.step_hst(i) } )';
end
%% calculate normalized (state) estimation error squared (NEES)
% calculate nees_fc
nees_fc = zeros(length(fc.step_hst), 1);
for i = 1:length(fc.step_hst)
    nees_fc(i) = (tgt.sta_hst(fc.step_hst(i), :) - fc.m_hst{fc.step_hst(i) } ) * inv(fc.P_hst{fc.step_hst(i) } ) * (tgt.sta_hst(fc.step_hst(i), :) - fc.m_hst{fc.step_hst(i) } )';
end