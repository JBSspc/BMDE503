function y = integration_demo
  % How to perform numerical integration using INTEGRAL.
  % MATLAB R2018b and higher
  %
  % Example integrates the square of magnitude of a standard Bode factor from
  % dc to infinity.
  %
  % HOW TO USE IN YOUR CODE
  % =======================
  % Copy the 'fun' function into your code, include 'global H' at the top of
  % your code, assign your transfer function to H, issue the INTEGRAL
  % function call below.

  global H

  % Transfer function to integrate
  s = tf('s');
  H = 1/(s + 1);

  % Integrate |H|^2(f) from 0 (FL) to infinity (FH).
  % Analytical answer is 1/4.

  FL = 0;
  FH = Inf;
  y = integral(@fun, FL, FH, 'ArrayValued', 1);
end

function y = fun(f)
  % This function defines the integrand (the function being integrated).
  global H
  mag = bode(H, 2*pi*f);
  % BODE returns the magnitude as a matrix instead of an array. SQUEEZE
  % converts the matrix into an array before squaring it.
  y = squeeze(mag).^2;
end