function [data_type_map, data_need_convert_map] = get_data_type_map(data)

% this function can get data type map and data need convert map. 
%
% input:
%      data: cell data,from database.
% output:
%      data_type_map: data type map
%      data_need_convert_map: data need convert map��key is index, value is
%                             logical, 1 means need convert.
%
% if you find bug, you can send email to me.
%
% Written by WANGXin(growlithe1205@gmail.com)
%
%
% �������������ȡ��������map��������Ҫת����map��
%
% ����:
%    data: cell���ݣ������ݿ��ȡ���ġ�
% ���:
%    data_type_map: ��������map
%    data_need_convert_map: ������Ҫת����map, key��λ��������value��logical,
%                           1������Ҫ����ת����
%
% ����㷢����bug������Ը��ҷ�email
%
% Written by WANGXin(growlithe1205@gmail.com)

% get data row and col
[data_row,data_col] = size(data);

% make a empty map
key_set{data_col,1} = zeros(data_col,1);
data_type_map_value_set{data_col,1} = zeros(data_col,1);
data_need_convert_flag_set{data_col,1} = zeros(data_col,1);

% data from mysql and get data types
for i = 1:data_col
    flag_count = 0;
    key_set{i,1} = i;
    for j = 1: data_row
        
        % judge num
        num_flag = isnumeric(data{j,i});
        if num_flag
            
            integer_flag = is_integer(data{j,i});
            if integer_flag
                flag_count = flag_count + 1;
                if data_row == flag_count
                    data_type_map_value_set{i,1} = {'int'};
                end
            else
                data_type_map_value_set{i,1} = {'decimal'};
            end
            
        end
        
        % judge char
        char_flag = ischar(data{j,i});
        if char_flag
            flag_count = flag_count + 1;
            if data_row == flag_count
                data_type_map_value_set{i,1} = {'char'};
            end
        end
        
    end
    
    % check whether data needs to be converted
    value_need_convert_flag = isequal(data_type_map_value_set{i,1}(1,1),{'char'});
    if value_need_convert_flag
        data_need_convert_flag_set{i,1} = 1;
    else
        data_need_convert_flag_set{i,1} = 0;
    end
    
end

data_type_map = containers.Map(key_set,data_type_map_value_set);
data_need_convert_map = containers.Map(key_set,data_need_convert_flag_set);

end


function flag = is_integer(x)

% this function check whether data is integer

flag = 0;

if x == fix(x)
    flag = 1;
end

return

end
