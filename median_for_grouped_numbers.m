clc
clear

x = 100*rand(1000, 1);

number_of_data = numel(x);
bins_number = 5;
h = histcounts(x, bins_number);

data_range = max(x) - min(x);
median_bin_index = ceil(bins_number / 2);

median_bin_low_bound = median_bin_index * data_range / bins_number;

under_median_bin_frequency = sum(h(1:median_bin_index - 1));
median_bin_frequency = h(median_bin_index);

media_bin_width = max(h(median_bin_index)) - min(h(median_bin_index));

median_value = median_bin_low_bound + (number_of_data / 2 - under_median_bin_frequency) / median_bin_frequency * media_bin_width;

matlab_median = median(x);

disp([median_value, matlab_median, median_value - matlab_median])