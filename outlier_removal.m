clc
clear
close all

% Generate values from a normal distribution with mean 1 and standard deviation 2.
x = 1 + 2 * randn(1000,1);

Q = quantile(x,4);

IQR = Q(3) - Q(2);

outliers_low_bound = Q(2) - 1.5 * IQR;
outliers_high_bound = Q(3) + 1.5 * IQR;

outliers_of_x = x(x<outliers_low_bound | x>outliers_high_bound);
clean_x = x(x>=outliers_low_bound & x<=outliers_high_bound);

fprintf('number of data: %d\n', numel(x));
fprintf('number of outliers: %d\n', numel(outliers_of_x));
fprintf('number of clean data: %d\n', numel(clean_x));
fprintf('mean and variance of data before outlier removal: %f, %f\n', mean(x), var(x));
fprintf('mean and variance of data after outlier removal: %f, %f\n', mean(clean_x), var(clean_x));
