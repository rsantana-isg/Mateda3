function bnet = get_bnet(data,dag,cpd_name)

% this function can get a bnet from data and dag
%
% bnet = get_bnet(data,dag,cpd_name)
%
% input:
%     data: a matrix data��just support num
%     dag: a dag
%     cpd_name: CPD��tabular means discrete distribution and gaussian means
%               gaussian distribution.
% output:
%     bnet
%
% if you find bug, you can send email to me.
%
% Written by WANGXin(growlithe1205@gmail.com)
%
% ����������Դ����ݺ������޻�ͼ�л��һ�����硣
%
% ����:
%    data: һ���������ݣ�ֻ֧�����֣�
%    dag: һ�������޻�ͼ��
%    cpd_name: �������ʷֲ���ʽ��tabular������ɢ�ֲ� �� gaussian�����˹�ֲ���
% ���:
%    bnet
%
% ����㷢����bug������Ը��ҷ�email
%
% Written by WANGXin(growlithe1205@gmail.com)

[row,~] = size(data);
node_sizes = get_node_sizes(data);
bnet = mk_bnet(dag, node_sizes);

switch cpd_name
    case 'tabular'
        for i=1:row
            bnet.CPD{i} = tabular_CPD(bnet, i);
        end
    case 'gaussian'
        for i=1:row
            bnet.CPD{i} = gaussian_CPD(bnet, i);
        end
end

end