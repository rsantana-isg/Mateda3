function[NEW_GRAPH,MAPVERT,MAPEDGE]=relabelgraph(ED)
%returns the new graphical structure 
%and the mapping between old and new graphs
      NODES=ED.V;
      UNSHRUNK=setdiff(NODES,ED.VERTICESINCKT);%nodes not in 
      SHRUNK=ED.VERTICESINCKT;    
     % first find the mapping of vertices
      destcount=2;
      for i=1:numel(NODES)
            if ismember(NODES(i),SHRUNK)
                MAPVERT(i,:)=[NODES(i),1];
            else
                MAPVERT(i,:)=[NODES(i),destcount];  
                destcount=destcount+1;
            end  
      end

NEW_GRAPH.V=unique( MAPVERT(:,2));
     

      %%now obtaining relabelled graphs
    destcount=1; NEW_GRAPH.BE=[];NEW_GRAPH.E=[];
    for i=1:numel(ED.E(:,1))
        ARC=ED.E(i,:);
        SP=ARC(1);EP=ARC(2);WT=ARC(3);%start end and weight
        if ismember(SP,SHRUNK)==0 && ismember(EP,SHRUNK)==0 
            'No changes this just relabelling'
            ISP=MAPVERT(find(MAPVERT(:,1)==SP),2);
            IEP=MAPVERT(find(MAPVERT(:,1)==EP),2);
            NEW_GRAPH.E(destcount,:)=[ISP,IEP,WT];
            
            if(ismember(i,ED.BE))
                NEW_GRAPH.BE=[NEW_GRAPH.BE,destcount]
            end
            MAPEDGE(i,:)=[i,destcount];
            destcount=destcount+1;
            
        elseif (ismember(SP,SHRUNK)==1 && ismember(EP,SHRUNK)==0)
            
            'No changes this just relabelling'
            ISP=MAPVERT(find(MAPVERT(:,1)==SP),2);
            IEP=MAPVERT(find(MAPVERT(:,1)==EP),2);
            NEW_GRAPH.E(destcount,:)=[ISP,IEP,WT];
            
            if(ismember(i,ED.BE))
                NEW_GRAPH.BE=[NEW_GRAPH.BE,destcount]
            end
            MAPEDGE(i,:)=[i,destcount];
            destcount=destcount+1;
  
        elseif (ismember(SP,SHRUNK)==0 && ismember(EP,SHRUNK)==1) 
            'Need changes in weight';
            ISP=MAPVERT(find(MAPVERT(:,1)==SP),2);
            IEP=MAPVERT(find(MAPVERT(:,1)==EP),2);
            
            [MINWTINCKTWT,INCIDENTCKTWT]=finde0e1(ED,EP);
            
            NEWWT=WT+MINWTINCKTWT-INCIDENTCKTWT;
            NEW_GRAPH.E(destcount,:)=[ISP,IEP,NEWWT];
            if(ismember(i,ED.BE))
                NEW_GRAPH.BE=[NEW_GRAPH.BE,destcount]
            end
            MAPEDGE(i,:)=[i,destcount];
            destcount=destcount+1;
            
        else %ismember(SP,SHRUNK)==1 && ismember(EP,SHRUNK)==1
            

            MAPEDGE(i,:)=[i,-1];
            
            'Bucket Edges inside CKT Dropped, totally inside circuit' ;
        end
        
        
    end
          
      % see where BV maps to
      count=1; NEW_GRAPH.BV=[];
      for i=1:numel(ED.BV)
           if ismember(ED.BV(i),SHRUNK)==0
            IND=find(MAPVERT(:,1)==ED.BV(i));
            NEW_GRAPH.BV(count)=MAPVERT(IND,2);
            count=count+1;
           end
      end
      if count>1
         NEW_GRAPH.BV=unique(NEW_GRAPH.BV);
      end
      


     
function[min_wt_in_ckt,incident_wt_in_ckt]=finde0e1(ED,EP) 

%first thing is to find edges which are in circuit 
   INBE= ED.E(ED.BE,:); % in BE
   count=1;
   for i=1:numel(ED.BE)
       if sum(ismember(INBE(i,1:2),ED.VERTICESINCKT))==2
        ISCKTEDGE(count,:)=INBE(i,:);
        count=count+1;
       end
   end
   % now find the minimum
   min_wt_in_ckt=min(ISCKTEDGE(:,3));
   
   %now find the one incident on EP
   INDEXofINCIDENT=find(ISCKTEDGE(:,2)==EP);
   
   incident_wt_in_ckt=ISCKTEDGE(INDEXofINCIDENT,3);
   return

    



      