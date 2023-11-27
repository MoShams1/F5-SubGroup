%
% spktrain2fr v1.0
% 07.10.2020
% Mohammad Shams
% m.shamsahmar@gmail.com
%
% Replaces spikes in a spike train with a normalized Gaussian
% NOTE: to avoid artifacts at the endpoints, marginal spikes will be replaced with partial Gaussians of similar energy as the rest.
%
% convolved_spike_train = spktrain2fr(spike_train,kernel_std);
%
% INPUT
% spike_train: a vector of integers, where ones indicate a spike and zeros no spike
% kernel_std: the standard deviation of the Gaussian kernel
%
% OUTPUT
% convolved_spike_train: a vector with the same size as spike_train, where each spike is replaced by the normalized kernel
%

function spktrain_conv = spktrain2fr(spktrain,std)


% ----------------------------------------------- create the kernel

% set the kernel width
k = 10;  % set this coefficient large enough to preserve the shape of each kernel
kernel_width = k * std;

% find the half size kernel
hk = ceil(kernel_width/2);

% create the normalized gaussian kernel (if kernel_std large enough => kernel's are = 1)
xkernel = -hk:hk;
kernel = normpdf(xkernel,0,std);


% ----------------------------------------------- apply the kernel

% localize spikes in the trial
spike_times = find(spktrain==1);

% pre-allocate a matrix for each trial (nSpikes,nTime-bins)
spike_mat = zeros(length(spike_times),length(spktrain)+2*hk);

% go to each spike in the spike train
ispike = 0;
for tspike = spike_times+hk % a half size kernel is added to update the spike times with respect to the train_conv vector

    % store each convolved spike in a separate row of the pre-allocated matrix
    ispike = ispike+1;
    spike_mat(ispike,tspike-hk:tspike+hk) = kernel;

end

% crop the extra time-bins, side products of the convolution process
spike_mat(:,1:hk) = [];
spike_mat(:,end-(hk-1):end) = [];

% ----------------------------------------------- normalize each kernel

% calculate the energy of each kernel
energy = nansum(spike_mat,2);

% scale the energy of each kernel to one
spike_mat = spike_mat./energy;

% add up the energy of all the kernels
spktrain_conv = nansum(spike_mat,1);

