function tgt = init_tgt(nstep, q_c)

% stepsize of the discretization
dt = 1;
% input transition matrix for the continous-time system
F = [0, 1; 0, 0]; 
% input noise effect matrix for the continous-time system
L = [0; 1];
% input initial state
sta_init = [0, 3]';
% init w_hist
% w_hst = zeros(size(sta_init, 1), nstep);
w_hst = zeros(nstep, size(sta_init, 1));
% init state_hist
% sta_hst = zeros(size(sta_init, 1), nstep);
sta_hst = zeros(nstep, size(sta_init, 1));
% input process noise variance
Q_c = q_c;
% calc A, Q
[A, Q] = lti_disc(F, L, Q_c, dt);
% save data to target
tgt.sta_init = sta_init;
tgt.w_hst = w_hst;
tgt.sta_hst = sta_hst;
tgt.A = A;
tgt.Q = Q;
tgt.sta_curr = [];
tgt.step_curr = [];

