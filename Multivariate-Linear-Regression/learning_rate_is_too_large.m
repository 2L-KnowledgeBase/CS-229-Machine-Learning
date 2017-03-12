% Exercise 3 -- Multivariate Linear Regression

clear all; close all; clc

x = load('ex3x.dat'); 
y = load('ex3y.dat');

m = length(y);

% Add intercept term to x
x = [ones(m, 1), x];

% Save a copy of the unscaled features for later
x_unscaled = x;

% Scale features and set them to zero mean
mu = mean(x);
sigma = std(x);
x(:,2) = (x(:,2) - mu(2))./ sigma(2);
x(:,3) = (x(:,3) - mu(3))./ sigma(3);

% Prepare for plotting
figure;


% Gradient Descent 
alpha = 1.4;
MAX_ITR = 100;

theta = zeros(size(x(1,:)))'; % initialize fitting parameters
J = zeros(MAX_ITR, 1);

for num_iterations = 1:MAX_ITR
    % Calculate the J term
    J(num_iterations) = (0.5/m) .* (x * theta - y)' * (x * theta - y);
    
    % The gradient
    grad = (1/m) .* x' * ((x * theta) - y);
    
    % Here is the actual update
    theta = theta - alpha .* grad;
end
% Now plot the first 50 J terms
plot(0:49, J(1:50), 'r', 'LineWidth', 2)
hold on

legend('1.4')
xlabel('Number of iterations')
ylabel('Cost J')
title('learning rate is too large')

