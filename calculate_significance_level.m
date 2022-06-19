clc
clear
close all

%binary_observed_frequency = [250 200
%                             50  1000];
binary_observed_frequency = [100 360
                             210 840];

% calculate contingency table
contingency_table = binary_observed_frequency;
contingency_table(3, :) = sum(contingency_table, 1);
contingency_table(:, 3) = sum(contingency_table, 2);

% calculate expected frequency
expected_frequency = zeros(2, 2);
for r = 1:2
    for c = 1:2
        expected_frequency(r, c) = contingency_table(end, c) * contingency_table(r, end) / contingency_table(3, 3);
    end
end

% chisquare test
X2 = sum( (contingency_table(1:2, 1:2) - expected_frequency).^2 ./ expected_frequency, 'all');

% calculate degree of freedom
[r, c] = size(binary_observed_frequency);
degree_of_freedom = (r - 1) * (c - 1);

% calculate significance level
significance_resolution = 0.001;
significance_index = 1 - (1 - significance_resolution : -significance_resolution : significance_resolution);
significance_levels = chi2inv(significance_index, degree_of_freedom);

low_index = find(significance_levels <= X2, 1, 'last' );
high_index = find(significance_levels > X2, 1, 'first' );

% result
if isempty(low_index)
    fprintf('the significance level is less than %f\n', significance_index(1));
elseif isempty(high_index)
    fprintf('the significance level is more than %f\n', significance_index(end));
else
    fprintf('the significance level is in [%f %f)\n', significance_index(low_index), significance_index(high_index))
end
