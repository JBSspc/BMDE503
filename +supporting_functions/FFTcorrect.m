function y = FFTcorrect(x)

% FFTcorrect Corrects FFT coefficients in accordance to channel length.
%
%     Y = FFTcorrect(X) returns complex FFT coefficients that have been normalized
% to take into account the length of complex FFT vector X.

len = length(x);
temp = x/len;
temp(2:len) = 2 * temp(2:len);
y = temp;