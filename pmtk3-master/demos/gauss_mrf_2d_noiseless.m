% Infer function on  2d grid using Gaussian MRF prior.
% Based on p141 of "Introduction to Bayesian Scientific Computing"
% Daniela calvetti and Erkki Somersalo

n = 50;
L = gauss_mrf_2d_precmat(n);
B = L'*L;

% Conditioning: I2 defines the points that are known,
% I1 points to free pixels
I = reshape([1:n^2],n,n);
I2 = [I(15,15) I(15,25) I(15,40) I(35,25)];
x2 = [15;-20;10;10]; % observed pixel values
I1 = setdiff(I(:),I2);
% Conditional covariance of x1
B11 = B(I1,I1);
B12 = B(I1,I2);

% Calculating and plotting the conditional mean value
% surface
x1mean = -B11\(B12*x2);
xplot = zeros(n^2,1);
xplot(I1) = x1mean;
xplot(I2) = x2;
figure;
surfl(reshape(xplot,n,n)), shading flat, colormap(gray)
hold on
xlabel('x')
ylabel('y')
plot3(15,15,x2(1), 'ko', 'MarkerFaceColor','k');
plot3(25,15,x2(2), 'ko', 'MarkerFaceColor','k');
plot3(40,15,x2(3), 'ko', 'MarkerFaceColor','k');
plot3(25,35,x2(4), 'ko', 'MarkerFaceColor','k');
printPmtkFigure('gauss_mrf_2d_noiseless_mean')

% Plotting the standard deviation surface
STDs = zeros(length(I1),1);
for j = 1:length(I1)
ej = zeros(length(I1),1); ej(j)=1;
STDs(j) = norm(R' \ ej);
end
STDsurf = zeros(n^2,1);
STDsurf(I1) = STDs;
figure;
surfl(reshape(STDsurf,n,n))
shading flat, colormap(gray)
xlabel('x')
ylabel('y')
hold on
%plot3(15,15,0, 'ko', 'MarkerFaceColor','k');
%plot3(25,15,0, 'ko', 'MarkerFaceColor','k');
%plot3(40,15,0, 'ko', 'MarkerFaceColor','k');
%plot3(25,35,0, 'ko', 'MarkerFaceColor','k');
printPmtkFigure('gauss_mrf_2d_noiseless_var')


% Generate a few random draws from the distribution
R = chol(B11); % Whitening matrix
ndraws = 2;
rng('default');
for j = 1:ndraws
xdraw1 = x1mean + R\randn(length(I1),1);
xdraw = zeros(n^2,1);
xdraw(I1) = xdraw1;
xdraw(I2) = x2;
figure;
imagesc(flipud(reshape(xdraw,n,n))), shading flat
axis('square'), colormap(gray)
hold on
plot(15,15, 'ko', 'MarkerFaceColor','k');
plot(15,25, 'wo', 'MarkerFaceColor','w');
plot(15,40, 'ko', 'MarkerFaceColor','k');
plot(35,25, 'ko', 'MarkerFaceColor','k');
printPmtkFigure(sprintf('gauss_mrf_2d_noiseless_sample%d', j))
end


