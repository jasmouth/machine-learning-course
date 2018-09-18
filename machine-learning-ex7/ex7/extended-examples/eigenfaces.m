% This script will load and visualize a Face dataset. It will then compute
% the eigenfaces of the dataset using PCA, and project the faces to
% a lower dimension.
clear; close all; clc;

% The parent path is added to enable calling the predefined functions.
addpath('../');

fprintf('\nLoading face dataset.\n');
% The face dataset is loaded into the variable X
load ('ex7faces.mat')

%  Display the first 100 faces in the dataset
displayData(X(1:100, :));

fprintf('Program paused. Press enter to continue.\n');
pause;

fprintf(['\nRunning PCA on face dataset.\n' ...
         '(This might take a minute or two ...)\n\n']);
tic;
% It is important that the dataset is first normalized before performing PCA.
[X_norm, mu, sigma] = featureNormalize(X);
[U, S] = pca(X_norm);
fprintf(['PCA execution took: %f seconds.\n'], toc);

fprintf('\nVisualizing the first 36 eigenfaces.\n');
% Only the first 36 eigenfaces (eigenvectors) are displayed.
displayData(U(:, 1:36)');

fprintf('Program paused. Press enter to continue.\n');
pause;

fprintf('\nComputing value of K (number of principal components).\n');
tic;

n = size(X, 2);
K = n;
total_variance = sum(diag(S)(1:n));
% K will be chosen as the smallest value that retains 99% of the data's variance
for k = 1:n,
    if sum(diag(S)(1:k)) / total_variance >= 0.99,
        K = k;
        break;
    endif
endfor

fprintf(['\nValue computed for K: %d\nComputation of K took: %f seconds.\n'], K, toc);
fprintf('\nBeginning dimension reduction for face dataset.\n');

Z = projectData(X_norm, U, K);

fprintf('\nVisualizing the reconstructed faces.\n');
% Display normalized data
figure 2;
subplot(1, 2, 1);
displayData(X_norm(1:100,:));
title('Original faces');
axis square;

% Display the reconstructed data
X_rec = recoverData(Z, U, K);
figure 2;
subplot(1, 2, 2);
displayData(X_rec(1:100,:));
title('Recovered faces');
axis square;
