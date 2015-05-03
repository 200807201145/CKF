function fc = ckf(step_curr, tgt, trkrs, fc)

% read data from tgt
A = tgt.A;
Q = tgt.Q;
% read data from fusion center
if step_curr == 1
    m_curr = fc.m_init;
    P_curr = fc.P_init;
else
    m_curr = fc.m_curr;
    P_curr = fc.P_curr;
end
m_hst = fc.m_hst;
P_hst = fc.P_hst;
step_hst = fc.step_hst;
% update step_hst
if isempty(step_hst)
    step_hst = step_curr;
else
    step_hst = [step_hst; step_curr];
end

%% centralized Kalman filter
% predict
m_curr = A * m_curr;
P_curr = A * P_curr * A' + Q;
% update
for i = 1:length(trkrs)
    if i == 1
        z = (trkrs(i).z_hst(step_curr, :) )';
    else
        z = [z, (trkrs(i).z_hst(step_curr, :) )'];
    end
end
z = z';
for i = 1:length(trkrs)
    if i == 1
        H = (trkrs(i).H)';
    else
        H = [H, (trkrs(i).H)'];
    end
end  
for i = 1:length(trkrs)
    if i == 1
        R = trkrs(i).R;
    else
        R = blkdiag(R, trkrs(i).R);
    end
end
H = H';
IM = H * m_curr;
IS = R + H * P_curr * H';
K = P_curr * H' /IS;
m_curr = m_curr + K * (z - IM);
P_curr = P_curr - K * IS * K';

% update m_hst and P_hst
m_hst{step_curr} = m_curr';
P_hst{step_curr} = P_curr;

%% archive
fc.step_hst = step_hst;
fc.m_curr = m_curr;
fc.P_curr = P_curr;
fc.m_hst = m_hst;
fc.P_hst = P_hst;