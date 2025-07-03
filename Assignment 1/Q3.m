clear all; 
clc;

x = [1,1]; % initial guess
x = fsolve(@myfunc,x);
X_sol = x(1);
y_sol = x(2);