% raster_many
% 2021-07-18
% Mohammad Shams
% m.shamsahmar@gmail.com
%------------------------
% raster(M,C,sz)
% M: input matrix blocks x {trial x time}
% C: color map (color x RGB; default = black)
% sz: dot size (default = 10)

function plotRaster(M,C,sz)
switch nargin
    case 1
        C = lines(7);
        sz = 5;
    case 2
        sz = 5;
end
offset = 0;
for iblock = 1:numel(M)
    N = M{iblock};
    N(isnan(N)) = 0;
    
    [y, x] = find(N);
    y = y+offset;
    
    scatter(x,y,sz,C(iblock,:),...
        'MarkerFaceColor',C(iblock,:),...
        'Markeredgecolor','none',...
        'MarkerFaceAlpha',.4);
    hold on
    
    offset = offset + size(N,1);
    axis ij  
end
xlim([0 size(N,2)+1])
ylim([0 offset+1])