function[] = InitEnvironments()
% [] = InitEnvironments()
%
% InitEnvironments:           Initialize the environment of mateda
%                             update the paths below according the
%                             location of the programs in your computer.             
%
% Last version 12/21/2020. Roberto Santana (roberto.santana@ehu.es)       


%path_mateda =  '~/Dropbox/Colaborations/Mateda3';
path_mateda =  '~/Work/git/Mateda3';

P = genpath(path_mateda);
addpath(P);
cd(path_mateda);



% Last version 12/21/2020. Roberto Santana (roberto.santana@ehu.eus) 
