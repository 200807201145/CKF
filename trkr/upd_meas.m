function trkr = upd_meas(step_curr, sta_curr, trkr)

%% read data from tracker
H = trkr.H;
R = trkr.R;
v_hst = trkr.v_hst;
z_hst = trkr.z_hst;
%% update measurement
v = gauss_rnd(zeros(size(H, 1), 1), R);
z = H * sta_curr + v;
%% archive
% v_hst(:, step_curr) = v;
% z_hst(:, step_curr) = z;
v_hst(step_curr, :) = v;
z_hst(step_curr, :) = z;
%% save data to tracker
trkr.v_hst = v_hst;
trkr.z_hst = z_hst;
