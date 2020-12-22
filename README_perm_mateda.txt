
Main Features of perm_mateda
-----------------------------

- Implementation of Mallows and Generalized Mallows models.
- Implementation of Cayley, Kendall, and Ulam distances between permutations.
- Implementation of a number of optimization problems: Traveling Salesman Problem (TSP), Permutation Flowshop Scheduling Problem (PFSP), Linear Ordering Problem (LOP), and Quadratic Assignment Problem (QAP).
- As a control, implementation of previous edge-histogram-based (EHM) and node-histogram-based (NHM) approaches to permutation problems [Tsutsui:2006] have been included.


Organization of the permutation directory
-----------------------------------------
Distances: Implementation of Cayley, Kendall, and Ulam distances.         
Consensus: Comprises the implementation of different methods for computing the consensus permutation given a set of permutations.            
Mallows: Contains the implementation of the learning and sampling methods based on Mallows probabilistic models that used different distances.       
Histogram_Models: Contains the implementation of the EHM and NHM models. These are histogram-based models included for the sake of comparison with previous approaches.
Problems: Implementation of TSP, PFSP, LOP, and QAP problems. It also contains test instances for these problems. 
Scripts_Perm_Mateda: Contains a number of examples of using the Mallows EDAs in using different parameters and for different problems. It also contains post-processing steps for extracting and visualizing the results of the algorithms.   
Operations: Contains a number of auxiliary functions, including two dependencies used for the generation of Ferrer Shapes. Programs colex.m and partition.m


A quick introduction to perm_mateda with a set of examples.
----------------------------------------------------------

- A number of examples are included in the directory Scripts_Perm_Mateda

Example 1:  Application of Mallows EDA using the Ulam distance to the PFSP problem
Example 2:  Application of Generalized Mallows EDA using the Cayley distance to the LOP problem
Example 3:  Application of Generalized Mallows EDA using the Kendall distance to the LOP problem
Example 4:  Application of Mallows EDA using the Cayley distance to the QAP problem
Example 5:  Application of Mallows EDA using the Kendall distance to the TSP problem



Some useful references:
----------------------------------------------------------


E. Irurozki, J. Ceberio, B. Calvo, J.A. Lozano. Mallows model under the Ulam distance: a feasible combinatorial approach. Neural Information Processing Systems 2014, Workshop on Analysis of Rank Data, Montreal, Canada 8-13 December 2014.
J. Ceberio,  A. Mendiburu, J.A Lozano: Introducing the Mallows Model on Estimation of Distribution Algorithms. In Proceedings of International Conference on Neural Information Processing (ICONIP), 2011
J. Ceberio, E. Irurozki, A. Mendiburu, J.A. Lozano. A Review of Distances for the Mallows and Generalized Mallows Estimation of Distribution Algorithms. Journal of Computational Optimization and Applications. Vol. 62, No. 2, Pp. 545-564.
J. Ceberio, R. Santana, A. Mendiburu, J.A. Lozano. Mixtures of Generalized Mallows models for solving the Quadratic Assignment Problem. 2015 IEEE Congress on Evolutionary Computation (CEC-2015),pp.2050-2057, Sendai, Japan, 25-28 May 2015.
S. Tsutsui. Node histogram vs. edge histogram: A comparison of probabilistic model-building genetic algorithms in permutation domains. In: Evolutionary Computation, 2006. CEC 2006. IEEE Congress on. IEEE, 2006. p. 1939-1946.







