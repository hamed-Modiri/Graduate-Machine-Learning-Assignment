% Jun Xie
% xiej@onid.oregonstate.edu

% implement Bagging and AdaBoost using the decision stump algorithm as the base learner
function ensemble_demo(train, test)

% Iteration Number
Iters = [5, 10, 15, 20, 25, 30];

% train_error, test_error
train_error = zeros(6,2);
test_error = zeros(6,2);

% Execute the ensemble method 
for i = 1 : length(Iters)

	[trainErr, testErr] = bagging_method (train, test, Iters(i));
    	train_error(i,1) = trainErr;
    	test_error(i,1) = testErr;
    	[trainErr, testErr] = trainadaboost (train, test, Iters(i));    
    	train_error(i,2) = trainErr;
    	test_error(i,2) = testErr;

end

% Plot the generated data
plot(Iters,[test_error, train_error]);
title ('Training and Testing Error of bagging and adaboost');
xlabel('No. of Iteration');
ylabel('Error');
legend ('Testing Error of Bagging', 'Testing Error of Adaboost', 'Training Error of Bagging', 'Training Error of Adaboost');
end 
