% 
% spikegen v1.0
% 05.10.2020
% Mohammad Shams
% m.shamsahmar@gmail.com
%
% Creates a raster of spikes based on Poisson distribution
%
% raster = spikegen(trial, time, mean firing rate)
%

function raster = spikegen(trial,time,fr)

sum_v = poissrnd(fr,trial,1); % number of spikes per trial

raster = zeros(trial,time); % create default raster output

% localize spikes in the raster
for itr = 1:trial
    raster(itr,randi(time,1,sum_v(itr))) = 1;
end
