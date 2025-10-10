% Q3a primer
% Illustration how to use Q3_OpEq

% Given circuit parameters.
Ri = 10e3;
Rf = 2*Ri;

% Op amp gain. Arbitrarily set to a large constant for demonstration only.
% You must set it appropriately.
% Av = 1e3;
A0 = 1e5;   % Convert from dB --> A0_dB = 100 dB --> 10^100/20 = 10^5
w0 = 20*pi; % 20π rad/s
s = tf('s');

% Open-loop dynamic gain
Av = (A0*w0)/(s + w0);
% Closed-loop transfer fn
H = Q3_OpEqn(Ri, Rf, Av);

figure
bode(H)
grid on
title('System Frequency Response');
