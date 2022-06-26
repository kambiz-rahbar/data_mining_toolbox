clc
clear
close all

x = [sind(0:0.1:360); cosd(0:0.1:360)];
x = x';

y = x(:,1)<-0.5 | x(:,1)>0.5 | x(:,1).*x(:,2)>0;

noisy_y = y + 0.75*rand(size(y));
noisy_y = noisy_y>=0.5;

fprintf('%d data, sum of absolute error: %d\n', numel(y), sae(noisy_y - y));

tree_model_for_clear_data = fitctree(x, y);
tree_model_for_noisy_data = fitctree(x, noisy_y, "MaxNumSplits", 15);

view(tree_model_for_clear_data, Mode="graph");
view(tree_model_for_noisy_data, Mode="graph");

y_hat_form_clear_data_tree_model = predict(tree_model_for_clear_data, x);
y_hat_form_noisy_data_tree_model = predict(tree_model_for_noisy_data, x);

fprintf('clear data tree model prediction, sum of absolute error: %d\n', sae(y - y_hat_form_clear_data_tree_model));
fprintf('noisy data tree model prediction,sum of absolute error: %d\n', sae(y - y_hat_form_noisy_data_tree_model));
