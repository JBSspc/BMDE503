% Sofia Palacios Cuevas

%% Q2 
t = -2.5 : 0.01 : 2.5; % Time vector spanning -2.5 to 2.5s, with 100ms increment.
f = Q2wavegen(t); % Generate f(t)
figure(1)
hold on
plot(t, f)
title('f(t)')
xlabel('Time (s)')
ylabel('Amplitude')

% ------ Q2.a)
t2 = 0:0.01:2;
A = 4;
T = 2;
w0 = (2*pi)/T;

b = zeros(1, 25);   % Preallocate b
f2 = zeros(size(t2)); % Initialize f2

for n = 1:25
    if n == 1
        b(n) = ((2*A)/(pi*n)) * (1 - cos(pi*n)) - (A/2);
    elseif n>1
        b(n) = ((2*A)/(pi*n)) * (1 - cos(pi*n));
    end
end

for n = 1:25
    f2 = f2 + b(n) * sin(n*w0*t2);
end

%figure(2)
plot(t2,f2)
% title('f(t)')
% xlabel('Time (s)')
% ylabel('Amplitude')

%% ------ Q2.b) 
a = zeros(1, 25+1);   % Preallocate b
b = zeros(1, 25);   % Preallocate b

% Compute a_n
for n = 0:25
    a(n+1) = (2/T) * trapz(t2, f2.*cos(n*w0*t2)); 
end

% Compute b_n
for n = 1:25
    b(n) = (2/T) * trapz(t2, f2.*sin(n*w0*t2)); 
end

% Parseval's theorem LHS
LHS = (1/T) * trapz(t2, f2.^2);

% Parseval's theorem RHS
a0 = a(1);
rn2 = a(2:end).^2 + b.^2;
RHS = (a0/2)^2 + 0.5*sum(rn2);
fprintf('Power of f(t) over the first 25 series harmonics\n Left-Hand Side of eq: %4.2f \n Right-Hand Side of eq: %4.2f', LHS, RHS);

%% Q3

r = zeros(1,5);
phi = zeros(1,5);

for n = 0:4
    a_n = ((-1)^n)*(10/(n^2 + 1));
    b_n = -n*a_n;

    r(n+1) =sqrt(a_n^2+b_n^2);
    phi(n+1) = -atan2(-b_n,a_n); % b/a = -n
end

n = 0:4;

% --- Plotting ---
figure;

% Subplot 1: Amplitude Spectrum
subplot(2, 1, 1);
stem(n, r, 'LineWidth', 2, 'MarkerFaceColor', 'w');
title('Amplitude Spectrum', 'FontSize', 14);
xlabel('Harmonic Multiple (n)', 'FontSize', 12);
ylabel('Amplitude ($r_n$)', 'FontSize', 12, 'Interpreter', 'latex');
grid on;
xticks(n);
ylim([0 12]);

% Subplot 2: Phase Spectrum
subplot(2, 1, 2);
stem(n, phi, 'LineWidth', 2, 'MarkerFaceColor', 'w');
title('Phase Spectrum', 'FontSize', 14);
xlabel('Harmonic Multiple (n)', 'FontSize', 12);
ylabel('Phase ($\phi_n$)', 'FontSize', 12, 'Interpreter', 'latex');
grid on;
xticks(n);
ylim([-3 3]);

sgtitle('Amplitude and Phase Spectra for g(t)', 'FontSize', 16, 'FontWeight', 'bold');

%% Q5

% A=4, T=2
f_max = 200;
Fs = 2*f_max;             % Sampling frequency    (2*200Hz)                
T = 1/Fs;               % Sampling period  
f_min = 0.5;
L = 1/f_min;            % Length of signal      (1/0.5 Hz)
t = (0:T:L);          % Time vector
f = Q2wavegen(t); % Generate f(t)
freq_range = cat(2,0:f_min:f_max,-f_max:f_min:-f_min); %freq range according to the order of the ftt result

Y = fft(f);
Y = FFTcorrect(Y);

plot(freq_range,abs(Y),"LineWidth",1)
title("Complex Magnitude of fft Spectrum")
xlabel("f (Hz)")
ylabel("|fft(X)|")

fprintf("First 5 harmonics:"); 
%disp(freq_range(1:5));
%disp(Y(1:5));


% Display the calculated values in a table for verification
fprintf('      |   0   |   1    |   2    |   3   |    4  \n');
fprintf('-------------------------------------------------------\n');
fprintf('f(Hz) |%6.3f |%6.3f |%6.3f |%6.3f |%6.3f\n', freq_range(1:5));
fprintf('r_n   |%6.3f |%6.3f |%6.3f |%6.3f |%6.3f\n', Y(1:5));


%% Q5



