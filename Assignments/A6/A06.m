
%% 2.a)
% Known resistances
Ri = 10e3;
Rf = 20e3;
R  = (Ri*Rf)/(Ri+Rf);   % parallel combination

% Build matrix A (6x6)
A = [ Rf  0   0  -1  0  1;      % (1)
      0   Ri  0   1  0  0;      % (2)
      0   0   R   0  1  0;      % (3)
     -1   1   0   0  0  0;      % (4)
      0   0   1   0  0  0;      % (5)
      0   0   0   1 -1  0];     % (6)

% Define sources as columns in b matrix (each column = one active noise)
b_vn1    = [0; 0; 1; 0; 0; 0];        % vn1 = 1V
b_vn2    = [0; 1; 0; 0; 0; 0];        % vn2 = 1V
b_vn3    = [1; 0; 0; 0; 0; 0];        % vn3 = 1V
b_vnop1  = [0; 0; 1; 0; 0; 0];        % vnop1 = 1V
b_in1    = [0; 0; 0; 0; 1; 0];       % in1 = 1A
b_in2    = [0; 0; 0; 1; 0; 0];       % in2 = 1A

B = [b_vn1, b_vn2, b_vn3, b_vnop1, b_in1, b_in2];

X = A\B;        % Solve all at once


% Extract node voltages
% V_minus = X(4);
% V_plus  = X(5);
V_on    = X(6,:);

% Compute gain from this noise source
gain_vn1 = V_on(1);
fprintf('Gain vn1 -> Vout = %.3f V/V\n', gain_vn1);
gain_vn2 = V_on(2);
fprintf('Gain vn2 -> Vout = %.3f V/V\n', gain_vn2);
gain_vn3 = V_on(3);
fprintf('Gain vn3 -> Vout = %.3f V/V\n', gain_vn3);
gain_vnop1 = V_on(4);
fprintf('Gain vnop1 -> Vout = %.3f V/V\n', gain_vnop1);
gain_in1 = V_on(5);
fprintf('Gain in1 -> Vout = %.3f kOhms\n', gain_in1/1000);
gain_in2 = V_on(6);
fprintf('Gain in2 -> Vout = %.3f kOhms\n', gain_in2/1000);

%% 2.b) Output noise amplitude spectral density resulting from each noise source

% Current
in_gains = [-20,20];
c_fc = 2800;
c_freqs = (1:350000);
c_kw = 0.57e-12;
in = c_kw*sqrt(1 + (c_fc./c_freqs));

% Voltage
vn_gains = [3,-2,1,3];
v_fc = 365;
v_freqs = (1:350000);
v_kw = 19e-9;
vn = v_kw*sqrt(1 + (v_fc./v_freqs));


figure
subplot(211) 
hold on
xline(c_fc, '-k', 'f_{c} = 2800 Hz','LineWidth',2)
semilogx(c_freqs,10*log10(in*abs(in_gains(1))),'LineWidth',2)
semilogx(c_freqs,10*log10(in*abs(in_gains(2))),'LineWidth',2,'LineStyle','--')
%yscale("log")
xlabel('Frequency (Hz)')
ylabel({'Input Noise Current', '(A_{rms}/\surd(Hz)) dB'})
title('Output Noise Amplitude Spectral Density (Currents)')
legend('','i_{n1}','i_{n2}')
set(gca,'XScale', 'log')
grid on
grid minor

subplot(212) 
hold on
xline(v_fc, '-k', 'f_{c} = 365 Hz','LineWidth',2)
for i=1:length(vn_gains)-1
    semilogx(v_freqs,10*log10(vn*abs(vn_gains(i))),'LineWidth',2)
end
semilogx(v_freqs,10*log10(vn*abs(vn_gains(4))),'LineWidth',2,'LineStyle','--')
%yscale("log")
xlabel('Frequency (Hz)')
ylabel({'Input Noise Voltage', '(V_{rms}/\surd(Hz)) dB'})
title('Output Noise Amplitude Spectral Density (Voltages)')
legend('','v_{n1}','v_{n2}','v_{n3}','v_{nop1}')
set(gca,'XScale', 'log')
grid on
grid minor

%% Combined output noise amplitude spectral density
in_total = ((in*in_gains(1)).^2)+((in*in_gains(2)).^2);
vn_total = ((vn*vn_gains(1)).^2+(vn*vn_gains(2)).^2+(vn*vn_gains(3)).^2+(vn*vn_gains(4)).^2);
total = sqrt(in_total+vn_total);

figure
semilogx(c_freqs,10*log10(total),'LineWidth',2)
ylabel({'Amplitude', '(V_{rms}/\surd(Hz)) dB'})
xlabel('Frequency (Hz)')
title('Output Noise Amplitude Spectral Density')
set(gca,'XScale', 'log')
grid on
grid minor



