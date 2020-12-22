function[NewPop] = SampleBN(NumbVar,bnet,Card,AuxPop,AuxFunVal,sampling_params)  
% [NewPop] = SampleBN(NumbVar,bnet,Card,AuxPop,AuxFunVal,sampling_params)  
% SampleBN:    Samples PopSize individuals from the Bayesian network bnet
% INPUTS
% NumbVar: Number of variables
% bnet: Bayesian network
% PopSize: Number of individuals to be generated
% Card: Cardinality of the variables
% AuxPop: Auxiliary (selected) population (May be use for partial sampling or resampling)
% AuxFunVal: Evaluation of the data set (required for some sampling
% algorithms, not for this one)
% sampling_params{1}(1) = PopSize: Number of generated individuals 
% OUTPUTS
% NewPop: Sampled individuals
%
% Last version 12/21/2020. Roberto Santana (roberto.santana@ehu.es)       

PopSize = cell2mat(sampling_params{1}(1)); 
for i=1:PopSize
 NewPop(i,:) = cell2mat(sample_bnet(bnet))-1;
end
 
