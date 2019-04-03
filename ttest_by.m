function [ mu, p, t, h, stats] = ttest_by( V, group, paired, fun )
% This function uses tapply and ttest subfunction

if nargin < 3
    paired = 0;
end


if nargin < 4
  fun = @nanmean;
end

mu = tapply (V, {group}, fun);
lValue = unique(group);
if paired ==1     
    [h, p, aga, stats] = ttest(V(group == lValue(1)), V(group == lValue(2)));
    t=stats.tstat;
else
    [h, p, aga, stats] = ttest2(V(group == lValue(1)), V(group == lValue(2)));
    t=stats.tstat;
end
disp(['   ']);
disp(['   ']);
disp(['means = ' num2str(mu(1)) ' and ' num2str(mu(2))]);
disp(['p-value = ' num2str(p) ' and ' 't-value = ' num2str(t)]);

end

