
ngen = 150
for type_function=1:3,     
  fname = ['Results_TOMs_Problem',num2str(type_function),'.mat']
  eval(['load ',fname])
  
  MeanFitness = mean(Expe_AllStat);
  MeanThetas  = mean(Expe_AllCache);
   
  Times_by_Gen = zeros(150,8);  
  for j=1:50,     
     Times_by_Gen = Times_by_Gen + Expe_AllTimes{j};     
  end
  
  MeanTimesByGen = [Times_by_Gen'/50];
  
  for j=1:50,     
     MeanExpe_AllTimes(j,:) = mean(Expe_AllTimes{j});     
  end
  
  TimesAlgorithms(type_function,:) = mean(MeanExpe_AllTimes);
  
  AllData = [MeanFitness;MeanThetas];
  fit_theta_fname = ['TOMs_Problem_',num2str(type_function),'_FitThetas.csv'];
  time_fname = ['TOMs_Problem_',num2str(type_function),'_Times.csv'];
   
  dlmwrite(fit_theta_fname,AllData,'delimiter',' ','precision',16);
  dlmwrite(time_fname,MeanTimesByGen,'delimiter',' ','precision',16);
end  

dlmwrite('Summary_Times_Three_Algs.csv',TimesAlgorithms,'delimiter',' ','precision',16);
