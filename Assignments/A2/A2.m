% Code for assignment 02 - Sofia Palacios Cuevas
%% Q4
load("Assignments\A2\Q4.mat");
% a.1 Cirtcuit simplification
% Round 1
R12 = supporting_functions.rp([R1 R2]);             % parallel (red)
R56 = supporting_functions.rp([R5 R6]);             % parallel (red)
R89 = R8 + R9;                                      % series (blue)
% Round 2
R789 = supporting_functions.rp([R7 R89]);           % parallel (red)
% Round 3
R56789 = R56 + R789;                                % series (blue)
% Round 4
R356789 = supporting_functions.rp([R3 R56789]);     % parallel (red);

% a.2. Calculation of V_th
V_th = (R356789 / (R356789 + R12)) * Vs;            % voltage divider

% a.3. Calculation of R_th 
R_th = supporting_functions.rp([R12 R356789]);      % parallel (red);

% b.1 Calculation of I through R4
I = V_th / (R4 + R_th);

% b.2 Calculation of I through R4
P = (I^2) * R4;

fprintf('Thevenin Voltage: %.2f V \n', V_th);
fprintf('Thevenin Resistance: %.2f Ohms \n', R_th);
fprintf('Current trough R4: %.2f mA \n', I*1000);
fprintf('Power dissipated in R4: %.2f mW \n', P*1000);

%% Q5
i_N = zeros(101,1);
v = 0:0.1:10;
for i = 1:101
    i_N(i) = Q5(v(i));
end

Geq = (i_N(2) - i_N(1))/0.1;        % Geq = 1
figure
plot(v,i_N)
xlabel("Input voltage (V)");
ylabel("Output current (A)");
title("Driving-point current at terminal a");

% i = Geq*v - i_N
% i = v - i_N 

