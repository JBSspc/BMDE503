function Fourier_Series_Demo_Square_Wave
  % This function demonstrates how to reconstruct a square wave using its
  % Fourier series representation. It shows how adding more harmonics improves
  % the approximation of the original signal.

  global T w0  % Declare global variables for period and fundamental frequency

  T  = 1;                 % Set the period of the square wave to 1 second
  t  = 0 : 0.01 : 3*T;    % Create a time vector from 0 to 3 periods in steps of 0.01 seconds
  w0 = 2*pi/T;            % Calculate the fundamental angular frequency (rad/s)
  N  = 20;                % Number of harmonics to include in the Fourier series

  clf                     % Clear the current figure window

  y = a(0)/2;             % Start the reconstructed signal with the DC component (a0/2)

  % Loop through each harmonic and add its contribution to the signal
  for n = 1:N
      term = a(n) * cos(n*w0*t);  % Compute the nth cosine term of the Fourier series
      y = y + term;               % Add the term to the reconstructed signal

      % Plot the signal after adding each harmonic
      plot(t, y)           
      title(['n = ' num2str(n)])  % Display which harmonic is currently added
      pause(0.1)                  % Pause briefly to visualize the update
  end

  % Now plot the original square wave and the final reconstructed signal together
  clf                                 % Clear the figure again
  plot(t, f(t), 'r', 'LineWidth', 3)  % Plot the original square wave in red
  hold on
  plot(t, y, 'b')                     % Plot the reconstructed signal in blue
  xlabel('Time (s)')
  ylabel('Amplitude')
  title(['f(t) for ' num2str(n) ' harmonics'])

  % Add legend and adjust axes for better visualization
  axis([0 max(t) -2 2])                   % Set axis limits
  legend('f(t)', 'Reconstructed signal')  % Label the plots

end

function y = a(n)
  % This function returns the Fourier coefficient a(n) for a given harmonic n
  global T
  if n == 0
      y = 0;  % DC component is zero for this square wave
  else
      if iseven(n)
          y = 0;  % Even harmonics have zero contribution (due to symmetry)
      else
          % Odd harmonics have non-zero coefficients
          y = 4/pi * sin(pi/2*n) / n;
      end
  end
end

function y = f(t)
  % This function defines the original square wave signal
  global w0
  y = sign( cos(w0*t) );  % Square wave is the sign of a cosine wave
end