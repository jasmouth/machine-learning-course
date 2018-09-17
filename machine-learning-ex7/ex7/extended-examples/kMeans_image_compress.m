% This script will load an image and compress the image by reducing the number of colors.
clear; close all; clc;

% The parent path is added to enable calling the defined functions.
addpath('../')

fprintf('\nRunning K-Means clustering on pixels from an image.\n\n');

Img = double(imread('sunset.jpg'));
% Divide the pixels by 255 so that each value is between 0 and 1
Img /= 255;
img_size = size(Img);

% Reshape the image into an Nx3 matrix where N = number of pixels.
% Each row will contain the Red, Green and Blue pixel values
% This gives us our dataset matrix X that we will use K-Means on.
X = reshape(Img, img_size(1) * img_size(2), 3);

% K is the number of clusters (colors) that the image will be reduced to.
K = 16;
% The maximum number of iterations to perform K-Means for.
max_iters = 10;

fprintf('\nInitializing the cluster centroids.\n\n');
initial_centroids = kMeansInitCentroids(X, K);

fprintf('\nRunning K-Means. (This may take a minute...)\n\n');
% All of the data needed to store the compressed image is now stored in centroids and idx.
% centroids contains the reduced color set, and idx contains the ID of the color in centroids for
% each pixel (i.e. idx(256) == 2 means that pixel 256 should be the second color in centroids).
[centroids, idx] = runkMeans(X, initial_centroids, max_iters);

fprintf('\nApplying K-Means to compress an image.\n\n');
% The compressed image can be reconstructed now.
recovered_image = centroids(idx, :);
% The recovered image is now reshaped to the original dimensions.
recovered_image = reshape(recovered_image, img_size(1), img_size(2), 3);

% Display the original image 
subplot(1, 2, 1);
imagesc(Img);
title('Original');

% Display compressed image to the side
subplot(1, 2, 2);
imagesc(recovered_image);
title(sprintf('Compressed to %d colors.', K));

fprintf('Program paused. Press enter to continue.\n');
pause;
