function y = Q3TF(R1, R2, C1, C2)

  % Q3 Transfer function
  %
  % y = Q3TF(R1, R2, C1, C2) generates the ideal transfer
  % function, VO(s)/VIN(s), for a second-order low-pass filter using
  % the provided component values. (Note: R does not appear in the result.)
  %
  % Ri's are in ohms
  % Ci's in farads

  s = tf('s');
  
  y = minreal(R2/((C1*C2*R1^2*R2)*s^2 + (C2*R1*R2 - C1*R1^2)*s + (R2 - R1)));
  
end