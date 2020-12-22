function[TREEMAX]=reconstruct_2(ED)
%% to reconstruct ED

MAXI=numel(ED);
%%now starting reconstruction
for i=MAXI:-1:2
  RECONBUCKET=[];
  EXPANDED=0;
  % let us relabel each of the arcs in BE first here first
    for j=1:numel(ED(i).BE) % over arcs in BE
        
    INDEX=find(ED(i-1).MAPPINGEDGE(:,2)==ED(i).BE(j));
    TOBEADDED1=ED(i-1).MAPPINGEDGE(INDEX,1);
    RECONBUCKET=[RECONBUCKET, TOBEADDED1];

    end % over arcs in BE
    
  %let us look for the circuit and what caused it in previous step
  
  %find the indices in G_i-1 that caused the circuit
  
   INDICES_OF_CKT=find_ckt_edges_to_add(ED,i-1,RECONBUCKET)
  
   RECONBUCKET=[RECONBUCKET,INDICES_OF_CKT];

   
   ED(i-1).BE=RECONBUCKET;
  %




end

TREEMAX=ED(1).BE;
GTM=ED(1).E(TREEMAX,:);
GTM=sparse(GTM(:,1),GTM(:,2),GTM(:,3))
GTM(max(size(GTM)),max(size(GTM)))=0;
bg=biograph(GTM)
bg.showWeights='On'; 
view(bg);

%now getting tree with max





%%now get treemax from BE

function[INDICES]=find_ckt_edges_to_add(ED,level,RECONBUCKET) 


%first thing is to find edges which are in circuit 
   count=1;
   
   
   for i=1:numel(ED(level).BE)
       if sum(ismember(ED(level).E(ED(level).BE(i),1:2),ED(level).VERTICESINCKT))==2
        IND_CKT(count)=ED(level).BE(i);
        count=count+1;
       end
   end
   
   IND_CKT;% some of these guys will be added depending on the status of rest of them
   % now find the minimum
   
   GRAPH_TILL_NOW=ED(level).E(RECONBUCKET,:);
   NODES_WITH_OUTGOING=unique(GRAPH_TILL_NOW(:,1));
   NODES_WITH_INCOMING=unique(GRAPH_TILL_NOW(:,2));
  
   %now checking if ui is out tree
   IS_OUTTREE=numel(intersect(NODES_WITH_OUTGOING,ED(level).VERTICESINCKT));
   IS_INTREE=numel(intersect(NODES_WITH_INCOMING,ED(level).VERTICESINCKT));
   INCOMING_INTERFACEPOINT=intersect(NODES_WITH_INCOMING,ED(level).VERTICESINCKT);
   
   
   CKT=ED(level).E(IND_CKT,:);
   
   if IS_INTREE>0    
        b=find(CKT(:,2)==INCOMING_INTERFACEPOINT);
   %IND_INCIDENT_IP=IND_CKT(b);
        %find the interface point
   else
      [a,b]=min(CKT(:,3));%now 
      %IND_MINCKT=IND_CKT(b);  
   end
   
   TO_NOT_BE_INCLUDED=IND_CKT(b);
  
   
%    end
   
  INDICES=setdiff(IND_CKT,TO_NOT_BE_INCLUDED); 
    
   return

       
       
       
       
