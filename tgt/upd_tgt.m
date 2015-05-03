function tgt = upd_tgt(step_curr, tgt)

%% read data from target
A = tgt.A;
Q = tgt.Q;
sta_hst = tgt.sta_hst;
w_hst = tgt.w_hst;
if step_curr == 1
    sta_curr = tgt.sta_init;
else
    sta_curr = tgt.sta_curr;
end
%% calc process noise
w = gauss_rnd(zeros(size(A, 1), 1), Q);
% update state_curr
sta_curr = A * sta_curr + w;
%% archive
% w_hst(:, step_curr) = w;
% sta_hst(:, step_curr) = sta_curr;
w_hst(step_curr, :) = w';
sta_hst(step_curr, :) = sta_curr';
%% save data to target
tgt.sta_curr = sta_curr;
tgt.sta_hst = sta_hst;
tgt.step_curr = step_curr;
tgt.w_hst = w_hst;


