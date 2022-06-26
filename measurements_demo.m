clc
clear
close all

true_positives = 90;
false_negatives = 210;
false_positives = 140;
true_negatives = 9560;

confusion_matrix = [true_positives false_negatives
                    false_positives true_negatives];
positives = sum(confusion_matrix(1, :));
negatives = sum(confusion_matrix(2, :));
true_items = sum(confusion_matrix(:, 1));
false_items = sum(confusion_matrix(:, 2));
all = sum(confusion_matrix, 'all');

fprintf('actual_class/predicted_class \t Class#1 \t Class#2 \t Sum\n');
disp('-------------------------------------------------------------------------------');
fprintf('                     Class#1 \t TP: %d \t FN: %d \t %d\n',confusion_matrix(1, :), positives);
fprintf('                     Class#2 \t FP: %d \t TN: %d \t %d\n',confusion_matrix(2, :), negatives);
fprintf('                         Sum \t     %d \t     %d \t %d\n', true_items, false_items, all);
disp('-------------------------------------------------------------------------------');

sensitivity = 100 * true_positives / positives;
specificity = 100 * true_negatives / negatives;
accuracy = 100 * (true_positives + true_negatives) / all;
error_rate = 100 * (false_negatives + false_positives) / all;
precision = 100 * true_positives / (true_positives + false_positives);
recall = 100 * true_positives / (true_positives + false_negatives);
F_measures = 2 * precision * recall / (precision + recall);

beta = 1;
F_beta = (1 + beta ^ 2) * precision * recall / (beta ^ 2 * precision + recall);

disp(table(sensitivity, specificity, accuracy, error_rate, precision, recall, F_measures, F_beta));

 