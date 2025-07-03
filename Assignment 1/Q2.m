clear all;
clc;
%% Using inbuilt function
y_1 = @(x) 2*x + 1;
y_2 = @(x) 2*x./(1+0.2*x);
% using integral function
part1 = @(x) 1./ (y_1(x) - y_2(x));
result1 = integral(part1,0,15);
result1;

%% Using proper calculation for Part-2
% on simplifying part 2, we get this function->
f = @(x) (1 + 0.2*x) ./ (1 + 0.2*x + 0.4*x.^2);

% Step size
h = 15 / 1000;

% Calculate x values (from 0 to 15 with n stepsize)
x = 0:h:15;

% Evaluate the function at each x value
y = f(x);
%{ 
Using area under the graph method(for each trapezium made from 
small step size of x and f(x)) ->
summation of area of each trapezium from limit 0-15
%}
% Use the trapz function for numerical integration
int_value = trapz(x, y);
int_value;