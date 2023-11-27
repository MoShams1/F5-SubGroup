%
% raster2fr v1.0
% 07.10.2020
% Mohammad Shams
% m.shamsahmar@gmail.com
%
% Estimates the firing rate of a neuron given as a raster
%
% convolved_raster = raster2fr(raster,kernel_std)
%
% INPUT
% raster: a trial by time matrix of integers with ones indicating a spike and zeros no spike
% kernel_std: the standard deviation of the Gaussian kernel
%
% OUTPUT
% raster_conv = a matrix with the same size as the 'raster', where each spike is replaced by the normalized kernel
%

function raster_conv = raster2fr(raster,std)

% go to each trial (row of the raster)
for itrial = 1:size(raster,1)
    
    % extract the current trial
    spike_train = raster(itrial,:);
    
    % estimate the firing rate of the trial (spike train) by convolving a Gaussian kernel with a defined standard deviation
    raster_conv(itrial,:) = spktrain2fr(spike_train,std);
    
end