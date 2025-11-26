%% Q1
% Compute total power (sum of the magnitude)
power = m.^2;
Ptotal = sum(power);

% Find bandwidth for 95% of power
cum_power = cumsum(power);
cum_power_percentage = (cum_power/Ptotal)*100;

% Find indices that correspond to 95% power
idx_95 = idx(cum_power_percentage >= 95);
useful_freqs95 = f(idx_95);

% Recover the highest useful frequency
f_max95 = max(abs(useful_freqs95));

% Nyquist frequency (minimum sampling frequency)
fs_min = 2*f_max95;

% Compute practical minimun (using ADC resolution, 16 bits)
fs_min_practical = 10*f_max95;


% Results
fprintf('Maximum frequency for 95%% power: %.2f Hz\n', f_max95);
fprintf('Minimum sampling rate (Nyquist): %.2f Hz\n', fs_min);
fprintf('Minimum sampling rate (16-bit ADC): %.2f Hz\n', fs_min_practical);


%% Q2 Effective noise voltages
% a) 
% Given output noise densities (Figure 3)
vn1_dB = -140.055;
vn2_dB = -141.816;
vin1_dB = -138.85;
vin2_dB = -138.85;

% Convert output noise densities to linear 
vn1_linear = 10^(vn1_dB/20);
vn2_linear = 10^(vn2_dB/20);
vin1_linear = 10^(in1_dB/20);
vin2_linear = 10^(in2_dB/20);

% Static gains for each source - ideal op-amp
Ri = 100e3;
Rf = 200e3;
R = (Ri*Rf)/(Ri+Rf);
G_noninv = 1;       % For vn1, in1
G_inv = Rf/Ri;      % For vn2,in2

% Compute effective RTI noise voltages
vn1_eff = vn1_linear / G_noninv;
vn2_eff = vn2_linear / G_inv;
vin1_eff = vin1_linear / G_noninv;  
vin2_eff = vin2_linear / G_inv;


% b) Combine all RTI noise sources
vn_total = sqrt(vn1_eff^2 + vn2_eff^2 + vin1_eff^2 + vin2_eff^2);

% c) Compute the total output noise 
% (b + GBW = 5MHz + NEB)
GBW = 5e6; %5MHz
fc = GBW; % Closed-loop G = 1
NEB = (pi/2)*fc;
% Compute total output RMS noise
Vn_out = vn_total * sqrt(NEB);


% Results
fprintf('Effective vn1'' = %.2e V/sqrt(Hz)\n', vn1_eff);
fprintf('Effective vn2'' = %.2e V/sqrt(Hz)\n', vn2_eff);
fprintf('Effective vin1'' = %.2e V/sqrt(Hz)\n', vin1_eff);
fprintf('Effective vin2'' = %.2e V/sqrt(Hz)\n', vin2_eff);
fprintf('Total input-referred noise = %.2e V/sqrt(Hz)\n', vn_total);
fprintf('Total output noise = %.2e V\n', Vn_out);


%% Q3
ratio = (1.53e-4) / 10;
G_nyquist = 20*log10(ratio);
% Given parameters
fs = 1500;              % Sampling rate (Hz)
fN = fs/2;              % Nyquist frequency (Hz)
attenuation = 1.53e-5;  % Required gain at Nyquist
n = 8;                  % Butterworth order

% Compute cutoff frequency
ratio = (1/attenuation^2) - 1;
fc = fN / ratio^(1/(2*n));   % Cutoff frequency in Hz
wc = 2 * pi * fc;            % Convert to rad/s for AAfilter

fprintf('Required cutoff frequency: %.2f Hz\n', fc);

% Generate filter transfer function (AAfilter)
h = AAfilter(wc);

% Bode plot for magnitude response
figure;
[mag, phase, wout] = bode(h); 
mag_dB = 20*log10(squeeze(mag));
freq_Hz = wout/(2*pi);

semilogx(freq_Hz, mag_dB, 'LineWidth', 1.5);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title(sprintf('AAFilter (fc = %.2f Hz)', fc));
hold on;
% Horizontal line at -3 dB
yline(-3, '--r', 'LineWidth', 1.5, 'Label', '-3 dB', 'LabelHorizontalAlignment', 'left');
% Vertical line at cutoff frequency
xline(fc, '--b', 'LineWidth', 1.5, 'Label', sprintf('fc = %.2f Hz', fc),'LabelOrientation', 'horizontal', 'LabelHorizontalAlignment', 'left');
% Vertical line at Nyquist frequency for reference
xline(fN, '--m', 'LineWidth', 1.5, 'Label', sprintf('Nyquist = %.2f Hz', fN),'LabelOrientation', 'horizontal', 'LabelHorizontalAlignment', 'left');


