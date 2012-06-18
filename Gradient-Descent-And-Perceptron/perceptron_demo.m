% Jun Xie
% Implementation for the batch perceptron and voted perceptron demo

% Parameters: dataset, in this case, there are two datasets, respectively twogaussian and irirs
function [miserror] = perceptron_demo(dataset)

% init weigth vector

% input datasets: features and labels
[training_number, training_column] = size(dataset);
training_labels = dataset(:, 1);
training_features = dataset(:, 2:training_column);
training_features1 = training_features;
training_features = [ones(training_number, 1), training_features];

w = zeros(training_column, 1);
w1 = zeros(training_column-1, 1); 
% call perceptron
%[weight_batch, miserror]=batchperceptron(training_features, training_labels,w);
[W, C, miserror]=votedperceptron(training_features, training_labels,w);
% predict
%y_batch=training_features * weight_batch;

mini_value = min(training_features(:,2));
max_value = max(training_features(:,2));

mini_value_3 = min(training_features(:,3));
max_value_3 = max(training_features(:,3));

x1 = mini_value + (max_value - mini_value).*rand(1000, 1);
x2 = mini_value_3 + (max_value_3 - mini_value_3).*rand(1000, 1);
x = [ones(1000, 1), x1, x2];


for i=1:1000

        for j=1:length(C)
                s = 0;
                s = s + C(j) * sign(W(:, j).' * x(i, :).') ;
        end
        y(i,1) = sign(s);
end

figure;
gscatter(x1, x2, y, 'rgb','osd');

%{
figure;
%gscatter(iris(:,2), iris(:,3), iris(:,1),'rgb','osd');
gscatter(dataset(:,2), dataset(:,3), dataset(:,1),'rgb','osd');
hold on;
x2 = -weight_batch(1)/weight_batch(3) - (weight_batch(2) / weight_batch(3)) * dataset(:,2);
plot(dataset(:,2), x2);
hold on;
k = 1 / (weight_batch(2) / weight_batch(3));
x3 =k * dataset(:,2);
% x3 = -weight_batch(1)/weight_batch(3) + k * dataset(:,2);
plot(dataset(:,2), x3);
%}

% plot prediction over origianl data
%{
figure;hold on
plot(X1(1,:),X1(2,:),'b.')
plot(X2(1,:),X2(2,:),'r.')

plot(X(1,ytag<0),X(2,ytag<0),'bo')
plot(X(1,ytag>0),X(2,ytag>0),'ro')
%legend('class -1','class +1','pred -1','pred +1')
%}
end
