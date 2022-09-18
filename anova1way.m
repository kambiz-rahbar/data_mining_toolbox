clc
clear
close all

number_of_groups = 10;
number_of_data_in_each_groups = 30;

data = 0.05*meshgrid(1:number_of_groups, 1:number_of_data_in_each_groups);
data = data + randn(size(data));

k = size(data, 2); % number of groups
N = numel(data);
alpha = 0.05;

df_between = k-1;
df_within = N-k;
df_total = df_between+df_within;

F_crit = finv(1-alpha, df_between, df_within);

mu_x = mean(data, 1);
grand_mu = mean(data, 'all');

SS_total = sum( (data-grand_mu).^2, 'all' );
SS_within = sum( (data-repmat(mu_x,[size(data,1), 1])).^2, 'all' );
SS_between = SS_total-SS_within;

MS_between = SS_between/df_between;
MS_within = SS_within/df_within;

F = MS_between/MS_within;

fprintf('H0: There is no significant differences between groups means.\n');
fprintf('Ha: At least 1 difference among the means.\n');
if F < F_crit
    fprintf('Fail to reject H0\n');
else
    fprintf('H0 is rejected.\n');
end