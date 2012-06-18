%% Jun Xie
% Implementation for voted perceptron algortihm 

function miserror = votedperceptronforiris(dataset)

%input datasets: features and labels
[training_number, training_column] = size(dataset);
training_labels = dataset(:, 1);
training_features = dataset(:, 2:training_column);
training_features = [ones(training_number, 1), training_features];

w = zeros(training_column, 1);
k = 1;

W = [];
W(:, 1) = w;
C = [];
C(1) = 0;
w_avg = w;
feature = [training_features, training_labels];

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

for j=1:length(C)

    w_avg = w_avg + C(j) *  W(:, j);
end

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

hold on;

x4 = -w_avg(1)/w_avg(3) - (w_avg(2) / w_avg(3)) * dataset(:,2);
plot(dataset(:,2), x4, '-.b');
%{
hold on;
k = 1 / (w(2) / w(3));
x3 =k * dataset(:,2);
plot(dataset(:,2), x3, '-.m');
%}
