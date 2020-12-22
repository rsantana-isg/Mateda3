function node_sizes = get_node_sizes(data)

% this function can get node_sizes from data.
%
% node_sizes = get_node_sizes(data)
%
% input:
%    data: a matrix data��just support num.
% output:
%    node_sizes: the node sizes
%
% if you find bug, you can send email to me.
%
% Written by WANGXin(growlithe1205@gmail.com)
%
%
% ������Դ������л�ýڵ��С��
% ����:
%    data: һ����������,ֻ֧����������
% ���:
%    node_sizes: �ڵ��С
%
% ����㷢����bug������Ը��ҷ�email
%
% Written by WANGXin(growlithe1205@gmail.com)

[col,~]= size(data);

node_sizes = zeros(1,col);
for i = 1:col
    col_data = data(i,:);
    different_num = unique(col_data);
    node_sizes(i) = length(different_num);
end

node_sizes = node_sizes';
end