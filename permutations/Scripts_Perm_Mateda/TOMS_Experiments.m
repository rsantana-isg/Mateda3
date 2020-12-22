function[model] = Mallows_Ulam_learning(k,NumbVar,Card,SelPop,AuxFunVal,learning_params)


% This script contains all the experiments used in the TOMS paper




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%- Sobre el LOP, aplicaremos el Mallows-Ulam.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global LOPInstance             % The selected LOP instance is saved in the global variable LOPInstance
ReadLOPInstance('N-be75eec');  % LOP (LOLIB -> N-be75eec, n=50),

[matrix, n] = LOPInstance{:};                                   % LOP     Problem


 ngen = 150;                   % Number of generations 
 NumbVar = n;                  % Number of variables
 PopSize = 10*NumbVar;         % Population size
 F = 'EvalLOP';               % Optimization problem     [It should be modified according to the problem]
 cache  = [0,0,0,0,0];         % Array to indicate which information
 
 Card = [ones(1,NumbVar);NumbVar*ones(1,NumbVar)];            % All variables have values between 1 and NumbVar
 edaparams{1} = {'seeding_pop_method','InitPermutations',{}}; % The initial population is uniquely composed of permutations
 

 edaparams{2} = {'learning_method','Mallows_Ulam_learning',{-10.001,10,100,'setMedianPermutation'}};             % Parameters of the learning algorithm
 edaparams{3} = {'sampling_method','Mallows_Ulam_sampling',{PopSize-1,1}};                                       % Parameters of the sampling algorithm
 edaparams{4} = {'replacement_method','pop_agregation',{'fitness_ordering'}};                                    % Pop. agregation is used as replacement method, Pop + sampled pop 
 selparams(1:2) = {NumbVar/PopSize,'fitness_ordering'};                                                          % Parameters used for selection (Truncation parameter and max_gen)
 edaparams{5} = {'selection_method','truncation_selection',selparams};                                           % Selection method used
 edaparams{6} = {'stop_cond_method','max_gen',{ngen}};                                                           % The algorithm stops when the max number of generations is reached
 
 
 Expe_AllStat = {}

 for j=1:Number_Experiments,
   [AllStat,Cache]=RunEDA(PopSize,NumbVar,F,Card,cache,edaparams);                                                 % Statistics of the algorithm are saved in AllStat            
   AllStat{i,1};     
   for i=1:ngen,                                                                                                 % We extract mean fitness in each  generation   
     bestf(i,:) = AllStat{i,1};                                                                                  % for visualization     
   end,    
   
   figure
   plot(bestf(:,2))
   xlabel('Generations');
   ylabel('Mean Fitness');
   

   

 
 

   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%- Sobre el QAP, aplicaremos el GMallows-Cayley.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 global QAPInstance                   % The selected QAP instance is saved in the global variable QAPInstance
 ReadQAPInstance('tai40b.dat');       % QAP (Taillard Benchmark -> tai40b.dat, n=40)a

 [distance, flow, n] = QAPInstance{:};                           % QAP     Problem

 ngen = 150;                   % Number of generations 
 NumbVar = n;                  % Number of variables
 PopSize = 10*NumbVar;         % Population size
 F = 'EvalQAP';               % Optimization problem     [It should be modified according to the problem]
 cache  = [0,0,0,0,0];         % Array to indicate which information
 
 Card = [ones(1,NumbVar);NumbVar*ones(1,NumbVar)];            % All variables have values between 1 and NumbVar
 edaparams{1} = {'seeding_pop_method','InitPermutations',{}}; % The initial population is uniquely composed of permutations 
 edaparams{2} = {'learning_method','GMallows_cayley_learning',{-10.001,10,100,'setMedianPermutation'}};          % Parameters of the learning algorithm
 edaparams{3} = {'sampling_method','GMallows_cayley_sampling',{PopSize-1,1}};                                    % Parameters of the sampling algorithm
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
   
   
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%- Sobre el PFSP, aplicaremos el GMallows-Kendall
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 global PFSPInstance                         % The selected PSFP instance is saved in the global variable PFSPInstance
 ReadPFSPInstance('tai50_20_0.fsp');         % PFSP (Taillard Benchmark -> tai50_20_0.fsp, n=50).
 
  [processingtimes, machines, jobs] = PFSPInstance{:}; n = jobs;    % PFSP    Problem
 
  
 ngen = 150;                   % Number of generations 
 NumbVar = n;                  % Number of variables
 PopSize = 10*NumbVar;         % Population size
 F = 'EvalPFSP';               % Optimization problem     [It should be modified according to the problem]
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
   
   
   