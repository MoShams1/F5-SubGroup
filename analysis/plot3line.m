% plot3line
% last update: 14-Dec-2022
% Mohammad Shams <m.shams.ahmar@gmail.com>

function h = plot3line(x,A,color,crop,kstd,marker,sz)

switch nargin
    case 2
        color = lines(1);
        crop = 0;
        marker = 0;
    case 3
        crop = 0;
        marker = 0;
    case 5
        marker = 0;
end

if isempty(x)
    x = 1:size(A,2);
end

if ~iscell(A)
    if crop
        A(:,1:3*kstd) = nan;
        A(:,end-(3*kstd)+1:end) = nan;
    end
    m = nanmean(A,1);
    err = SE(A);
else    
    for ic = 1:numel(A)
        m(ic) = nanmean(A{ic});
        err(ic) = SE(A{ic});
    end
end

hold on
if ~marker
    h = plot(x,m,'color',color,'linewidth',1);
elseif marker
    h = plot(x,m,'color',color,'linewidth',1,...
        'marker','o','markersize',sz,...
        'markerfacecolor',color,'MarkerEdgeColor','none');
end
plot(x,m-err,'color',color,'linewidth',.5)
plot(x,m+err,'color',color,'linewidth',.5)