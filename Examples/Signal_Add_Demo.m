function Signal_Add_Demo
% SIGNAL_ADD_DEMO Demo of how to sum multiple signals using vector notation
%
% MATLAB R2024a
%
% MATLAB is vector-based. Using vector notation is a time-saver as it
% replaces cumbersome FOR loops. In vector notation one line might be able
% to replace several lines inside of a FOR loop as well as the loop itself.
% But you have to think in vectors to be able to use this MATLAB feature.
%
% This demo illustrates how to construct a signal by summing two signals
% where each signal is defined in a separate row in a matrix. Look at the
% code then run this function.

% Setup the signal time vector
t = 0 : 0.001 : 2;

% Setup a empty matrix to hold the two individual signals that make up the
% whole. We need two rows; the number of columns must be the number of
% points in the signal record.
y = zeros(2, length(t));

% Setup a signal in the first row
y(1,:) = 2 * sin(2 * pi * 5 * t);      % 5Hz sine wave, ampiltude 2

% Setup a signal in the second row
y(2,:) = 2 * square(2 * pi * 1 * t);   % 1Hz square wave, amplitude 2

x = y;  % Saving signal for later.

% Plot individual signals.
% MATLAB will determine that the length of the time vector is the same length
% as a row in Y and so will plot each row of Y versus time. MATLAB will
% cycle through a color table while plotting each signal. If there are
% fewer signals to plot than there are colors in the table, each signal will
% have a unique color.

figure(1)
clf             % Clearing any previous plots
subplot(411)    % Plot structure: 4 rows, 1 column; use row 1
plot(t, y)
axis([0 2 -3 3])
xlabel('Time (s)')
ylabel('Amplitude')
title('Individual signals')

% Sum the two signals point by point. Summation is done along each column.
S1 = sum(y);

% Show the sum
subplot(412)    % Plot structure: 4 rows, 1 column; use row 2
plot(t, S1)
axis([0 2 -4 4])
xlabel('Time (s)')
ylabel('Amplitude')
title('Square wave + Sine wave')

% You can also perform computations element by element using vector
% notation. The original sine wave will be squared point by point (using
% the .^2 operator) and the sum will be recomputed and plotted.
y(1,:) = y(1,:).^2;
S2 = sum(y);
subplot(413)
plot(t, S2)
axis([0 2 -2 6])
xlabel('Time (s)')
ylabel('Amplitude')
title('Square wave + Squared sine wave')

y = x;  % Restoring signal

% Compute the root-sum-square (RSS) of the individual signals.
% (Useful later in the course)
S3 = sqrt(sum(y.^2));
subplot(414)
plot(t, S3)
xlabel('Time (s)')
ylabel('Amplitude')
title('Root-Sum-Square of Square wave & Sine wave')