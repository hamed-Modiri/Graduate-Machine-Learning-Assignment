% Jun Xie
% Batch learning in contrast performs model update after observing the whole training set
%  

function [w, miserror] = batchperceptron(X,Y,w_init)

% initial weights
w = w_init;
[ w_row, w_column ] = size(w_init);

% calculate the number of instances
training_number = length(X);

% The step size and precision
alpha = 1/training_number;
precision = 0.75;

for ii = 1:100

        for i = 1 : size(X,1)         %cycle through training set
            
		u = w'*X(i, :).';
		if u * Y(i, 1) <= 0 %wrong decision?

      			w = w + X(i, :)' * Y(i, 1);   %then add (or subtract) this point to w
    		end 
        end

 	miserror(ii) = sum(sign(X * w)~=Y)/size(X,1);   %show misclassification rate 

end

