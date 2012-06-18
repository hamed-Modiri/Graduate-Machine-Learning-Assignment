% Calculate the Sum of Squared Error(SSE)
% Learning here means to find a good set of parameters w to minimize the following loss function
% The formula is SSE= 1/2 * sum_{i=1}^{n}(y_{i} - hat(y_{i})).^2

function sumsquarederror = see(y, yhat)

sumsquarederror = 0.5 * (y - yhat).' * (y - yhat);

end
