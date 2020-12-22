function [w,output] = boundOptL1Stepwise(X,Y,lambda)
% Fit the weights for L1 penalized multinomial logistic regression by
% updating each component of each weight sequentially in O(ndc)time where n
% is the number of training examples, d is the number of dimensions and c
% is the number of classes. 
%
% Inputs: 
% 
% X             nexamples-by-ndimensions
% Y             nexamples-by-nclasses (1 of C encoding)
% lambda        L1 regularizer
%
% Outputs:
%
% w             ndimensions-by-(nclasses-1) regression weights
%
% ouptut        a structure: ouptut.ftrace stores the negative log likelihood
%               evaluated after each iteration. It is of fixed size and may be
%               padded at the end with negative ones to make this function eml
%               comliant. output.iter stores the number of iterations and
%               output.converged is true iff the algorithm converged before the
%               maximum number of iterations was reached.

% This file is from pmtk3.googlecode.com


%PMTKauthor Balaji Krishnapuram
%PMTKmodified Kevin Murphy, Matt Dunham


    [nexamples,nclasses]    =size(Y); %#ok
    [nexamples,ndimensions] =size(X);
    convergence_tol=1e-4;               
    maxiters = 10000;
    
    %soft = @(a,b)sign(a)*max(0,abs(a)-b); % The soft function from eq 15 SMLR paper
    
    % Precompute as much as we can
    
    % Surrogate for Hessian: eq 8 in SMLR paper
    B = kron((-1/2)*(eye(nclasses-1) - (ones(nclasses-1)/nclasses)),X'*X); 
    
    XY=X'*Y(:,1:(nclasses-1));                   % [ndimensions-by-(nclasses-1)]
    
    % These values are updated each iteration. E, S relate to the
    % multiSigmoid probabilities, which are updated sequentially as well. 
    Xw=zeros(nexamples,nclasses-1); % Product Xw
    
    % Begin with uniform probabilities since w is all zeros
    E=ones(nexamples,nclasses-1);   % P numerator
    S=nclasses*ones(nexamples,1);   % P denomenator
   
    w=zeros(ndimensions,nclasses-1);
    w_prev=w;   
    k=1;      % the row index of the weight currently being updated
    c=1;      % the col index into w, i.e. the component of weight k for class c
    
    ftrace = -ones(maxiters,1);
    converged=false; 
    iter=1; 
    % A single loop calculates an updated value for the cth component of
    % the kth weight, i.e w(k,c). 
    while (not(converged))
        WkcPrev=w(k,c);          
        P=E(:,c)./S;                                                       % sigmoid probabilities 
        grad_kc=(XY(k,c)-(X(:,k))'*P);                                     % (k,c)th component of the full gradient           
         
        %WkcNew = soft(WkcPrev - grad_kc/B(k,k),-lambda/B(k,k));           % equation 15 smlr paper
        a = WkcPrev - grad_kc/B(k,k);
        b = -lambda/B(k,k);
        WkcNew = sign(a)*max(0,abs(a)-b);
        Xw(:,c)=Xw(:,c)+X(:,k)*(WkcNew-WkcPrev);
        
        E_new_c=exp(Xw(:,c));
        S=S+(E_new_c-E(:,c));
        E(:,c)=E_new_c;
        w(k,c)=WkcNew;
        c=mod(c,nclasses-1)+1;     
        if c==1 % then all c components of the kth weight have been updated
            k=mod(k,ndimensions)+1;  
            if k==1
                iter = iter + 1;  % increment after each cycle
                %assess convergence after completing a full cycle
                incr = norm(w_prev(:)-w(:))/(norm(w_prev(:)));
                converged=(incr<convergence_tol);
                w_prev=w; 
                 if nargout > 1
                    probs =(multiSigmoid(X,w));
                    log_likelihood =  sum(sum(Y.*log(probs)));
                    log_posterior = log_likelihood - lambda*(w(:)'*w(:));
                    ftrace(iter) = -log_posterior;
                end
                if(iter >= maxiters)
                    break;
                end
            end
        end
    end
    output.ftrace = ftrace;
    output.iter = iter;
    output.converged = converged;
end
