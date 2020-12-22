    %% Linear Regression with Polynomial Basis of different degrees
% based on code code by Romain Thibaux
% (Lecture 2 from http://www.cs.berkeley.edu/~asimma/294-fall06/)
%%

% This file is from pmtk3.googlecode.com

N = 21;
%N = 25;
[xtrain, ytrain, xtest, ytestNoisefree, ytest] = ...
    polyDataMake('sampling','thibaux', 'n', N);


%degs = 0:2:20;
degs = 1:20;
Nm = length(degs);

%% Plot error vs degree
mseTrain = zeros(1,Nm); mseTest = zeros(1,Nm);
for m=1:length(degs)
    deg = degs(m);
    pp = preprocessorCreate('rescaleX', true, 'poly', deg, 'addOnes', true);
    model = linregFit(xtrain, ytrain, 'preproc', pp);
    ypredTrain = linregPredict(model, xtrain);
    [ypredTest] = linregPredict(model, xtest);
    mseTrain(m) = mean((ytrain-ypredTrain).^2);
    mseTest(m) = mean((ytest-ypredTest).^2);
end

ndx = (degs<=16);
figure;
hold on
plot(degs(ndx), mseTrain(ndx), 'bs:', 'linewidth', 2, 'markersize', 24);
plot(degs(ndx), mseTest(ndx), 'rx-', 'linewidth', 2, 'markersize', 24);
xlabel('degree')
ylabel('mse')
legend('train', 'test')
printPmtkFigure('linregPolyVsDegreeUcurve')



%% Compute log evidence for each model
for m=1:length(degs)
    deg = degs(m);
    pp = preprocessorCreate('rescaleX', true, 'poly', deg, 'addOnes', true);
    [modelEB, logev(m)] = linregFitBayes(xtrain, ytrain, 'preproc', pp, ...
        'prior', 'eb');
end

figure;
probs = exp(normalizeLogspace(logev));
plot(degs, logev ,'ko-', 'linewidth', 2, 'markersize', 24);
xlabel('degree'); ylabel('log evidence')
printPmtkFigure('linregPolyVsDegreeLogev')

figure; bar(degs, probs)
xlabel('degree'); ylabel('probability')
printPmtkFigure('linregPolyVsDegreeProbModel')



%% Plot fitted function for chosen values of degree
for deg = [1, 2, 14, 19, 20]
    pp = preprocessorCreate('rescaleX', true, 'poly', deg, 'addOnes', true);
    model = linregFit(xtrain, ytrain, 'preproc', pp);
    ypredTrain = linregPredict(model, xtrain);
    [ypredTest, sigma2] = linregPredict(model, xtest);
    sigma = sqrt(sigma2);
       
    figure;
    plot(xtrain,ytrain,'.b', 'markersize', 30);
    hold on;
    plot(xtest, ypredTest, 'k', 'linewidth', 3, 'markersize', 20);
    plot(xtest, ypredTest + sigma, 'b:', 'linewidth', 2);
    plot(xtest, ypredTest - sigma, 'b:', 'linewidth', 2);
    hold off
    title(sprintf('degree %d', deg))
    set(gca,'ylim',[-10 15]);
    set(gca,'xlim',[-1 21]);
    printPmtkFigure(sprintf('linregPolyVsDegreeFittedCurve%d', deg))
end

%% Residual plot
for deg = [1, 2]
    pp = preprocessorCreate('rescaleX', true, 'poly', deg, 'addOnes', true);
    model = linregFit(xtrain, ytrain, 'preproc', pp);
    ypredTrain = linregPredict(model, xtrain);
    residuals = (ytrain - ypredTrain);
       
    figure;
    plot(xtrain,residuals,'.b', 'markersize', 30);
    hold on
    h=line([min(xtest) max(xtest)], [0 0]);
    set(h, 'color', 'k');
    title(sprintf('residual plot for degree %d', deg))
    printPmtkFigure(sprintf('linregPolyVsDegreeResiduals%d', deg))
end

