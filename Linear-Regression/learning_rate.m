% how learning rate impact Gradient Descent

clear all; close all; clc
x = load('ex2x.dat'); y = load('ex2y.dat');

m = length(y); % number of training examples

% Gradient descent
x = [ones(m, 1) x]; % Add a column of ones to x

alpha = [0.01:0.02:0.07]; 

for num_alpha = 1:length(alpha) % tune learning rate
  
  theta = zeros(size(x(1,:)))'; % initialize fitting parameters
  num_iterations = 0;
  
  % store theta in each iteration
  theta_0 = [];
  theta_1 = [];
  
  while true
      % store theta in each iteration 
      theta_0(1,num_iterations) = theta(1);
      theta_1(1,num_iterations) = theta(2);
      
      grad = (1/m).* x' * ((x * theta) - y);
      
      if abs(grad) < 0.000001 % converge, precision
        break
      end
      
      % Here is the actual update
      theta = theta - alpha(num_alpha) .* grad;
  
      num_iterations = num_iterations + 1;
  end
  % print theta to screen
  disp(sprintf('learning rate: %s',num2str(alpha(num_alpha))))
  theta
  num_iterations % max iteration depends on learning rate
  
  % Grid over which we will calculate J
  theta0_vals = linspace(-3, 3, 100);
  theta1_vals = linspace(-1, 1, 100);
  
  % initialize J_vals to a matrix of 0's
  J_vals = zeros(length(theta0_vals), length(theta1_vals));
  
  for i = 1:length(theta0_vals)
      for j = 1:length(theta1_vals)
      t = [theta0_vals(i); theta1_vals(j)];    
      J_vals(i,j) = (0.5/m) .* (x * t - y)' * (x * t - y);
      end
  end
  
  % Because of the way meshgrids work in the surf command, we need to 
  % transpose J_vals before calling surf, or else the axes will be flipped
  J_vals = J_vals';
  
  % Contour plot
  figure(num_alpha);
  % Plot J_vals as 15 contours spaced logarithmically between 0.01 and 100
  contour(theta0_vals, theta1_vals, J_vals, logspace(-2, 2, 15))
  xlabel('\theta_0'); ylabel('\theta_1');
  title(strcat('learning rate: ',num2str(alpha(num_alpha))));
  hold on;
  plot(theta_0,theta_1)
 end