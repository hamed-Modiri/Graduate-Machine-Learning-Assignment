% Jun Xie
% xie@eecs.oregonstate.edu
% num_boostrap: the number of how many samples

function [trainErr, testErr] = bagging_method(train, test, iteration_numble)

% calculate the length of train
train_length = length(train);
test_length = length(test);

% initialize the error
trainError = zeros(5,1);
testError = zeros(5,1);

% Run five times, because the result is not stable, so need to average
for k = 1:5

    stump_root = zeros(iteration_numble,3);

    for i = 1:iteration_numble

        permutation = ceil(train_length.*rand(train_length,1));                    
        permutationData = train(permutation,:);
        stump_root(i,:) = build_stump (permutationData);
    end
    
    % calculate the bagging error for training and testing dataset 
    trainError(k) = eval_bagging(train, stump_root, iteration_numble);
    testError(k) = eval_bagging(test, stump_root, iteration_numble); 

end    

trainErr = sum(trainError)/5/train_length;
testErr = sum(testError)/5/test_length;
end
