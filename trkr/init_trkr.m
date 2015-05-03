function trkr = init_trkr(id, nstep, r)

%% input measurement matrix
H = [1, 0];
%% input measurement noise variance
R = r;
%% initial prior distribution parameters
v_hst = zeros(nstep, size(H, 1));
z_hst = zeros(nstep, size(H, 1));
%% save data to tracker
trkr.id = id;
trkr.H = H;
trkr.R = R;
trkr.v_hst = v_hst;
trkr.z_hst = z_hst;
