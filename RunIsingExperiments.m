
function[] = RunIsingExperiments() 
 
 global Isinglattice;
 global Isinginter;
 
 
% Parameters of the Ising Model
 InstanceNumber = 5;
 MaxVal = 112;
 n = 64; 
 [Isinglattice, Isinginter] = LoadIsing(n, InstanceNumber);
 
 %%% Parameters of the EDA
 
 % Cardinality of the variables 
 Card = 2*ones(1,n); 
 % Function to be optimized
 F = 'EvalIsing'; 
 PopSize = 500; 
 MaxGen = 20;   
 % Which information to keep for further analysis (ALL, see Help RunEDA for
 % information about what is kept)
 cache  = [1,1,1,1,1];
 % Parameters for the stop condition
 stop_cond_params = {MaxGen,MaxVal};
 edaparams{1} = {'stop_cond_method','maxgen_maxval',stop_cond_params};
 
 
 %%% We will run different EDAs and compute the frequency with which they
 %%% find the two symmetric solutions of Ising Model (Ising Instance 6)
 %%% Solutions are: 1) All ones  2) All zeros

 %%% We compare four different EDAs:
 % Alg=1 : Tree-EDA
 % Alg=2 : UMDA
 % Alg=3 : Fixed chain-shaped model where P(X) = P(X1)*P(X2|X1)*P(X3|X2)*...* P(XN|XN-1)
 % Alg=4 : Similar to previous model but higher order cliques 
 %       : P(X) = P(X1X2)*P(X3|X1X2)*P(X4|X2X3)*...* P(XN|XN-1XN-2)
 
 % Number of Experiments to be run
 NRuns = 10;
 
     for Alg=1:4, 
     for Exp=1:NRuns,     
      [Alg,Exp]
      if(Alg==1)       
       edaparams{2} = {'learning_method','LearnTreeModel',{}};  % Tree-EDA
       edaparams{3} = {'sampling_method','SampleFDA',{PopSize}}; 
      elseif(Alg==2)
           Cliques = CreateMarkovModel(n,0); % Zero-Order Model (UMDA)
           edaparams{2} = {'learning_method','LearnFDA',{Cliques}};
           edaparams{3} = {'sampling_method','SampleFDA',{PopSize}};
      elseif(Alg==3)
           Cliques = CreateMarkovModel(n,1); % First-Order Model  
           edaparams{2} = {'learning_method','LearnFDA',{Cliques}};
           edaparams{3} = {'sampling_method','SampleFDA',{PopSize}};
      elseif(Alg==4)
           Cliques = CreateMarkovModel(n,2); % Second-Order Model 
           edaparams{2} = {'learning_method','LearnFDA',{Cliques}};
           edaparams{3} = {'sampling_method','SampleFDA',{PopSize}};
      end,
       % The EDA is run
       [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams);
      
       % AllOptima saves the Best solution found for analysis
       % Any other relevant information can be extracted here from AllStat
       % and Cache (see Help RunEDA for description of information
       % contained in AllStat and Cache)
       AllOptima{Alg,Exp} =  AllStat{end,2};
    end,
   end,

  % MatrixOptima saves the number of Ones in the optima learned by the EDAs
  
  for Alg=1:4, 
     for Exp=1:NRuns,  
       MatrixOptima(Alg,Exp) = sum(AllOptima{Alg,Exp});         
     end
  end
 
 
 