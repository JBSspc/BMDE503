function y = rrange(d1, d2)
% RRANGE Returns resistor values over specified decades.
%
%       R  = RRANGE(D1, D2) returns the 1% resistor values available in the
%       decade range [10^D1, 10^D2]. D1 and D2 must be integer values.
%       Values are returned in a column.

% Check for integer decade specifiers
d = [d1 d2];
d_floor = floor(d);
d_diff = abs(d - d_floor);
if any(d_diff)
    error('Input arguments must be integers.')
end
clear d d_floor d_diff

% Determine number of decades
ndecade = d2 - d1 + 1;

% Get base resistor values. Based values rage from [1... 10]. Drop the
% last value since it goes into another decade and will cause repeated
% values. Arrange values into a column vector.
r = rpool;
r = r(1:end-1);
r = r(:);

% For each decade setup a row vector of resistor base values.
resistors = repmat(r, [1, ndecade]);

% Multiply each row by the decade multiplier
for i = 1 : ndecade
    resistors(:,i) = resistors(:,i) * 10^(d1+i-1);
end

% Convert array into colunm vector and put in the last value that was
% stripped out above.
y = [reshape(resistors, numel(resistors),1); r(1)*10^(d2+1)];