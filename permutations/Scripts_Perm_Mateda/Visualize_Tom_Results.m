
FF = load('Summary_Times_Three_Algs_WithBest.csv')

close all
figure
H = bar(FF([1,2,3],[1,3,7]),'stacked')
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Times','fontsize',14);
xticklabels({'GMEDA-Kendall (PFSP)', 'GMEDA-Cayley (QAP)','MEDA-Ulam (LOP)'});
xlabel('EDAs','FontName','Times','fontsize',16);
ylabel('Time(s)','FontName','Times','fontsize',16);
l = cell(1,3);
l{1}='sampling'; l{2}='evaluation'; l{3}='learning';    
legend(H,l);
%c = colorbar;
%c.TickLabels = {'sampling','repairing', 'evaluation','local opt.','replacement', 'selection','learning'}
%c.TickLabels = {'sampling', 'evaluation','learning'}

close all
for i=1:3,
  fit_theta_fname = ['TOMs_Problem_WithBest_',num2str(i),'_FitThetas.csv'];
    M = load(fit_theta_fname);
  if i<1,
     M(1,:) = -1*M(1,:)  % Minimization problem
     M(2,:) = -1*M(2,:)  % Minimization problem
     
  end
      
  figure  
  plot(M(1,:),'o');
  a = get(gca,'XTickLabel');
  set(gca,'XTickLabel',a,'FontName','Times','fontsize',14); 
  xlabel('Generations','FontName','Times','fontsize',16);
  ylabel('Fitness','FontName','Times','fontsize',16);
  fname = ['TOMs_Problem_WithBest_',num2str(i),'_Fitness.eps']
  saveas(gcf,fname, 'eps')
  
  
  figure  
  plot(M(3,:),'o');
  a = get(gca,'XTickLabel');
  set(gca,'XTickLabel',a,'FontName','Times','fontsize',14); 
  xlabel('Generations','FontName','Times','fontsize',16);
  ylabel('Average Theta','FontName','Times','fontsize',16);
  fname = ['TOMs_Problem_WithBest_',num2str(i),'_Theta.eps']
  saveas(gcf,fname, 'eps')
end
  
  
