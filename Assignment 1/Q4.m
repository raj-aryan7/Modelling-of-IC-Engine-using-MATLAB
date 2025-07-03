clear all; 
clc;

% Initial guess 
x0 = [0.5, 1];  
sol = fsolve(@myfunc, x0);

xt = sol(1);
yt = sol(2);
% slope of the tangent
slope = 2 / (1 + xt)^2;

% Plot the curve and the tangent
x = linspace(-.5, 2, 100);
y = (2*x) ./ (1 + x);  % Equation of the curve

% equation of tangent: y = slope * (x - 0) + 1
tangent_line = slope * (x - 0) + 1;

% Plot of the curve and the tangent
figure;
plot(x, y, 'b'); % Curve
hold on;
plot(x, tangent_line, 'r--'); % Tangent line
legend('Curve y = 2x/(1+x)', 'Tangent line');
xlabel('x');