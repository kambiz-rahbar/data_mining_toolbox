clc
clear
close all

data = randn(1,1001);
min_of_data = min(data);
max_of_data = max(data);

number_of_bins = 33;

bins_edge = quantile(data, number_of_bins-1);
bins = [min_of_data-eps bins_edge max_of_data+eps];

bins_center = (bins(2:end)+bins(1:end-1)) / 2;

counts = histcounts(data, bins);

bar(bins_center, counts)
