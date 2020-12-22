function [NewPop] = BitFlipMutation(NumbVar,Card,AuxPop,mutation_params)
% [NewPop] = BitFlipMutation(NumbVar,model,Card,AuxPop,AuxFunVal,sampling_params)
% BitFlipMutation:  Applies  A bit-flip mutation to each variable with
%                   probability as in mutation_params{1}. Only valid for
%                   binary variables
% 
%               
% INPUTS
% NumbVar:   Number of variables
% Card:      Vector with the dimension of all the variables. 
% AuxPop:    Auxiliary population generated by sampling (or crossover))
%            that will be mutated
% mutation_params{1}(1) = N: Number of generated individuals 
% OUTPUTS
% NewPop: Population with mutated individuals
%
%
% Last version 12/21/2020. Roberto Santana (roberto.santana@ehu.es)    


 N = size(AuxPop,1); % Number of individuals
 NewPop = AuxPop;
 
 mutProb = cell2mat(mutation_params{1}(1));
 
 MutMask = find(rand(N,NumbVar) < mutProb); % Determines which solutions will be mutated
 
 NewPop(MutMask) = 1 - AuxPop(MutMask);     % Solutions are mutated  