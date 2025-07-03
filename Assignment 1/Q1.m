clear all;
clc;

% work done,heat trans.,change in internal energy,change in enthalpy
% and plot P-V,P-T,T-V curve for each process and overall 
R = 0.08314;
C_v = 1.5*R;
C_p = 2.5*R;
n = C_p/C_v;

T_1 = 70+273;
p_1 = 1;
v_1 = (R*T_1)/p_1;

%% adiabatic Process
T_2 = 150+273;
v_2 = v_1*(T_1/T_2)^(1/(n-1));
p_2 = p_1*(v_1/v_2)^n;
w_1 = R*(T_1-T_2)/(n-1);% work done
Q_1 = 0; % (adiabatic process) heat transfer
% change in internal energy
U_1 = C_v*(T_2-T_1);
% change in enthalpy
H_1 = C_p*(T_2-T_1);

%% isobaric Process
T_3 = 70 + 273;
p_3 = p_2;
v_3 = v_2* T_3/T_2;
U_2 = C_v*(T_3-T_2); % change in internal energy
H_2 = C_p*(T_3-T_2); % change in enthalpy
Q_2 = H_2;
w_2 = 0;

%% isothermic Process
T_4 = T_3;
p_4 = p_1;
v_4 = p_3*v_3/p_4;
w_3 = R*T_3*log(v_1/v_3); % work done
Q_3 = w_3; % Heat transfer Q_3-W_3 = U_3 = 0
U_3 = 0; % change in internal energy (isothermal)
H_3 = 0; % change in enthalpy (isothermal)

%% Overall Process
% Reversible
W_total = w_1 + w_2 + w_3;
Q_total = Q_1 + Q_2 + Q_3;
U_total = U_1 + U_2 + U_3;
H_total = H_1 + H_2 + H_3;
% Irreversible
W1_irr = .75*w_1;
W2_irr = .75*w_2;
W3_irr = .75*w_3;
Q1_irr = 0; % adiabatic
Q2_irr = W2_irr + U_2;
Q3_irr = W3_irr; % U_3 = 0 (isothermal)
W_irr_total = W1_irr + W2_irr + W3_irr;
Q_irr_total = Q1_irr + Q2_irr + Q3_irr;

%% Plotting
% Adiabatic (P-V)
v_ad = linspace(v_1, v_2, 100);
p_ad = p_1 * (v_1 ./ v_ad).^n;
T_ad = T_1 * (v_1 ./ v_ad).^n-1;
w_1_area = trapz(v_ad, p_ad);

figure;
plot(v_ad,p_ad);
xlabel('Volume (L)');
ylabel('Pressure (bar)');
title('P-V adiabatic')
figure;
plot(T_ad,p_ad);
xlabel('Temperature (K)');
ylabel('Pressure (bar)');
title('P-T adiabatic')
figure;
plot(v_ad,T_ad);
xlabel('Volume (L)');
ylabel('Temperature (K)');
title('T-V adiabatic')

% Isobaric (T-V)
T_iso = linspace(T_2, T_3, 100);
v_iso = R * T_iso / p_2;
p_iso = linspace(p_2, p_3, 100);
w_2_area = trapz(v_iso, p_iso);

figure;
plot(v_iso,p_iso);
xlabel('Volume (L)');
ylabel('Pressure (bar)');
title('P-V isobaric')
figure;
plot(T_iso,p_iso);
xlabel('Temperature (K)');
ylabel('Pressure (bar)');
title('P-T isobaric')
figure;
plot(v_iso,T_iso);
xlabel('Volume (L)');
ylabel('Temperature (K)');
title('T-V isobaric')

% Isothermal (P-V)
v_isoth = linspace(v_3, v_4, 100);
p_isoth = R * T_3 ./ v_isoth;
T_isoth = linspace(T_3, T_4, 100);
w_3_area = trapz(v_isoth, p_isoth);

w_area_total = w_1_area + w_2_area + w_3_area;

figure;
plot(v_isoth,p_isoth);
xlabel('Volume (L)');
ylabel('Pressure (bar)');
title('P-V isothermal')
figure;
plot(T_isoth,p_isoth);
xlabel('Temperature (K)');
ylabel('Pressure (bar)');
title('P-T isothermal')
figure;
plot(v_isoth,T_isoth);
xlabel('Volume (L)');
ylabel('Temperature (K)');
title('T-V isothermal')