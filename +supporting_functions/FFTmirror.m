function y = FFTmirror(x)
% FFTmirror Transposes the negative frequencies of a 1-D FFT to the start of the channel.
%
%   Y = FFTmirror(X) transposes the negative frequency coefficients of an FFT
%   result, in X, to the start of Y. Note that for symmetry, the length of Y must be
%   odd. It is also easier to setup the frequency axis for the FFT result when the
%   spectrum is symmetric. Hence, if length(X) is even the highest frequency component
%   is duplicated at the negative end of the spectrum to make Y an odd length.
%
%   Ensure to use FFTcorrect prior to using this function.

% X must be a vector
if min(size(x)) > 1
  error('Input must be a vector.')
  return
end

% Determine whether X is a row or column vector
is_column = size(x, 1) > 1;

% Cast x into a column vector
x = x(:);

len = length(x);

if supporting_functions.iseven(len)
	% Raw FFT spectrum is not symmetrical. Need to make it so after 'shift'.
	yy = [x((len+2)/2:len); x(1:(len+2)/2)];		% This is the shift.

	% But, the value from the positive freqeuncy axis axis is copied over to
	% the negative frequency axis must be complemented to maintain the
	% mathematical identity of Fourier DFT coefficients.
	yy(1) = conj(yy(1));
else
	% Raw FFT spectrum is already symmetrical.
	% Just need to transpose upper vector elements.
	yy = fftshift(x);
end

% Put the result back into the form of the original input
if is_column
  y = yy;
else
  % Use .' operator so as not to take complex-conjugate transpose
  y = yy.';
end
