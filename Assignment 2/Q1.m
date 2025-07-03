clear all;
clc;
% Constants
R = 8.314;
M = 0.0287;
R_specific = R / M;
gamma = 1.4; 
Cv = 0.718;

% Initial conditions
P1 = 100;
T1 = 30 + 273.15;
V1 = 0.0038;
r = 8;
T3 = 1200 + 273.15;

% Calculations
V2 = V1 / r; % Volume after compression (m^3)
T2 = T1 * (V1 / V2)^(gamma - 1); % Temperature after compression (K)
P2 = P1 * (V1 / V2)^gamma; % Pressure after compression (kPa)
P3 = P2 * T3 / T2; % Pressure after combustion (kPa)
V3 = V2; % Volume remains constant during combustion
V4 = V1; % Volume after expansion (m^3)
T4 = T3 * (V3 / V4)^(gamma - 1); % Temperature after expansion (K)
P4 = P3 * (V3 / V4)^gamma; % Pressure after expansion (kPa)

% Heat and work calculations
Qin = Cv * (T3 - T2); % Heat addition (kJ)
Qout = Cv * (T4 - T1); % Heat rejection (kJ)
Wnet = Qin - Qout; % Net work output (kJ)
eta = 1 - (1 / r^(gamma - 1)); % Thermal efficiency
MEP = Wnet / (V1 - V2); % Mean Effective Pressure (kPa)

% Generate P-V diagram
n_points = 100;
V_compression = linspace(V1, V2, n_points);
P_compression = P1 * (V1 ./ V_compression).^gamma;

V_expansion = linspace(V3, V4, n_points);
P_expansion = P3 * (V3 ./ V_expansion).^gamma;

% Plotting
figure;
hold on;
plot([V1 V2], [P1 P2], 'r-'); % Isochoric compression
plot(V_compression, P_compression, 'b-'); % Adiabatic compression
plot([V2 V3], [P2 P3], 'r-'); % Isochoric heat addition
plot(V_expansion, P_expansion, 'b-'); % Adiabatic expansion
plot([V4 V1], [P4 P1], 'r-'); % Isochoric heat rejection
xlabel('Volume (m^3)');
ylabel('Pressure (kPa)');
title('P-V Diagram of the Ideal Otto Cycle');
legend('Isochoric Processes', 'Adiabatic Processes');
grid on;
hold off;

fprintf('Heat Rejection (Qout): %.2f kJ\n', Qout);
fprintf('Net Work Output (Wnet): %.2f kJ\n', Wnet);
fprintf('Thermal Efficiency (η): %.2f%%\n', eta * 100);
fprintf('Mean Effective Pressure (MEP): %.2f kPa\n', MEP);
