function[model] = Run_TOM_Experiments(type_function,number_experiments)


% This script contains all the experiments used in the TOMS paper


if type_function==1,                  % LOP problem

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%- Sobre el LOP, aplicaremos el Mallows-Ulam.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global LOPInstance             % The selected LOP instance is saved in the global variable LOPInstance
ReadLOPInstance('N-be75eec');  % LOP (LOLIB -> N-be75eec, n=50),

[matrix, n] = LOPInstance{:};                                   % LOP     Problem


 ngen = 500;                   % Number of generations 
 NumbVar = n;                  % Number of variables
 PopSize = 10*NumbVar;         % Population size
 F = 'EvalLOP';               % Optimization problem     [It should be modified according to the problem]
 cache  = [0,0,1,0,0];         % Array to indicate which information
 
 Card = [ones(1,NumbVar);NumbVar*ones(1,NumbVar)];            % All variables have values between 1 and NumbVar
 edaparams{1} = {'seeding_pop_method','InitPermutations',{}}; % The initial population is uniquely composed of permutations
 

 edaparams{2} = {'learning_method','Mallows_Ulam_learning',{0.001,12.0,100,'setMedianPermutation'}};             % Parameters of the learning algorithm
 edaparams{3} = {'sampling_method','Mallows_Ulam_sampling',{PopSize-1,1}};                                       % Parameters of the sampling algorithm
 edaparams{4} = {'replacement_method','pop_agregation',{'fitness_ordering'}};                                    % Pop. agregation is used as replacement method, Pop + sampled pop 
 selparams(1:2) = {NumbVar/PopSize,'fitness_ordering'};                                                          % Parameters used for selection (Truncation parameter and max_gen)
 edaparams{5} = {'selection_method','truncation_selection',selparams};                                           % Selection method used
 edaparams{6} = {'stop_cond_method','max_gen',{ngen}};                                                           % The algorithm stops when the max number of generations is reached
 
 
elseif type_function==2,  

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%- Sobre el QAP, aplicaremos el GMallows-Cayley.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 global QAPInstance                   % The selected QAP instance is saved in the global variable QAPInstance
 ReadQAPInstance('tai40b.dat');       % QAP (Taillard Benchmark -> tai40b.dat, n=40)a

 [distance, flow, n] = QAPInstance{:};                           % QAP     Problem

 ngen = 500;                   % Number of generations 
 NumbVar = n;                  % Number of variables
 PopSize = 10*NumbVar;         % Population size
 F = 'EvalQAP';               % Optimization problem     [It should be modified according to the problem]
 cache  = [0,0,1,0,0];         % Array to indicate which information
 
 Card = [ones(1,NumbVar);NumbVar*ones(1,NumbVar)];            % All variables have values between 1 and NumbVar
 edaparams{1} = {'seeding_pop_method','InitPermutations',{}}; % The initial population is uniquely composed of permutations 
 edaparams{2} = {'learning_method','GMallows_cayley_learning',{-10.001,10,100,'setMedianPermutation'}};          % Parameters of the learning algorithm
 edaparams{3} = {'sampling_method','GMallows_cayley_sampling',{PopSize-1,1}};                                    % Parameters of the sampling algorithm
 edaparams{4} = {'replacement_method','pop_agregation',{'fitness_ordering'}};                                    % Pop. agregation is used as replacement method, Pop + sampled pop 
 selparams(1:2) = {NumbVar/PopSize,'fitness_ordering'};                                                          % Parameters used for selection (Truncation parameter and max_gen)
 edaparams{5} = {'selection_method','truncation_selection',selparams};                                           % Selection method used
 edaparams{6} = {'stop_cond_method','max_gen',{ngen}};                                                           % The algorithm stops when the max number of generations is reached

   
elseif type_function==3,     
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%- Sobre el PFSP, aplicaremos el GMallows-Kendall
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 global PFSPInstance                         % The selected PSFP instance is saved in the global variable PFSPInstance
 ReadPFSPInstance('tai50_20_0.fsp');         % PFSP (Taillard Benchmark -> tai50_20_0.fsp, n=50).
 
  [processingtimes, machines, jobs] = PFSPInstance{:}; n = jobs;    % PFSP    Problem
 
  
 ngen = 500;                   % Number of generations 
 NumbVar = n;                  % Number of variables
 PopSize = 10*NumbVar;         % Population size
 F = 'EvalPFSP';               % Optimization problem     [It should be modified according to the problem]
 cache  = [0,0,1,0,0];         % Array to indicate which information
 
 Card = [ones(1,NumbVar);NumbVar*ones(1,NumbVar)];            % All variables have values between 1 and NumbVar
 edaparams{1} = {'seeding_pop_method','InitPermutations',{}}; % The initial population is uniquely composed of permutations 
 edaparams{2} = {'learning_method','GMallows_kendall_learning',{-10.001,10,100,'setMedianPermutation'}};          % Parameters of the learning algorithm
 edaparams{3} = {'sampling_method','GMallows_kendall_sampling',{PopSize-1,1}};                                    % Parameters of the sampling algorithm
 edaparams{4} = {'replacement_method','pop_agregation',{'fitness_ordering'}};                                    % Pop. agregation is used as replacement method, Pop + sampled pop 
 selparams(1:2) = {NumbVar/PopSize,'fitness_ordering'};                                                          % Parameters used for selection (Truncation parameter and max_gen)
 edaparams{5} = {'selection_method','truncation_selection',selparams};                                           % Selection method used
 edaparams{6} = {'stop_cond_method','max_gen',{ngen}};                                                           % The algorithm stops when the max number of generations is reached

end
   
 Expe_AllStat = [];
 Expe_AllCache = [];
 Expe_AllTimes = {}
 
 for j=1:number_experiments,
   [AllStat,Cache]=RunEDA(PopSize,NumbVar,F,Card,cache,edaparams);   
   for i=1:ngen, 
     Expe_AllBest(j,i) = AllStat{i,1}(1);  
     Expe_AllStat(j,i) = AllStat{i,1}(2);
     Expe_AllTimes{j}(i,:) = AllStat{i,6};
     Expe_AllCache(j,i) = mean(Cache{3,i}{3});
   end
 end
 
 fname = ['Results_TOMs_Problem_With_Best',num2str(type_function),'.mat']
 eval(['save ',fname, ' Expe_AllCache Expe_AllStat Expe_AllBest Expe_AllTimes'])
 
  % if  type_function==1
   % for i=1:ngen,                                                                                                 % We extract mean fitness in each  generation   
  %   bestf(i,:) = AllStat{i,1};
 %    theta_param(i) = Cache{3,i}{3};
  %  end    
%   else iftype_function>2,
%    for i=1:ngen,                                                                                                   
%     bestf(i,:) = AllStat{i,1};
 %    theta_param(i) = mean(Cache{3,i}{3});
%    end     
 %  end

   

   
   