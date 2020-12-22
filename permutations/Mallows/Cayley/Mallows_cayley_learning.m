function[model] = Mallows_cayley_learning(k,NumbVar,Card,SelPop,AuxFunVal,learning_params)
% [model] = Mallows_cayley_learning(k,NumbVar,Card,SelPop,AuxFunVal,learning_params)
% Mallows_cayley_learning:  Creates Mallows permutation model with cayley distance
%             
% k: Current generation
% NumbVar: Number of variables
% Card: Vector with the dimension of all the variables. 
% SelPop:  Population from which the model is learned 
% AuxFunVal: Evaluation of the data set (required for some learning algorithms, not for this one)
% learning_params{1}(1) = initialTheta: Initial theta value
% learning_params{1}(2) = upperTheta: The maximum theta value
% learning_params{1}(3) = maxit: Maximum iteration
% learning_params{1}(3) = RankingFun: The ranking function

% OUTPUTS
% model:      model{1} contains a permutation probabilities matrix with NumbVar-1 rows and NumbVar columns.
%					   The matrix is a left upper triangular matrix.
%             model{2} contains the consensus ranking.
%             model{3} contains calculated theta value.
%             model{4} contains a vector with calculated psi values.
%
% References:
% [1] C. L. Mallows: Non-null ranking models. Biometrika, 1957
% [2] J. Ceberio, E. Irurozki, A. Mendiburu, J.A Lozano: Extending Distance-based Ranking Models in Estimation of Distribution Algorithms. In Proceedings of the Congress on Evolutionary Computation, 2014
%
% Created version 04/04/2014. Josian Santamaria (jasantamaria003@ikasle.ehu.es) 
%
% Last version 12/21/2020. Roberto Santana (roberto.santana@ehu.es)    

initialTheta = cell2mat(learning_params{1}(1));
upperTheta = cell2mat(learning_params{1}(2));
maxit = cell2mat(learning_params{1}(3));

RankingFun= char(cellstr(learning_params{1}(4)));

NSel = size(SelPop,1); % Population size

% 1.- Calculate the consensus ranking/permutation, using the chose method
ConsensusRanking = eval([RankingFun,'(''Cayley_distance'',SelPop,NSel)']);

% 2.- Calculate theta parameters
Theta =  CalculateThetaParameterC(ConsensusRanking,SelPop,initialTheta,upperTheta,maxit);

% 3.- Calculate psi constants.
Psis = CalculatePsiConstantsC(Theta, NSel);

% 4.- Calculate Xj probabilities matrix.
XProbs = XProbMat(NumbVar,Psis,Theta);

model{1} = XProbs; % Permutation probabilities matrix
model{2} = ConsensusRanking;
model{3} = Theta;
model{4} = Psis;


return;
