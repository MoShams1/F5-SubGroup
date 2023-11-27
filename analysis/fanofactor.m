% fanofactor v2.0
% Mo Shams <m.shams.ahmar@gmail.com>
% Nov 2023

function fano_mat = fanofactor(A,w)

k_vec = 1:size(A,2)-w;

sum_mat = nan(size(A));

for ik = k_vec
    sum_mat(:,ik+w/2) = sum(A(:,ik:ik+w), 2);
end

fano_mat = var(sum_mat, [], 1) ./ mean(sum_mat);

% summat = nan(size(A));
% center = floor(w/2);
% for i = 1:size(A,1)
%     for j = 1:size(A,2)-w
%         summat(i,j+center) = sum(A(i,j:j+w),2);
%     end
% end
% F = nanvar(summat,[],1)./nanmean(summat);
