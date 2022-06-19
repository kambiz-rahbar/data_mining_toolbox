clc
clear
close all

%row_data = [1 3 5 11 12 13 0 1];
row_data = [9 7 3 5];

data = zeros(1, 2^ceil(log2(numel(row_data))));
data(1:length(row_data)) = row_data;

disp(data)

dwt_data = zeros(size(data));

max_index = 2*numel(data);
while 1
    max_index = floor(max_index/2);
    odd_data = data(1:2:max_index);
    even_data = data(2:2:max_index);
    
    if isempty(odd_data) || isempty(even_data)
        break;
    end

    data = [odd_data+even_data odd_data-even_data]/2;
    disp(data)

    dwt_data(length(data)/2:length(data)) = data(length(data)/2:length(data));
end
disp('--------------------------------------------------------------');
disp(dwt_data);

