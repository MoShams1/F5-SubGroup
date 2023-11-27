% Mo Shams <m.shams.ahmar@gmail.com>
% Nov 2023

clc
clear
close all

spike_gen_mode = 'poisson';  % poisson, random

figure('Units','normalized','OuterPosition',[.1 .2 .2 .5])

%% set parameters

% number of trials
trial_n = 1000;
% trial width
trial_w = 400;

% baseline firing rate
fr_base = 2;  % Hz
% event-related firing rate
fr_event = 25;  % Hz
% event time in trial (ms)
event_t = trial_w/2;
% event duration (ms)
event_dur = 30;
% event-related activity std
event_std = 20;
% spike kernel width (std)
spike_kernel_std = 2;
% fano factor spike-count window
ff_w = 50;

xtick_vec = 0:100:trial_w;

subplot_rows = 3;
subplot_cols = 2;

%% create spike raster

if strcmp(spike_gen_mode, 'poisson')
    raster_base = spikegen(trial_n, trial_w, fr_base);
    raster_event = spikegen(trial_n, trial_w, fr_event);
    
    raster_mat = [
        raster_base(:,1:event_t),...
        raster_event(:,event_t+1:event_t+event_dur),...
        raster_base(:,event_t+event_dur+1:end)];
end

if strcmp(spike_gen_mode, 'random')
    raster_voltage = rand(trial_n, trial_w);
    
    thresh_base = 1 - (fr_base/1000);
    thresh_event = normpdf(1:trial_w, event_t, event_std);
    
    thresh_vec = thresh_event / max(thresh_event);
    thresh_vec = 1 - (fr_event/1000*thresh_vec);
    thresh_vec(thresh_vec>thresh_base) = thresh_base;
    
    % plot threshold vector
    subplot(subplot_rows,subplot_cols,1)
    plot(thresh_vec,'k')
    xticks(xtick_vec)
    xticklabels((xtick_vec) - event_t)
    xlim([0 trial_w])
    xlabel 'Time from event (ms)'
    ylabel 'Normalized threshold'
    cleanplot
    
    for itrial = 1:trial_n    
        raster_mat = raster_voltage > thresh_vec;
    end
end

% plot raster
subplot(subplot_rows,subplot_cols,2)
plotRaster({raster_mat},'k',5)
xticks(xtick_vec)
xticklabels((xtick_vec) - event_t)
xlim([0 trial_w])
xlabel 'Time from event (ms)'
ylabel 'Trials'
cleanplot

%% calculate inter-spike interval distribution

for itrial = 1:trial_n
    isi_cell{itrial} = diff(find(raster_mat(itrial,:)));
end

isi_vec = cell2mat(isi_cell);

% plot ISI distribution
subplot(subplot_rows,subplot_cols,3)
ax = histogram(isi_vec,20);
xlabel 'ISI (ms)'
ylabel 'Count'
ax.FaceColor = 'k';
cleanhist(ax)

%% calculate spike density function

raster_conv = raster2fr(raster_mat, spike_kernel_std);

% plot spike density function
subplot(subplot_rows,subplot_cols,4)
plot3line(1:trial_w, raster_conv*1000, 'k');
xticks(xtick_vec)
xticklabels((xtick_vec) - event_t)
xlim([0 trial_w])
xlabel 'Time from event (ms)'
ylabel 'Discharge rate (spikes/s)'
cleanplot

%% calculate Fano factor

ff = fanofactor(raster_conv,ff_w);

subplot(subplot_rows, subplot_cols, 6)
plot(ff,'k')
xticks(xtick_vec)
xticklabels((xtick_vec) - event_t)
xlim([0 trial_w])
xlabel 'Time from event (ms)'
ylabel 'Fano factor'
yline(1)
cleanplot
