% Jun Xie
% 931-856-087
% xie@eecs.oregonstate.edu

% Machine Learning Assignment 1: Linear Regression and Perceptron


function ML_Assignment1()

	load assignment1.mat;
	disp('Contents of workspace after loading file:');
        whos;

  	regression( regression_training, regression_testing);
end
