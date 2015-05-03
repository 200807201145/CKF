function fc = init_fc(nstep)

%% initial parameters
m_init = [0, 3]';
P_init = diag([0.1, 0.5]);
m_hst = cell(nstep, 1);
P_hst = cell(nstep, 1);
step_hst = [];
step_stdy = [];
%% save data to fusion center
fc.m_init = m_init;
fc.P_init = P_init;
fc.m_hst = m_hst;
fc.P_hst = P_hst;
fc.step_hst = step_hst;
fc.step_stdy = step_stdy;
%% initial mean and covariance
fc.m_curr = [];
fc.P_curr = [];
