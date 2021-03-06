function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returns the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%

empty_centroids = [];
for k = 1:K,
  % C_k is a column vector where each element is an index of an example in
  % X that belongs to centroid k.
  C_k = find(idx == k);
  divisor = numel(C_k);
  % If no elements belong to the centroid, it should be removed.
  if (divisor == 0),
    empty_centroids = [empty_centroids; k];
    continue;
  endif
  % The centroid k is updated to be the mean of the elements belonging to it.
  centroids(k, :) = sum(X(C_k, :)) / divisor;
endfor
% Remove all of the empty centroids.
centroids(empty_centroids, :) = [];

% =============================================================

end
