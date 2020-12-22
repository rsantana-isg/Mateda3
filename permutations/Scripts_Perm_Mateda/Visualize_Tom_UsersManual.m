      
  figure  
  plot(Expe_AllStat(1:100),'o');
  a = get(gca,'XTickLabel');
  set(gca,'XTickLabel',a,'FontName','Times','fontsize',14); 
  xlabel('Generations','FontName','Times','fontsize',16);
  ylabel('Fitness','FontName','Times','fontsize',16);
  fname = ['Manual_Mean_Fitness.eps']
  saveas(gcf,fname, 'eps')
  
  
  figure  
  plot(MeanTheta(1:100),'o');
  a = get(gca,'XTickLabel');
  set(gca,'XTickLabel',a,'FontName','Times','fontsize',14); 
  xlabel('Generations','FontName','Times','fontsize',16);
  ylabel('Theta','FontName','Times','fontsize',16);
  fname = ['Manual_Theta.eps']
  saveas(gcf,fname, 'eps')

  
  
