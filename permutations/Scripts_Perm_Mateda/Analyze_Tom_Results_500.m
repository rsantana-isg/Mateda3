
ngen = 500
nrep = 30
for type_function=1:3,     
  fname = ['Results_TOMs_Problem_With_Best',num2str(type_function),'.mat']
  eval(['load ',fname])
  
  MeanFitness = mean(Expe_AllStat);
  MeanThetas  = mean(Expe_AllCache);
  MeanBest = mean(Expe_AllBest);
  
   
  Times_by_Gen = zeros(ngen,8);  
  for j=1:nrep,     
     Times_by_Gen = Times_by_Gen + Expe_AllTimes{j};     
  end
  
  MeanTimesByGen = [Times_by_Gen'/nrep];
  
  for j=1:nrep,     
     MeanExpe_AllTimes(j,:) = mean(Expe_AllTimes{j});     
  end
  
  TimesAlgorithms(type_function,:) = mean(MeanExpe_AllTimes);
  
  AllData = [MeanBest;MeanFitness;MeanThetas];
  fit_theta_fname = ['TOMs_Problem_WithBest_',num2str(type_function),'_FitThetas.csv'];
  time_fname = ['TOMs_Problem_WithBest_',num2str(type_function),'_Times.csv'];
   
  dlmwrite(fit_theta_fname,AllData,'delimiter',' ','precision',16);
  dlmwrite(time_fname,MeanTimesByGen,'delimiter',' ','precision',16);
end  

dlmwrite('Summary_Times_Three_Algs_WithBest.csv',TimesAlgorithms,'delimiter',' ','precision',16);
