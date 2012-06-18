% Jun Xie
% xie@eecs.oregonstate.edu
% Linear Regression Assignment: batch gradient descent and stochastic gradient descent

% Two parameters: regression_training and regression_testing, which represent the independent variable and dependent variable
% regression_trraining represents the training data
% regression_testing represents the testing data
function [theta_vec_batch, theta_batch, sseerr_batch, theta_vec_stochastic, theta_stochastic, sseerr_stochastic, sseconvergence_batch, sseconvergence_stochastic] = regression( regression_training, regression_testing)

% Get the features and values
[training_number, training_column]  = size(regression_training);
training_features = regression_training(:, 1:(training_column-1)); 
training_values   = regression_training(:, training_column);
[testing_number, testing_column] = size(regression_testing);
testing_features = regression_testing(:, 1:(testing_column-1));
testing_values = regression_testing(:, testing_column);

% Plus one dummy feature 
training_features = [ones(training_number, 1), training_features];
testing_features = [ones(testing_number, 1), testing_features];

% calculate the number of feature sets
feature_number = size(training_features, 2);

% initialize some variables
theta_batch = cell(1, 10);
theta_gradient = cell(1, 10);

for k=1:10
  theta_vec(:,k) = 0.1 *(k-1) * ones(feature_number, 1);
  [theta_vec_batch(:,k), theta_batch{1,k}] = batchGradientDescent(training_features, training_values, feature_number, theta_vec(:, k));
  [theta_vec_stochastic(:,k), theta_stochastic{1,k}] = stochasticGradientDescent(training_features, training_values, feature_number, theta_vec(:, k));
  
  for j=1:length(theta_batch{1,k})
    sseconvergence_batch(k,j) = see(training_values, training_features*theta_batch{1,k}(j,:).');  
  end
  for j=1:length(theta_stochastic{1,k})
    sseconvergence_stochastic(k,j) = see(training_values, training_features*theta_stochastic{1,k}(j,:).');
  end
 
  sseerr_batch(:, k) = see(testing_values, testing_features*theta_vec_batch(:,k));
  sseerr_stochastic(:, k) = see(testing_values, testing_features*theta_vec_stochastic(:,k));
end


end
