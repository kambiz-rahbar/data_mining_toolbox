clc
clear
close all

%% build sample boolean data
number_of_records_in_x = 10;
number_of_data_in_eaxh_record_for_x = 20;
x = rand(number_of_records_in_x, number_of_data_in_eaxh_record_for_x);
x(rand(size(x)) < 0.1) = nan; % add miss data

number_of_records_in_y = 15;
number_of_data_in_eaxh_record_for_y = 20;
y = rand(number_of_records_in_y, number_of_data_in_eaxh_record_for_y);
y(rand(size(y)) < 0.1) = nan; % add miss data

%% calculate dissimilarity
match_threshold = 0.1;

dissimilarity = ones(size(x, 1), size(y, 1));
for i = 1 : size(x, 1)
    for j = 1 : size(y, 1)

        xf = x(i, :);
        yf = y(j, :);        
        
        %to not consider miss data
        miss_data_index = isnan(x(i,:)) | isnan(y(j,:));
        
        % remove miss features
        xf(miss_data_index) = [];
        yf(miss_data_index) = [];

        compare_data = abs(xf - yf) < match_threshold;
        dissimilarity(i,j) = (numel(compare_data) - sum(compare_data)) / numel(compare_data);
        %similarity(i,j) = sum(compare_data) / numel(compare_data);
    end
end

similarity = 1 - dissimilarity;

%% show results
subplot(1,2,1); imagesc(similarity); title('similarity'); colorbar; axis square;
subplot(1,2,2); imagesc(dissimilarity); title('dissimilarity'); colorbar; axis square;
colormap gray