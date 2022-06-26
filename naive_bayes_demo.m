clc
clear
close all

x = [sind(0:0.1:360); cosd(0:0.1:360)];
x = x';

y = x(:,1)<-0.5 | x(:,1)>0.5 | x(:,1).*x(:,2)>0;

noisy_y = y + 0.75*rand(size(y));
noisy_y = noisy_y>=0.5;

fprintf('%d data, sum of absolute error: %d\n', numel(y), sae(noisy_y - y));

naive_bayes_model_for_clear_data = fitcnb(x, y);
naive_bayes_model_for_noisy_data = fitcnb(x, noisy_y);

y_hat_form_clear_data_naive_bayes_model = predict(naive_bayes_model_for_clear_data, x);
y_hat_form_noisy_data_naive_bayes_model = predict(naive_bayes_model_for_noisy_data, x);

fprintf('clear data naive bayes model prediction, sum of absolute error: %d\n', sae(y - y_hat_form_clear_data_naive_bayes_model));
fprintf('noisy data naive bayes model prediction,sum of absolute error: %d\n', sae(y - y_hat_form_noisy_data_naive_bayes_model));
