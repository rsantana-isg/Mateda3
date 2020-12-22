function [correct,miss,addation,reverse,error] = compare_dag(standard,dag)
% 
% This is my first code in BNT. We always want to know a dag which we
% built different to standard network.So you can use compare_dag 
% get correct edge ,miss edge,addation edge,reverse edge and all error
% edge.
% [correct,miss,addation,reverse,error] = compare_dag(standard,dag)
% Input:
%       standard means standard network
%       dag means the dag we built
% Output:
%      correct 
%      miss
%      addation
%      reverse
%      error
%
% Written by WANGXin(growlithe1205@gmail.com)
%
%    ��Ӣ�Ĳ�̫�ã�������ΪBNT�����ĵ�һ�����룬��֪����û�и����д����ظ���
%    �ú����Ƚϻ�׼�������������ṹ�ϵĲ��죬������ȷ�ı�����ȱʧ�ı��������ӵı�
%    ��������ı������Լ�����ı��������е�һ������Ϊ��׼���磬�ڶ��β������ǽ�����
%    ���硣
%    �ú�����������д���������BUG����ϵ���ߡ�
if(isempty(standard))
    fprintf('standard network is empty');
    return
end
if(isempty(dag))
    fprintf('dag network is empty');
    return
end
[s_m,s_n] = size(standard);
[d_m,d_n] = size(dag);
if s_m ~= d_m && s_n ~= d_n
    fprintf('dags size not equal');
    return
end
correct = 0;
miss = 0;
addation = 0;
reverse = 0;
for i = 1 : s_m
    for j = 1 : s_n
        
        boolean_correct = standard(i,j) == dag(i,j) ...
            && standard(i,j) ~= 0 && dag(i,j) ~= 0;
        if(boolean_correct)
            correct = correct + 1;
        end
        
        boolean_miss = standard(i,j) == 1 ...
            && dag(i,j) == 0 && standard(i,j) ~= dag(j,i);
        if(boolean_miss)
            miss = miss + 1;
        end
        
        boolean_addation = standard(i,j) == 0 && dag(i,j) == 1;
        if(boolean_addation)
            addation = addation + 1;
        end
        
        boolean_reverse = standard(i,j)==1 && dag(j,i)==1;
        if(boolean_reverse)
            reverse = reverse + 1;
        end
    end
end

error = miss + addation + reverse;

fprintf([ 'Correct edge num is %d, \n'...
    'Miss edge num is %d, \n'...
    'Addation edge num is %d, \n'...
    'Reverse edge num is %d, \n'...
    'Error edge num is %d. \n'],...
    correct,miss,addation,reverse,error);

end