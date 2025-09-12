% Q6.m
% Plots the raw data and a straight fitted line.

% The data
x = [0 4 9 15 20];      % Voltage (mV)
y = [68 59 48 34 23]    % Pen position (mm)

% 1st-order least-squares fit
p = polyfit(x,y,1);
yfit = polyval(p, x)

clf
plot(x, y, 'o', x, yfit, 'r--')
xlabel('Input Voltage (mV)')
ylabel('Pen Position (mm)')
title('Input Voltage vs. Pen Position')
legend('Experimental data', 'Straight-line fit')