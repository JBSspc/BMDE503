% Code for assignment 4
%% PART 2
% Hearing Aid Amplifier - Bode Plot (in Hz)
clear; clc; close all;

% --- Component values ---
%R1 = 19e3;     % 19 kΩ
R2 = 1e3;       % 1 kΩ
Rf = 133e3;     % 133 kΩ
C = 82e-9;      % 82 nF
f_zero = 100;   % 100 Hz
f_pole = 2e3;   % 2kΩ
R1 = (1/(2*pi*C*f_zero)) - R2;

% Frequency vector (Hz)
f = logspace(1, 5, 1000);   % 10 Hz to 100 kHz
w = 2*pi*f;                 % convert to rad/s

% Transfer fn H(s)
s = 1j*w;
H = -(Rf/R1) .* ((1 + s*C*(R1 + R2)) ./ (1 + s*C*R2));

% Magnitude (dB) and Phase (deg)
mag = 20*log10(abs(H));
phase = angle(H) * 180/pi;

% Zero and Pole freqs
fz = 1 / (2*pi*C*(R1 + R2));
fp = 1 / (2*pi*C*R2);

% Magnitude response
figure;
semilogx(f, mag, 'LineWidth', 1.5);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Hearing Aid Amplifier Magnitude Response');
hold on;
xline(fz, '--r', sprintf('f_z = %.1f Hz', fz));
xline(fp, '--b', sprintf('f_p = %.1f Hz', fp));
legend('Magnitude','Zero','Pole','Location','Best');
exportgraphics(gcf,'Assignments/A4/ex2.png','Resolution',300)

%% PART 3
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
% hold on
% xline(2.09e6);
exportgraphics(gcf,'Assignments/A4/ex3.png','Resolution',300)

% Binary search
Alow = 1;
Ahigh = 1000;
Aideal = 3;
Avmin = Ahigh;

while Alow <= Ahigh
    Amid = floor((Alow + Ahigh)/2);
    err = Aideal/ (Amid + Aideal);
    
    if err<=0.01
        Avmin = Amid;       % We found a candidate!
        Ahigh = Amid-1;     % Need lower Av
    else
        Alow = Amid + 1;    % Need higher Av
    end
end

E = Aideal/ (Avmin + Aideal);

fprintf('min integer Av = %d , error = %.4f\n', Avmin, E);
%% PART 4
% a)

% Define Frequency Parameters
f_min = 0;      % Start frequency for the plot (Hz)
f_max = 200;    % End frequency for the plot (Hz)
f_band_start = 40; % Start of the signal frequency band (Hz)
f_band_end = 160;  % End of the signal frequency band (Hz)

% Frequency vector
f = linspace(f_min, f_max, 500); % 500 points for a smooth plot

% Input Power Spectrum (S_in)
S_in_amplitude = 9;     % W/Hz
S_in = zeros(size(f));
S_in(f >= f_band_start & f <= f_band_end) = S_in_amplitude; % Amplitude within the band [40 Hz, 160 Hz]


G = -5;

S_o_amplitude = S_in_amplitude * G^2;    % 9 * 25 = 225 W/Hz
S_o = S_in * G^2;                              % S_out(f) = S_in(f) * |H(f)|^2


figure; 
hold on; 
plot(f, S_in, 'b-', 'LineWidth', 2, 'DisplayName', 'Input Power Spectrum (S_{in})');
plot(f, S_o, 'r--', 'LineWidth', 2, 'DisplayName', 'Output Power Spectrum (S_{out})');
title('Input and Output Power Spectra for Static LTI System');
xlabel('Frequency (Hz)');
ylabel('Amplitude (W/Hz)');
grid on;
legend('Location', 'best');
axis([f_min f_max 0 S_o_amplitude * 1.1]);
exportgraphics(gcf,'Assignments/A4/ex4_a.png','Resolution',300)

%% b)
G2 = 1 ./ (4 * pi^2 * f.^2);
S_o2_amplitude = S_in_amplitude .* G2;
S_o2 = S_in .* G2; 

figure; 
plot(f, S_o2, 'r--', 'LineWidth', 2, 'DisplayName', 'Output Power Spectrum (S_{out})');
title('Output Power Spectra for Static LTI System (Integrator)');
xlabel('Frequency (Hz)');
ylabel('Amplitude (W/Hz)');
grid on;
exportgraphics(gcf,'Assignments/A4/ex4_b.png','Resolution',300)
