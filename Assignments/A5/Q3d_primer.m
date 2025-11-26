% Q3d_primer.m
% Illustration of how to superimpose frequency responses on the same graph
% and to set the frequency axis in Hz.
%
% Examples will use passive unity-gain low-pass and high-pass systems.

C = 560e-9;
R = 243e3;

s = tf('s');

% Set up systems to investigate.
% (Using minreal for good measure. It has no effect in these cases.
% If you get unexpected results, such as an incorrect number of poles or
% zeros, then include a tolerance for pole/zero cancellation. sys_HP
% illustrates this.)
sys_LP = minreal(1/(R*C*s + 1));
sys_HP = minreal((R*C*s) * sys_LP, 1e-5);

% A simple Bode command suffices:
% bode(sys_LP, 'b', sys_HP, 'r')
%
% The following shows how to programatically set the units of the frequency
% axis to Hz. Have to use a different 'bode' function.
figure(1)
h = bodeplot(sys_LP, 'b', sys_HP, 'r');
p=getoptions(h);									% Create a plot options handle p.
p.FreqUnits = 'Hz';               % Modify frequency units.
setoptions(h,p);									% Apply plot options to the Bode plot and render.

% The legend may be repositioned by hand so as not to occlude the plots.
legend('Low-Pass', 'High-Pass')
grid on