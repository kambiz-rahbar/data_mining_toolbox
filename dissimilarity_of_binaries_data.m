clc
clear
close all

number_of_records_in_x = 10;
number_of_data_in_eaxh_record_for_x = 20;
x = rand(number_of_records_in_x, number_of_data_in_eaxh_record_for_x) > 0.5;

number_of_records_in_y = 15;
number_of_data_in_eaxh_record_for_y = 20;
y = rand(number_of_records_in_y, number_of_data_in_eaxh_record_for_y) > 0.5;

symetric_threshold = 0.05;

if (sum(x(:))-sum(1-x(:)))/numel(x) < symetric_threshold && (sum(y(:))-sum(1-y(:)))/numel(y) < symetric_threshold
    is_data_symetric_binary = true;
else
    is_data_symetric_binary = false;

    % force to set 1 for small amount of data
    if (sum(x(:))+sum(y(:))) > (sum(1-x(:))+sum(1-y(:)))
        x = 1 - x;
        y = 1 - y;
    end

    jaccard = ones(size(x, 1), size(y, 1));
end

match_threshold = 0.1;

dissimilarity = ones(size(x, 1), size(y, 1));
for i = 1 : size(x, 1)
    for j = 1 : size(y, 1)
        q = sum(x(i, :) == y(j, :) & x(i, :) == 1);
        t = sum(x(i, :) == y(j, :) & x(i, :) == 0);
        r = sum(x(i, :) ~= y(j, :) & x(i, :) == 1);
        s = sum(x(i, :) ~= y(j, :) & x(i, :) == 0);

        if is_data_symetric_binary
            dissimilarity(i, j) = (r + s) / (q + t + r + s);
        else
            dissimilarity(i, j) = (r + s) / (q + r + s);
            jaccard(i, j) = q / (q + r + s); %coherence or jaccard, both are the same
        end
    end
end

similarity = 1 - dissimilarity;

figure(1);
colormap gray;

subplot(1,2,1);
imagesc(similarity);
if is_data_symetric_binary
    title('similarity for symetric binaries');
else
    title('similarity for nonsymetric binaries');
end
colorbar;
axis square;

subplot(1,2,2);
imagesc(dissimilarity);
if is_data_symetric_binary
    title('dissimilarity for symetric binaries');
else
    title('dissimilarity for nonsymetric binaries');
end
colorbar;
axis square;

if ~is_data_symetric_binary
    figure(2);
    colormap gray;
    imagesc(jaccard);
    title('jaccard for nonsymetric binaries');
    colorbar;
    axis square;
end