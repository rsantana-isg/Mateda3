function data = get_data_from_mysql(sql,datasource,username,password,url)

% this function can connect database and list data,its encapsulating
% Matlab function 'database'.
% ps: this function can't work if data size bigger than 1000000.��my mac
%     pro SDRAM memory is 16G)
%     my database project url is https://github.com/WANGXin1205/uci_database
%     you can use idea open the project and save some data,i support excel
%     in this project which downland form uci
%    ��http://archive.ics.uci.edu/ml/datasets.html��.
%
% input:
%     sql: is short for structured query language ,like 'select * from
%          emp;'
%     datasource: your datasource name, just support mysql database,
%                 my datasource is 'growlithe'
%     username: your database username,like 'growlithe'
%     password: your database password,like 'growlithe'
%     url: like url = 'jdbc:mysql://localhost:3306/growlithe';
% output:
%     data: cell data
%
% if you find bug, you can send email to me.
%
% Written by WANGXin(growlithe1205@gmail.com)
%
% ������������������ݿⲢ��ȡ���ݣ�����Matlab�Դ�����'database'�ķ�װ��
% ע��: ��������ڻ�ȡ����������1000000ʱ�����������������ҵ�mac pro�ڴ��СΪ16G��
%      �ҵ����ݿ���Ŀ��ַ: https://github.com/WANGXin1205/uci_database
%      �����ʹ��idea�������Ŀ���ұ���һЩ���ݣ����������Ŀ���ṩ��һЩ��uci
%     ��http://archive.ics.uci.edu/ml/datasets.html�����ص�excel��
%
% ����:
%    sql: sql�ǽṹ����ѯ���Եļ�ƣ���'select * from emp;'
%    datasource: ����Դ��ֻ֧��mysql���ݿ⣬�ҵ�����Դ��'growlithe'
%    username: ���ݿ����ƣ���'growlithe'
%    password: ���ݿ����룬��'growlithe'
%    url: �� url = 'jdbc:mysql://localhost:3306/growlithe';
% ���:
%    data: cell ���͵� data
%
% ����㷢����bug������Ը��ҷ�email
%
% Written by WANGXin(growlithe1205@gmail.com)

check_data_in_get_data_from_mysql(sql,datasource,username,password,url)

% default drive
drive = 'com.mysql.cj.jdbc.Driver';

try
    conn = database(datasource,username,password,drive,url);
    curs = exec(conn, sql);
    curs = fetch(curs);
    data = curs.Data;
catch
    disp('check you datasource��username��password��drive��url or sql is correct')
end

end


function check_data_in_get_data_from_mysql(sql,datasource,username,password,url)

% check all varargin are legal

if isempty(sql)
    error('sql is empty')
end

% check sql is select data, not update, delete, insert
sql_words = split(sql);
if ~isequal('SELECT',upper(sql_words{1}))
    error('the sql need select data')
end

if isempty(datasource)
    error('datasource is empty')
end

if isempty(username)
    error('username is empty')
end

if isempty(password)
    error('password is empty')
end

if isempty(url)
    error('url is empty')
end

end