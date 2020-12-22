function[ED]=edmonds(V,E)%
%input is a directed graph, 
%V- Set of vertices [v1, v2,v3....]
%E- Set of edges is [ v1 v2 weight(v1,v2); ...] format

% Author: Ashish Choudhary, Ph.D
%         Pharmaceutical genomics division, TGEN.
%         13208,E Shea Blvd, Scottsdale, AZ 85259.
% Note/Disclaimer: This code is for academic purposes only.
% The implementation is derived from the book by Alan Gibbons.

%initialization
ED(1).BV=[];% Bucket of vertices
ED(1).BE=[];% Bucket of Edges

ED(1).V=V;
ED(1).E=E;

CURRENT_i=1;

while(1)    % breaking condition later
    
    CURRENT_i
    V=ED(CURRENT_i).V
    E=ED(CURRENT_i).E
     
    VERTICES_NOT_IN_BV=setdiff(V,ED(CURRENT_i).BV);
    
    if (numel(VERTICES_NOT_IN_BV)==0)
        break; %first phase
    end
    
    %let us add the first such
    VERTEX_ADDED=VERTICES_NOT_IN_BV(1);
    ED(CURRENT_i).BV=[ED(CURRENT_i).BV,VERTEX_ADDED];%
    
    %now check if largest incoming edge has a positive value
        
    [EDGE_VALUE,EDGE_ADDED]=index_of_max_value_incoming_edge(E,VERTEX_ADDED);
    
    if EDGE_VALUE>0 %dont do anything otherwise
        
    %upon adding check if there is a cicuit. 
    %If so, we will need to relabel everything  
    [dist,path]=iscycle([E(ED(CURRENT_i).BE,:)],E(EDGE_ADDED,1),E(EDGE_ADDED,2))
    
  
    ED(CURRENT_i).VERTICESINCKT=path;
    %now if the path was of finite length this 
    
     % now  adding to edge buckets
    ED(CURRENT_i).BE=[ED(CURRENT_i).BE,EDGE_ADDED];
    if dist<Inf              
        [GSTR,MAPVERT,MAPEDGE]=relabelgraph(ED(CURRENT_i));
        ED(CURRENT_i).MAPPINGVERT=MAPVERT;
        ED(CURRENT_i).MAPPINGEDGE=MAPEDGE;
        
        CURRENT_i=CURRENT_i+1
        ED(CURRENT_i).BV=GSTR.BV;
        ED(CURRENT_i).BE=GSTR.BE;
        ED(CURRENT_i).V=GSTR.V;
        ED(CURRENT_i).E=GSTR.E;
        
    end 
   
    
    end% end of EDGE_VALUE>0
end
    
%And now the reconstruction phase
   
%TREEMAX=reconstruct(ED);



%%
function[FLAGS]=exists_incoming_edge(G,NODEARRAY)
%finds if the nodes listed in the array have an incoming edge

for i=1:numel(NODEARRAY)
    FLAGS(i)=ismember(NODEARRAY(i),G(:,2));
end



%%
function[EDGE_VALUE,EDGE_INDEX]=index_of_max_value_incoming_edge(G,VERTEX)
%first find incoming edges
if numel(G)==0
    EDGE_VALUE=-1;
    EDGE_INDEX=NaN;
    return;
end
%
INDICES=find(G(:,2)==VERTEX)
VALUES=(G(INDICES,3));
[EDGE_VALUE,LOC]=max(VALUES);
EDGE_INDEX=INDICES(LOC);


%%
function[dist,path]=iscycle(G,S,D)
   if size(G,1)>0
       MAXN=max([S,D,max( unique(G(:,1:2)) )]);
       G=[G;MAXN,MAXN,0];
    DG = sparse(G(:,1),G(:,2),G(:,3));
    
        
  
    [dist,path]=graphshortestpath(DG,S,D);
    %if there is no path from S to D try D to S
    if dist==Inf
        [dist,path]=graphshortestpath(DG,D,S);
    end 
   else
     dist=Inf;
     path=[];
   end
   


   
  