function varargout = loadData(dataset, varargin) %destnRoot, quiet, isMatFile)
%% Load the specified dataset

% If you specify an output, as in D = loadData('foo'), all of the variables
% in the .mat file are stored in the struct D, (unless there is only one).
%
% Otherwise, these variables are loaded directly into the calling
% workspace, just like the built in load() function, as in loadData('foo');
%
%
% Previously the data was downloaded if necessary from pmtkdata.googlecode.com
% This is no longer supported.
%
% Deprecated Options: [default]
% isMatFile - [true] will try to load in to work space
% isZipFile - [true] will download and unzip
%
%% Examples:
%
% D = loadData('prostate'); % store data in struct D
%
% loadData('prostate');     % load data directly into calling workspace
%
% s = loadData('sat')       % s is a matrix since there is only one variable
%
%
% Deprecated functionality:
% loadData('pmtkImages') % downloads pmtkImages.zip, unzips it and adds directory to path
%
% loadData('mathDataHoff.csv', 'isZipFile', false)
%  adds file to pmtkDataCopy without unzipping it
%%

% This file is from pmtk3.googlecode.com


%%
%if nargin < 2 || isempty(destnRoot), destnRoot = fullfile(pmtk3Root(), 'data'); end
%if nargin < 3, quiet = false; end
%if nargin < 4, isMatFile = true; end


try
    D = load([dataset, '.mat']);
catch ME
    %if ismember(dataset, bigFiles)
    %    fprintf('please download %s.zip from XXX\n', dataset);
    %end
    rethrow(ME)
end

%{
files = dir('/Users/kpmurphy/github/bigData');
for i=1:length(files)
    name = files(i).name;
    if name(1) == '.'
        continue
    end
    %{
    name = name(1:end-4); % drop .zip
    disp(fname)
    fname = sprintf('/Users/kpmurphy/github/bigData/%s', name);
    cmd = sprintf('unzip %s.zip %s', fname, fname);
    disp(cmd)
    system(cmd)
    %}
    fname = sprintf('/Users/kpmurphy/github/bigData/%s/%s.zip', name, name);
    cmd = sprintf('rm %s', fname);
    disp(cmd)
    system(cmd)
end
%}


%{ 


[destnRoot, quiet, isMatFile, isZipFile, dataset2] = process_options(varargin, ...
    'destnRoot', fullfile(pmtk3Root(), 'pmtkdataCopy'), ...
    'quiet', false, ...
    'isMatFile', true, ...
    'isZipFile', true, ...
    'dataset', filenames(dataset));

if isOctave(),  warning('off', 'Octave:load-file-in-path'); end
googleRoot = ' http://pmtkdata.googlecode.com/svn/trunk';
%%
isfolder = false;
if isMatFile && exist([dataset, '.mat'], 'file') == 2
  % if file on path then load it
  %if ~quiet, fprintf('%s.mat is on path already; loading\n', dataset); end
  D = load([dataset, '.mat']);
elseif ~isMatFile && exist(dataset, 'dir') == 7
  % folder on path - nothing to do
  %if ~quiet, fprintf('directory %s is on path already\n', dataset); end
  isfolder = true;
  return;
elseif ~isZipFile % KPM 28Feb11
  % donwload raw file if necessary
  if exist(dataset, 'file') == 2, return; end
  source = sprintf('%s/%s', googleRoot, dataset);
  dest   = fullfile(destnRoot, dataset);
  if ~quiet
    fprintf('downloading %s to %s\n', source, dest);
  end
  ok     = downloadFile(source, dest);
  if ~ok
    error('loadData:fileNotFound', 'Cannot find %s', source);
  end
else % download zip file and unzip
    source = sprintf('%s/%s/%s.zip', googleRoot, dataset, dataset);
    dest   = fullfile(destnRoot, [dataset, '.zip']);
    if ~quiet
        fprintf('downloading %s to %s\n', source, dest);
    end
    destFolder = fullfile(destnRoot, dataset);
    % SS check if file exists
    msg = exist(dest, 'file');
    if (msg == 2)
      fprintf('%s exists, no need to download',dest);
    else
      ok = downloadFile(source, dest);
      if ~ok
        error('loadData:fileNotFound', 'Cannot find %s', source);
      end
      unzip(dest, fileparts(dest));
    end

    addpath(destFolder)
    fname = [dataset, '.mat'];
    if isMatFile && exist(fname, 'file')
      D = load(fname);
      if ~quiet, fprintf('unzipped and loaded %s\n', fname); end
    else
      % it is a folder with no .mat file within it
      if ~quiet, fprintf('unzipped and added folder %s to path\n', dataset); end
      isfolder = true;
    end
    % don't delete stuff!!! because it takes so much time to download
    %delete(dest);
end
if ~isMatFile
  return;
end
if isfolder
  return
end
%}

if nargout == 0
    names = fieldnames(D);
    for i=1:numel(names)
        assignin('caller', names{i}, D.(names{i}));
    end
else
    if numel(fieldnames(D)) == 1
        names = fieldnames(D);
        varargout{1} = D.(names{1});
    else
        varargout{1} = D;
    end
end
end
