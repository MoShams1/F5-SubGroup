% cleanplot
% Mohammad Shams <m.shams.ahmar@gmail.com>
%
% For the current axis:
%   - calls cleanplot
%   - removes the edges of each bar

function cleanhist(h)
for ih = 1:length(h)
    h(ih).EdgeColor = 'none';
end
cleanplot