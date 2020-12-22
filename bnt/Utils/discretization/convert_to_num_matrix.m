function [data, data_need_convert_map] = convert_to_num_matrix(data)

% this function can make cell data convert to num matrix
%
% [data, data_need_convert_map] = convert_to_num_matrix(data)
%
% input:
%      data: cell data,from database.
% output:
%      data: the result, use this function processed.
%      data_need_convert_map: data need convert map��key is index, value is
%                             logical, 1 means need convert.
%
% if you find bug, you can send email to me.
%
% Written by WANGXin(growlithe1205@gmail.com)
%
%
% �������������cell����ת��Ϊ��������
%
% ����:
%    data: cell���ݣ������ݿ��ȡ���ġ�
% ���:
%    data: �øú�������õ������ݡ�
%    data_need_convert_map: ������Ҫת����map, key��λ��������value��logical,
%                           1������Ҫ����ת����
% 
% ����㷢����bug������Ը��ҷ�email
%
% Written by WANGXin(growlithe1205@gmail.com)

% get data type map , the key is num , the value is string
[~, data_need_convert_map] = get_data_type_map(data);

% convert str to int in data

% this function convert data from char to int
for i = 1:length(keys(data_need_convert_map))
    
    if data_need_convert_map(i) == 1
        unique_data = unique(data(:,i));
        for j = 1: length(unique_data)
            for k = 1: size(data(:,i))
                if isequal(unique_data(j), data(k,i))
                    data{k,i} = j;
                end
            end
        end
    end
    
end

% all cell are double, so we use cell to mat
data = cell2mat(data);

end
