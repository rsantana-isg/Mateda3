function[SelPop,SelFunVal]=exp_selection(Pop,FunVal,selection_params)
% [SelPop,SelFunVal]=exp_selection(Pop,FunVal,selection_params)
% exp_selection:       Exponential selection for single objective functions
% INPUTS 
% Pop:                          Original population
% FunVal:                       A matrix of function evaluations, one vector of m objectives for each individual
% selection_params{1}= base:    The parameter used by exponential selection is the base for exponentiation
% OUTPUTS
% SelPop: Selected population
% SelFunVal:  A vector of function evaluations for each selected individual
%
% Last version 12/21/2020. Roberto Santana (roberto.santana@ehu.es)       
 
   base = cell2mat(selection_params{1}(1)); 
   PopSize = size(Pop,1);
   
   partialsum = base.^(FunVal)/sum(base.^(FunVal)); 
   partialsum=cumsum(partialsum);
   Index=sus(PopSize,partialsum);      % Stochastic Universal Sampling is used for sampling individuals
   SelPop=Pop(Index,:);   
   SelFunVal=FunVal(Index,:); 
 return
 
 
 