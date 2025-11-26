function y = RT(T)

% Thermistor resistance equation.
%
%   Y = RT(T) returns the thermistor resistance at a temperature T.
% 
% T is in deg-C and may be a scalar or a vector.

global BETA R0 T0 KELVIN

y = R0 * exp(BETA * (1./(T+KELVIN) - 1/T0) );

end