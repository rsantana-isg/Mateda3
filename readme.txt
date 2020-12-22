For a preliminary explanation of Mateda see the file Mateda2.0-UserGuide.pdf in this directory.
General documentation about the programs is available in the /doc directory or from:
http://www.sc.ehu.es/ccwbayes/members/rsantana/software/matlab/MATEDA.html

MATEDA3.0 employs the Matlab Bayes Net (BNT) toolbox (Murphy:2001) and the pmtk3-master library (https://github.com/probml/pmtk3) which have been included within the Mateda3 repository 
Some of the MATEDA3.0 routines also employs the MATLAB statistical toolbox and the affinity propagation  clustering algorithm (Frey_and_Dueck:2007)

To start the library: 
 1) Edit file InitEnvironment.m updating the path path_MATEDA
  
 2) Set the current Matlab directory to the MATEDA3 directory.
 
 3) Execute program InitEnvironments.m.


The folder ScriptsMateda contains several  examples of EDAs implementations. The file Mateda2.0-UserGuide.pdf contains a detailed explanation of how to use the programs. 

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 


Citations:

Santana, Roberto, Concha Bielza, Pedro Larranaga, Jose A. Lozano, Carlos Echegoyen, Alexander Mendiburu, Rubén Armananzas, and Siddartha Shakya. "Mateda-2.0: Estimation of distribution algorithms in MATLAB." Journal of Statistical Software 35, no. 7 (2010): 1-30.

Irurozki E, Ceberio J, Santamaria J, Santana R, Mendiburu A. Algorithm 989: perm_mateda: A Matlab Toolbox of Estimation of Distribution Algorithms for Permutation-based Combinatorial Optimization Problems. ACM Transactions on Mathematical Software (TOMS). 2018 Jul 26;44(4):1-3.


Last version 12/22/2020. Roberto Santana (roberto.santana@ehu.es)       
