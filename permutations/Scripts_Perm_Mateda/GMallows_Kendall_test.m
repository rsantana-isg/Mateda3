% EXAMPLE 3  Optimization of problems with permutation-based representation:  
% Application of Generalized Mallows EDA using the Kendall distance
% to the the LOP problem
% By commenting some of the lines examples of the application of the
% algorithm to other three problems (PFSP, QAP, TSP) can be obtained.

% Created version 03/27/2014. Josian Santamaria (jasantamaria003@ikasle.ehu.es) 
%
% Last version 06/12/2016. Roberto Santana (roberto.santana@ehu.es) 


 global LOPInstance   % The selected LOP instance is saved in the global variable LOPInstance

 
 %ReadPFSPInstance('Cebe.pfsp.n30.m10.1');
  ReadLOPInstance('Cebe.lop.n30.1');
 %ReadQAPInstance('Cebe.qap.n10.1');
 %ReadTSPInstance('Cebe.tsp.n10.1');

 
 
 % [processingtimes, machines, jobs] = PFSPInstance{:}; n = jobs;    % PFSP    Problem
   [matrix, n] = LOPInstance{:};                                   % LOP     Problem
 % [distance, flow, n] = QAPInstance{:};                           % QAP     Problem
 % [distance, n] = TSPInstance{:};                            % TSP     Problem 
 
 

 ngen = 150;                   % Number of generations 
 NumbVar = n;                  % Number of variables
 PopSize = 10*NumbVar;         % Population size
 F = 'EvalLOP';               % Optimization problem     [It should be modified according to the problem]
 cache  = [0,0,0,0,0];         % Array to indicate which information
 
 Card = [ones(1,NumbVar);NumbVar*ones(1,NumbVar)];            % All variables have values between 1 and NumbVar
 edaparams{1} = {'seeding_pop_method','InitPermutations',{}}; % The initial population is uniquely composed of permutations 
 edaparams{2} = {'learning_method','GMallows_kendall_learning',{-10.001,10,100,'setMedianPermutation'}};          % Parameters of the learning algorithm
 edaparams{3} = {'sampling_method','GMallows_kendall_sampling',{PopSize-1,1}};                                    % Parameters of the sampling algorithm
 edaparams{4} = {'replacement_method','pop_agregation',{'fitness_ordering'}};                                    % Pop. agregation is used as replacement method, Pop + sampled pop 
 selparams(1:2) = {NumbVar/PopSize,'fitness_ordering'};                                                          % Parameters used for selection (Truncation parameter and max_gen)
 edaparams{5} = {'selection_method','truncation_selection',selparams};                                           % Selection method used
 edaparams{6} = {'stop_cond_method','max_gen',{ngen}};                                                           % The algorithm stops when the max number of generations is reached
 [AllStat,Cache]=RunEDA(PopSize,NumbVar,F,Card,cache,edaparams);                                                 % Statistics of the algorithm are saved in AllStat                         
 
   for i=1:ngen,                                                                                                 % We extract mean fitness in each  generation   
     bestf(i,:) = AllStat{i,1};                                                                                  % for visualization     
   end,    
   
   figure
   plot(bestf(:,2))
   xlabel('Generations');
   ylabel('Mean Fitness');
   
