% Example for Assignment 6 Q1

% Define global variables used by RT function.
global BETA R0 T0 KELVIN

% It is important to load the .mat files first.

% Load thermistor coefficients and other parameters
% % Parameters BETA = 3965, I2 = 150e-6, KELVIN = 273.15, R0 = 10e3, T0 =
% 298.15
load problem_parameters

% Load thermometer component values.
% Note that the values do not satisfy the design requirements. They are for
% demonstration only; to show the nature of the thermometer output.
% Parameters I1 = 20e-6, R1 = 1.843e3, Rf =5.4e3, Rg = 2670
load thermo_design.mat

% Override any parameter loaded by the .mat file by assigning a new value below this line.
% This is where you would define the components for your design....
I1 = 20e-06;
I2 = 150e-06;


% Get the thermistor resistance value at 0 deg-C
RT_at_0 = RT(0)

% Evaluate thermometer operational equation at 0 deg-C
OpEq_at_0 = op_eq(R1, Rg, Rf, I1, 0)

% Evaluate circuit operational equation over [0, 100] deg-C and plot result
t = 0:1:100;
Vo = op_eq(R1, Rg, Rf, I1, t);

figure(1)     % Define where to plot (optional)
plot(t, Vo)
title('Circuit Output over 0-100 deg-C')
ylabel('Ampltitude (volts)')
xlabel('Temperature (deg-C)')
grid on


%% Design thermometer amplifier for 0–5 V output
% Global thermistor constants
global BETA R0 T0 KELVIN
BETA   = 3965;
R0     = 10e3;
T0     = 298.15;
KELVIN = 273.15;

% Define constants
I1 = 20e-6;     % Thermistor current (A)
I2 = 150e-6;    % Reference branch current (A)

% Get thermistor resistances
R_T0   = RT(0);    % at 0 °C
R_T100 = RT(100);  % at 100 °C

% Desired output span
Vout_0   = 0;      % Vout at 0 °C
Vout_100 = 5;      % Vout at 100 °C

% ---- Solve design equations ----
% 1) Vout(0°C) = (Rf/Rg)*(I1*R_T0 - I2*R1) = 0
% 2) Vout(100°C) = (Rf/Rg)*(I1*R_T100 - I2*R1) = 5

% Divide Eq2 by Eq1 to eliminate Rf/Rg ratio:
% => 5/0 = ...   (undefined) — instead we handle linearly:

% From Eq1: (Rf/Rg)*I2*R1 = (Rf/Rg)*I1*R_T0
% Substitute into Eq2:
% 5 = (Rf/Rg)*(I1*R_T100 - I1*R_T0)
%
% => Gain = (Rf/Rg) = 5 / [I1*(R_T100 - R_T0)]

Gain = 5 / (I1 * (R_T100 - R_T0));

% Now get R1 from Eq1 (Vout=0 condition):
R1 = (I1/I2) * R_T0;

% Choose a convenient resistor ratio for Rg and Rf:
Rg = 2.3e3;            % pick any standard value
Rf = Gain * Rg;        % set by desired gain

% ---- Display results ----
fprintf('--- Thermometer Design Results ---\n');
fprintf('R1 = %.2f ohms\n', R1);
fprintf('Rg = %.2f ohms\n', Rg);
fprintf('Rf = %.2f ohms\n', Rf);
fprintf('Amplifier gain (Rf/Rg) = %.2f\n', Gain);

% ---- Check circuit response ----
t = 0:1:100;
Vo = op_eq(R1, Rg, Rf, I1, t);

figure;
plot(t, Vo, 'LineWidth', 1.5);
grid on;
xlabel('Temperature (°C)');
ylabel('V_{out} (V)');
title('Designed Thermometer Output (0–100 °C)');
