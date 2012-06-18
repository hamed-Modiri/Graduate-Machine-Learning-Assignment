% Jun Xie
% Batch learning in contrast performs model update after observing the whole training set

function twogaussianmiserror = batchperceptronfortwogaussian(dataset)


% input datasets: features and labels
[training_number, training_column] = size(dataset);
training_labels = dataset(:, 1);
training_features = dataset(:, 2:training_column);
training_features = [ones(training_number, 1), training_features];

w = zeros(training_column, 1);

% The step size and precision
alpha = 1/training_number;

% Cycle through the dataset 
for ii = 1:100

        for i = 1 : size(training_features,1)         %cycle through training set

                u = w'*training_features(i, :).';
                if u * training_labels(i, 1) <= 0 %wrong decision?

                        w = w + training_features(i, :)' * training_labels(i, 1);   %then add (or subtract) this point to w
                end
        end

        twogaussianmiserror(ii) = sum(sign(training_features * w)~=training_labels)/size(training_features,1);   %show misclassification rate 

end


figure;
gscatter(dataset(:,2), dataset(:,3), dataset(:,1),'rgb','osd');
hold on;
x2 = -w(1)/w(3) - (w(2) / w(3)) * dataset(:,2);
plot(dataset(:,2), x2);
hold on;
k = 1 / (w(2) / w(3));
x3 =k * dataset(:,2);
plot(dataset(:,2), x3, '-.m');

