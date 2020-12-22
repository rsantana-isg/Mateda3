function [avg_correct_rate,avg_confusion_matrix] ...
    = computer_avg_classified(correct_rate,confusion_matrix)

% this function computer avg correct rate from correct rate and computer 
% avg confusion matrix from confusion matrix.
%
% input:
%      correct_rate: the correct rate from classified test.
%      confusion_matrix: the confusion matrix from classified test.
% output:
%      avg_correct_rate: the avg correct rate from correct rate.
%      avg_confusion_matrix: the avg confusion matrix from confusion matrix.
%
% if you find bug, you can send email to me.
%
% Written by WANGXin(growlithe1205@gmail.com)
%
%
% ���������������ƽ����ȷ�� �� ƽ���������
%
% ����:
%    correct_rate: �ӷ�������л�ȡ����ȷ�ʡ�
%    confusion_matrix: �ӷ�������л�ȡ�ĺ������
% ���:
%    avg_correct_rate: ����ȷ���еõ���ƽ����ȷ�ʡ�
%    avg_confusion_matrix: �Ӻ�������еõ���ƽ���������
% 
% ����㷢����bug������Ը��ҷ�email
%
% Written by WANGXin(growlithe1205@gmail.com)

[confusion_matrix_row,confusion_matrix_col] = size(confusion_matrix);
confusion_matrix_length = confusion_matrix_row * confusion_matrix_col;
confusion_matrix_data = reshape(confusion_matrix,confusion_matrix_length,1);
[confusion_matrix_data_row,confusion_matrix_data_col] ...
    = size(cell2mat(confusion_matrix_data(1)));
sum_confusion_matrix_mat = zeros(confusion_matrix_data_row,confusion_matrix_data_col);

for i = 1 : confusion_matrix_length
    sum_confusion_matrix_mat = sum_confusion_matrix_mat + cell2mat(confusion_matrix_data(i));
end

avg_correct_rate = sum(correct_rate)/length(correct_rate);
avg_confusion_matrix = sum_confusion_matrix_mat/confusion_matrix_length;

end
