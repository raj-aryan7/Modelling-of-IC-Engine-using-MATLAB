clear all;
clc;

gamma = 1.35; 
P1 = 110;
T1 = 400;
T3 = 2800;
bore = 0.09; 
stroke = 0.1;
L = 0.14;
CR = 8.5;

Vswept = (pi/4) * bore^2 * stroke;
Vclearance = Vswept / (CR - 1);
V1 = Vclearance + Vswept;
V2 = Vclearance;

T2 = T1 * (V1 / V2)^(gamma - 1);
P2 = P1 * (V1 / V2)^gamma;

P3 = P2 * T3 / T2;

V3 = V2; 
V4 = V1; 
T4 = T3 * (V3 / V4)^(gamma - 1);
P4 = P3 * (V3 / V4)^gamma;

efficiency = 1 - 1 / (CR^(gamma - 1));

theta = linspace(0, 2*pi, 100); 
r = stroke / 2; 
V_compression = Vclearance + (Vswept / 2) * (1 - cos(theta) + (L / r) * (1 - sqrt(1 - (r / L)^2 * sin(theta).^2)));

%% Without Considering Piston Kinematics
n = 100;
V_comp_linear = linspace(V1, V2, n); 
P_comp_linear = P1 * (V1 ./ V_comp_linear).^gamma; 

V_exp_linear = linspace(V3, V4, n); 
P_exp_linear = P3 * (V3 ./ V_exp_linear).^gamma; 

%% With Considering Piston Kinematics
theta = linspace(0, pi, n); 
r = stroke / 2; % Crank radius
V_comp_kinematic = Vclearance + (Vswept / 2) * (1 - cos(theta) + (L / r) * (1 - sqrt(1 - (r / L)^2 .* sin(theta).^2)));
P_comp_kinematic = P1 * (V1 ./ V_comp_kinematic).^gamma;

theta_exp = linspace(pi, 2*pi, n); 
V_exp_kinematic = Vclearance + (Vswept / 2) * (1 - cos(theta_exp) + (L / r) * (1 - sqrt(1 - (r / L)^2 .* sin(theta_exp).^2)));
P_exp_kinematic = P3 * (V3 ./ V_exp_kinematic).^gamma;

%% Plotting P-V Diagrams
figure;
% Without Piston Kinematics
plot([V1, V2], [P1, P2], 'ro'); hold on;
plot(V_comp_linear, P_comp_linear, 'r-');
plot(V_exp_linear, P_exp_linear, 'b-');
plot([V3, V4], [P3, P4], 'bo');

% With Piston Kinematics
plot(V_comp_kinematic, P_comp_kinematic, 'k--');
plot(V_exp_kinematic, P_exp_kinematic, 'g--');

xlabel('Volume (m^3)');
ylabel('Pressure (kPa)');
title('Otto Cycle P-V Diagram');
legend('Compression (Linear)', 'Expansion (Linear)','Compression (Kinematics)', 'Expansion (Kinematics)', 'Location', 'Best');
grid on;

CR_vals = [7, 9, 11];
efficiencies = 1 - 1 ./ (CR_vals.^(gamma - 1));
figure;
plot(CR_vals, efficiencies * 100, 'o-');
xlabel('Compression Ratio (CR)');
ylabel('Thermal Efficiency (%)');
title('Impact of Compression Ratio on Efficiency');
grid on;