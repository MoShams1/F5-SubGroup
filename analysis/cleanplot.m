% cleanplot
% Mohammad Shams <m.shams.ahmar@gmail.com>
%
% For the current axis:
%   - makes the tick lines of the plot outward
%   - removes the white background
%   - removes the border around the legend
%   - converts all the text objects to Helvetica-8

function cleanplot
set(gca,'tickdir','out','color','none')
box off
ax = gca;
if ~isempty(ax.Legend)
    legend boxoff
end