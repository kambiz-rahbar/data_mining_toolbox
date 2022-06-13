clc
clear
close all

number_of_records_in_x = 10;
number_of_data_in_eaxh_record_for_x = 20;
x = rand(number_of_records_in_x, number_of_data_in_eaxh_record_for_x);

number_of_records_in_y = 15;
number_of_data_in_eaxh_record_for_y = 20;
y = rand(number_of_records_in_y, number_of_data_in_eaxh_record_for_y);

match_threshold = 0.1;

dissimilarity = ones(size(x, 1), size(y, 1));
for i = 1 : size(x, 1)
    for j = 1 : size(y, 1)
        compare_data = abs(x(i, :) - y(j, :)) < match_threshold;
        dissimilarity(i,j) = (numel(compare_data) - sum(compare_data)) / numel(compare_data);
        %similarity(i,j) = sum(compare_data) / numel(compare_data);
    end
end

similarity = 1 - dissimilarity;
subplot(1,2,1); imagesc(similarity); title('similarity'); colorbar; axis square;
subplot(1,2,2); imagesc(dissimilarity); title('dissimilarity'); colorbar; axis square;
colormap gray