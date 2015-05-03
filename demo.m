clear
close all
clc


%% initial
% initial Monte Carlo simulation parameters
mcruns = 100;
nstep = 100;
ntrkr = 4;
q_c = 1;
r = 1;

Tgt = cell(mcruns, 1);
Trkrs = cell(mcruns, 1);
Fc = cell(mcruns, 1);
%% Monte Carlo Simulation
for i = 1:mcruns
    disp(sprintf('Monte Carlo runs: NO. %d', i) );
    [tgt, trkrs, fc, mse_fc, nees_fc] = main(nstep, ntrkr, q_c, r);
    if i == 1
        Mse_fc = mse_fc;
        Nees_fc = nees_fc;
    else
        Mse_fc = Mse_fc + mse_fc;
        Nees_fc = Nees_fc + nees_fc;
    end
    % archive
    Tgt{i} = tgt;
    Trkrs{i} = trkrs;
    Fc{i} = fc;
    clear mse_fc
    clear nees_fc
end
%% calculate MSE
Mse_fc = Mse_fc / mcruns;
%% calculate NEES
Nees_fc = Nees_fc / mcruns;
%% log
logTime = sprintf('%s', datestr(now,30));
if ismac
    dataName = strcat('log/data_', logTime);
else
    dataName = strcat('log\data_', logTime);
end
save(dataName);