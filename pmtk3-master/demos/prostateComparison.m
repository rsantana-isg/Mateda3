%% Compare L1, L2, allSubsets, and OLS linear regression on the prostate data set
% Approximately reproduces table 3.3 and fig 3.7 on p63 of "Elements of statistical
% learning" 2nd edn


% According to http://statweb.stanford.edu/~tibs/ElemStatLearn/datasets/prostate.info.txt
%  "The features must first be scaled to have mean zero and variance 96 (=n)"


% This file is from pmtk3.googlecode.com

function prostateComparison() 

setSeed(0);
saveLatex = true;

data = getData();
[Xtrain, ytrain] = shuffleRows(data.Xtrain, data.ytrain); 
% the data has been sorted which messes up CV

Xtest   = data.Xtest;   
ytest  = data.ytest;
nfolds = 10;
%%

maxLambda    =  log10(lambdaMaxLasso(Xtrain, ytrain));
lambdaRange  =  logspace(-2, maxLambda, 30); 
loss = @(yhat, ytest) mean((yhat - ytest).^2);                 
fitFn = @(regType)fitCv(lambdaRange,...
    @(X, y, l)linregFit(X, y, 'lambda', l, 'regType', regType),...
    @linregPredict, loss, Xtrain, ytrain, nfolds, 'useSErule', false, 'doPlot', true);




figureNames   = {'prostateLassoCV', 'prostateRidgeCV'};
titlePrefixes = {'lasso', 'ridge'};
regTypes = {'L1', 'L2'};

for i=1:numel(regTypes)
   [model, lambdaStar, mu, se] = fitFn(regTypes{i});  
    set(gca, 'xdir', 'reverse');
    set(gca, 'xscale', 'log'); 
    xlabel('lambda value');
    yhat = linregPredict(model, Xtest); 
    mse(i) = loss(yhat, ytest);
    title(sprintf('%s, mseTest = %5.3f', titlePrefixes{i}, mse(i)));
    printPmtkFigure(figureNames{i});
    weights(:, i) = colvec(model.w); 
end


%% All subsets
    function model = subsetFitFn(X, y, ndx)    
       [N,D] = size(X);
       include = ndx;
       exclude = setdiff(1:D, include);
       X(:, exclude) = 0;
       lambda = eps; % needed to avoid numerical issues caused by 0 entries in X
       model = linregFit(X, y, 'lambda', lambda); 
    end
%%    
d = size(data.Xtrain, 2); 
ss = powerset(1:d); % 256 models
[modelFull, ssStarFull, meanErr, stdErr] = ...
        fitCv(ss, @subsetFitFn, @linregPredict, loss, Xtrain, ytrain, nfolds);


%% for plotting purposes, look at fewer subsets
ssSmall = {[], 1, 1:2, 1:3, 1:4, 1:5, 1:6, 1:7, 1:8};
[model, ssStar, mu, se] = ...
        fitCv(ssSmall, @subsetFitFn, @linregPredict, loss, Xtrain, ytrain, nfolds);

ssStarNdx = cellfind(ssSmall, ssStar) - 1;
useLogScale = false; 
figure;
plotCVcurve(0:8, mu, se, numel(ssStarFull), useLogScale); % plot w.r.t to subset sizes
xlabel('subset size');
yhat = linregPredict(modelFull, data.Xtest); 
mse(3) = loss(yhat, data.ytest);
t = {  sprintf('%s, mseTest = %5.3f', 'all subsets', mse(3)); 
       ['best subset = ', mat2str(ssStarFull)]
    };
title(t);
printPmtkFigure('prostateSubsetsCV');

weights(:, 3) = colvec(modelFull.w);
%% OLS
model = linregFit(data.Xtrain, data.ytrain, 'lambda', 0);
weights(:, 4) = colvec(model.w);
yhat = linregPredict(model, data.Xtest);
mse(4) = loss(yhat, data.ytest); 
%%
fprintf('| OLS | SS | L2 | L1 |\n');
fprintf('weights: \n');
display(roundto(weights(:, end:-1:1), 0.001));
fprintf('mse: \n'); 
display(roundto(mse(end:-1:1), 0.001));


%%
if saveLatex
   weights = weights(:, end:-1:1); 
   mse = mse(end:-1:1);
   headers = {'Term', 'LS', 'Best Subset', 'Ridge', 'Lasso'};
   terms = [{'Intercept'}, data.names(1:8), {'Test Error'}]';
   table = [cell(10, 1), num2cell([weights; rowvec(mse)])];
   latextable(table, 'Horiz', headers, 'Vert', terms, 'format', '%.3f', 'Hline', [1, 10]); 
end


end

function data = getData()
%data = loadData('prostate'); % data in pmtkdata is incorrect!
url = 'http://statweb.stanford.edu/~tibs/ElemStatLearn/datasets/prostate.data';
fname = 'prostate.csv';
urlwrite(url, fname);
%data = importdata(fname, ',', 1);
% matlab is so primitive it cannot use csvread for text
fid = fopen('prostate.csv');
C = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%s', 'headerlines', 1);
fclose(fid);
% columns are: rownum lcavol lweight age lbph svi lcp gleason pgg45 lpsa 
data.names = {'lcavol', 'lweight', 'age',  'lbph', 'svi', 'lcp', 'gleason', 'pgg45', 'lpsa'};
istrain = [C{end}{:}]=='T';
X = [C{2} C{3} C{4} C{5} C{6} C{7} C{8} C{9}];
y = double([C{10}]);

X = standardize(X); % standardize outside of train/test split 
data.Xtrain = X(find(istrain),:);
data.ytrain = y(find(istrain),:);
data.Xtest = X(find(~istrain),:);
data.ytest = y(find(~istrain),:);
end


