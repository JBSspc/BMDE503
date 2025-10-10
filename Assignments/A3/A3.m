% Code for Assignment 3
%% Q1 b)
% Numeric rms noise levels
V_N = 1;    % [V]
I_N = 2;    % [A]

% We want to know: x = [Va; Vb; Vc]
% Circuit equations:
% (eq1) Va - Vc = VN
% (eq2) (Va - Vb)/3 + Va/2 + Vc/5 - IN = 0
% (eq3) (1/3 - 2)*(Vb - Va) = 0

A = [ 1,    0,   -1;            
     1/3 + 1/2,  -1/3,   1/5;   
     -(1/3 - 2),  (1/3 - 2),  0 ];  

y = [V_N; I_N; 0];

x = A \ y;
Va = x(1);
Vb = x(2);
Vc = x(3);

VON = Vb;        % since ground is 0
v1 = Vb - Va;

VONpp = 6.6*VON; % Gaussian

disp([Va, Vb, Vc, v1,VONpp]);
%% Q4

load('Q4.mat');

figure
Q4(H4a);

figure
Q4(H4b);

% -------- fn ---------------------------------
function Q4(system)
    
    name = inputname(1);
    t = tiledlayout(3,1);
    ax1 = nexttile(t,1);
    pzmap(ax1,system);
    title(ax1,['Pole-Zero Map for ' name]);
    grid (ax1,'on');
    P = pole(system);
    z = zero(system);
    disp([name '- Poles:']), disp(P);
    disp([name '- Zeros:']), disp(z);

    ax2 = nexttile(t,2);
    step(ax2,system);
    title(ax2,['Unit-Step Response for ' name]);
    grid (ax2,'on');

    ax3 = nexttile(t,3);
    step(ax3,system);
    title(ax3,['Unit-Step Response for ' name]);
    grid (ax3,'on');
    xlim(ax3,[0 200])

    set(gcf,'Position',[100 100 800 600]);

end

%% Q5


load('Q5.mat');
freq = 3*(2*pi); % 
% H5a
[mag_a, phase_a, wout_a] = bode(H5a,freq);
fprintf('H5a\nMag_out: %.2f, phase_out: %.2f',mag_a,phase_a);
figure
bode(H5a);

figure
hold on
t = 0:0.1:1000;
input = 2*cosd(3*t-45);
output = 2*mag_a*cosd(3*t-45+phase_a);
plot(t,input);
plot(t,output);
legend('Input','Output');
xlabel('Time (s)');
ylabel('Amplitude')
title('Sinusoidal steady-state output for H5a');

% H5b
[mag_b, phase_b, wout_b] = bode(H5b,freq);
fprintf('\nH5b\nMag_out: %.2f, phase_out: %.2f\n',mag_b,phase_b);
figure
bode(H5b);

figure
hold on
input = 2*cosd(3*t-45);
output = 2*mag_b*cosd(3*t-45+phase_b);
plot(t,input);
plot(t,output);
legend('Input','Output');
xlabel('Time (s)');
ylabel('Amplitude')
title('Sinusoidal steady-state output for H5b');

