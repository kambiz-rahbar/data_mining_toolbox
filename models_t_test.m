clc
clear
close all

% H0 hypothesis: Both models are the same.
%
% K-fold: divide data into K partitions.
% for i = 1:10
%   train model with all partitions except partition i.
%   test the model with partition i
%

K = 10;
model_1_error_for_K_fold_testing = 0.05 * rand(1, 10);
model_2_error_for_K_fold_testing = 0.07 * rand(1, 10);

average_error_for_model_1 = mean(model_1_error_for_K_fold_testing);
average_error_for_model_2 = mean(model_2_error_for_K_fold_testing);

variance_model_1_and_model_2 = mean( (model_1_error_for_K_fold_testing - model_2_error_for_K_fold_testing...
    - (average_error_for_model_1 - average_error_for_model_2)) .^ 2);

t = (average_error_for_model_1 - average_error_for_model_2)...
    /sqrt(variance_model_1_and_model_2 / K);

%significant_threshold = 0.5;
%z = significant_threshold / 2;

degree_of_freedom = K-1;
z = tcdf(t, degree_of_freedom);

if abs(t) < z
    disp('H0 hypothesis rejected: The difference between the models is significant.');
else
    disp('H0 hypothesis accepted: Both models are the same.');
end
