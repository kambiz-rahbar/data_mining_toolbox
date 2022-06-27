clc
clear
close all

% generate data
number_of_recored = 100;
number_of_dimention = 2;

data = [randn(round(number_of_recored/2), number_of_dimention)
        5+randn(round(number_of_recored/2), number_of_dimention)];

% number of clusters
K = 2;

% set random medoids
medoids = data(randi(number_of_recored, [K, 1]), :);

% find medoids
stop_condition1 = inf;
max_iter = 1000;
for iter = 1:max_iter
    old_medoids = medoids;
    old_stop_condition = stop_condition1;

    % calculate data distance from medoids
    data_distance_from_medoids = zeros(number_of_recored, K);
    for i = 1:K
        data_distance_from_medoids(:, i) = calc_distance(data, medoids(i, :));
    end
    
    % label each record based on the distance from medoids
    [~, medoid_index] = min(data_distance_from_medoids, [], 2);
    
    % update medoids
    for i = 1:K
        medoid_data = data(medoid_index == i, :);
        medoid_data_mag = calc_distance(medoid_data, zeros([1 size(data, 2)]));
        [~, sort_index] = sort(medoid_data_mag);
        mid_index = round(max(sort_index)/2);
        medoids(i, :) = medoid_data(mid_index, :);
    end

    stop_condition1 = sse(old_medoids(:) - medoids(:));
    stop_condition2 = abs(old_stop_condition - stop_condition1);
    all_stop_condition = stop_condition1 < 0.5 | stop_condition2 < 0.5;
    
    fprintf('iter #%d: stop_conditopn1 = %.3f, stop_conditopn2 = %.3f\n', iter, stop_condition1, stop_condition2);
    
    if all_stop_condition
        break;
    end
end

% show results
disp('medoids:');
disp(medoids);

if number_of_dimention == 2
    figure(1);
    hold on;
    for i = 1:K
        plot(data(medoid_index == i, 1), data(medoid_index == i, 2), '.');
        plot(medoids(i, 1), medoids(i, 2), 'o', LineWidth=2);
    end
    axis square;
    grid minor;
    legend('cluster data #1', 'medoids', 'cluster data #1', Location='bestoutside');
end

% aux function
function [data_distance_from_medoid] = calc_distance(data, medoid)
    diff = data - repmat(medoid, [size(data, 1), 1]);
    data_distance_from_medoid = sqrt(sum(diff.^2, 2));
end

