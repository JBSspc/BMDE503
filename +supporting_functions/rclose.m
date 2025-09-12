function y = rclose(r, varargin)
% RCLOSE Returns closest matching resistor value from the 1% line.
%
%       Y  = RCLOSE(R, X) returns the closest matching resistor to R from
%       the 1% tolerance line. X is a string; if it is defined as 'lower'
%       the returned value will be lower or equal to R (Y <= R).
%       Otherwise the closest matching value will be returned, which may
%       be higher than R.

if (r == Inf)
    y = r;
    return
end

n = fix(log10(r));              % Find resistance decade
resistors = rrange(n-1,n+1);    % Get resistors bracketing that decade

[err,i] = min(abs(resistors - r));  % Find best match

y = resistors(i);               % Best match, unbounded.
if nargin == 2
  % Resistor bound specified. Ensure that it is respected.
  if strcmpi(varargin{1}, 'LOWER')
    if resistors(i) > r
      % Closest match is too large; need to return next lowest value.
      y = resistors(i-1);
    end
  else
    error('Unknown directive.')
  end
elseif nargin > 2
  error('Incorrect number of arguments.')
end