function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

min_error = 1.0;
vals = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
curr_c = curr_sigma = 0.0;

for i = 1:numel(vals),
    curr_c = vals(i);
    for j = 1:numel(vals),
        curr_sigma = vals(j);
        fprintf('#######################################\n');
        model = svmTrain(X, y, curr_c, @(x1, x2) gaussianKernel(x1, x2, curr_sigma));
        predictions = svmPredict(model, Xval);
        curr_error = mean(double(predictions ~= yval));
        fprintf(['Given C: %f, sigma: %f, Prediction error was: %f\n\n'], curr_c, curr_sigma, ...
            curr_error);
        if (curr_error < min_error),
            min_error = curr_error;
            C = curr_c;
            sigma = curr_sigma;
        endif
    endfor
endfor
fprintf(['Minimum Prediction error: %f\n'], min_error);
% =========================================================================

end
