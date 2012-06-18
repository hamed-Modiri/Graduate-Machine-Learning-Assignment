% Jun Xie
% xie@eecs.oregonstate.edu

% Train AdaBoost algorithm

function [trainErr, testErr] = trainadaboost(train, test, iteration_number)

% Initialize the weight to zero
initial_weight = ones(size(train,1),1)/size(train,1);
tree_root = zeros(iteration_number,3);
error = zeros(iteration_number,1);

%a is the voted vector for different learned hypothesis
a = zeros(iteration_number,1);

for i = 1:iteration_number

    % build the stump tree according to the training dataset and weight
    tree_root(i,:) = build_stump (train, initial_weight);

    x = (train(train(:,tree_root(i,1)+1)==0,1)~=tree_root(i,2));
    y = (train(train(:,tree_root(i,1)+1)==1,1)~=tree_root(i,3));

    error_induction0 = initial_weight(train(:,tree_root(i,1)+1)==0);
    error_induction1 = initial_weight(train(:,tree_root(i,1)+1)==1);

    error(i) = sum(error_induction0(x))+sum(error_induction1(y));
    a(i) = 0.5*log((1-error(i))/error(i)); 
    
    %updating weights
    error_induction0(x) = error_induction0(x) * exp(a(i));
    error_induction0(~x) = error_induction0(~x) * exp(-a(i));
    initial_weight(train(:,tree_root(i,1)+1)==0) = error_induction0;
    error_induction1(y) = error_induction1(y) * exp(a(i));
    error_induction1(~y) = error_induction1(~y) * exp(-a(i));
    initial_weight(train(:,tree_root(i,1)+1)==1) = error_induction1;

    %normalize weights
    initial_weight = initial_weight/sum(initial_weight);
end

trainErr = 0;
testErr = 0;

%calculate training error for training data
trainErr = eval_adaboost(train, tree_root, iteration_number, a);
testErr = eval_adaboost(test, tree_root, iteration_number, a);

%calculate percentage of traning and testing error
trainErr = trainErr/length(train);
testErr = testErr/length(test);

end

