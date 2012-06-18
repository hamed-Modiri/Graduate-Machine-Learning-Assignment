%% Jun Xie

function [W, C, miserror]  = votedperceptron( X, Y, W_init)

k = 1;

W = [];
W(:, 1) = W_init;
C = [];
training_number = size(X,1);
C(1) = 0;

feature = [X, Y];

for iter=1:100

  feature = feature(randperm(size(feature,1)), :);
  X = feature(:, 1:3);
  Y = feature(:, 4);
  %w_avg = W_init; 
  %for j=1:length(C)
   
  %  w_avg = w_avg + C(j) *  W(:, j);
  %end  


  for ii = 1 : size(X,1)         %cycle through training set

    u =sign(W(:,k)'*X(ii, :).');

    %u = sign(w_avg.'*X(ii, :).');
    
    if u ~= Y(ii,1) %wrong decision?
      W(:, k + 1) = W(:, k) + X(ii, :).' * Y(ii, 1);   %then add (or subtract) this point to w
      C(k+1) = 1;
      k = k+1;
    else
      C(k) = C(k) + 1;
    end 
  end

  for i=1:training_number
        s = 0;
        for j=1:length(C)

                s = s + C(j) * sign(W(:, j).' * X(i, :).') ;
        end
        y_voted(i,1) = sign(s);
  end

  miserror(iter) = sum(y_voted~= Y)/size(X,1); 
end
