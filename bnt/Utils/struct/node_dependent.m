function node2node = node_dependent(dag,label,varargin)

%�ú������ڴ�ӡ���һ��ͼģ���и��ڵ�Ĺ�ϵ�������ͼ��ΪDAG��
%
% Input��
%     dag  ͼ��
%     label �ڵ�����
%  varargin
%     node_flag �ڵ����� like A
%
% Output��
%     printf
%
% Written by WANGXin(growlithe1205@gmail.com)
% �������BUG����ϵ���߱��ˡ�

[r,c] = size(dag);

if r~=c
    disp('The input dag is not a DAG')
    return
end
if r ~= length(label)
    disp('The label length is not equal dag size')
    return
end

node2node = cell(0,0);
node_flag = 'A';

if ~isempty(varargin)
    args = varargin;
    nargs = length(args);
    if ischar(args{1})
        for i=1:2:nargs
            switch args{i}
                case 'node_flag'
                    node_flag = args{i+1};
                case 'params'
                    if isempty(args{i+1}), params = cell(1,n);
                    else params = args{i+1};
                    end
            end
        end
    else
        node_flag = args{1};
    end
end

order_name = cell(2,length(label));

for i=1:r
    order_name{1,i} = i;
    order_name{2,i} = label(1,i);
end

% dag  = dag';
[row,col] = find(dag==1);
edge = [row,col];

% �ڵ�����Ϊ�������ֱ��
temp = edge(:,1);
edge(:,1) = edge(:,2);
edge(:,2) = temp;

[er,ec] = size(edge);
edge_name = cell(er,ec);

for i = 1:er
    for j = 1:ec
        for k =1:length(order_name)
            if edge(i,j) == cell2num(order_name(1,k))
                edge_name{i,j} = cell2num(order_name(2,k));
            end
        end
    end
end

for i=1:length(edge(:,1))
    node2node{i} = sprintf('dag(node.%s%d,node.%s%d)=true;',...
        node_flag, edge(i,1), node_flag, edge(i,2));
    fprintf('dag(node.%s%d,node.%s%d) = true;\n', node_flag,...
        edge(i,1), node_flag, edge(i,2));
end
fprintf('\n\n');

for i=1:length(edge(:,1))
    fprintf('dag(%s,%s) = true;\n',char(edge_name{i,1}),char(edge_name{i,2}));
end
fprintf('\n\n');

node2node = node2node';

end