%% Q2 
% Differential input test V1 = 2, V2 = -2
y_diff = Q2(2, -2);

% Common-Mode input test V1 = 2, V2 = 2
y_cm = Q2(2,2);

% Computation of amplifier's CMR in dB
CMR = 20*log10((y_diff)/(y_cm));

%% Q3
% Given parameters
C = 560e-9;
R = 243e3;
A_o = 1e5;
tau_o = 1/(20*pi);

% Try different resistor values
Rc_options = [100,150,182,221,280,340,475,562, 681, 825, 1000];

sys_uncomp = Q3c(C, R, A_o, tau_o, 0);     % No compensation

% Plot Pole-Zero Map & Step response comparison
for Rc = Rc_options
    sys_comp = Q3c(C, R, A_o, tau_o, Rc);
    
    figure;
    t = tiledlayout(2,1);
    ax1 = nexttile(t,1);
    pzmap(ax1,sys);
    title(ax1,['Pole-Zero Map for Rc = ', num2str(Rc), ' \Omega']);
    grid (ax1,'on');

    ax2 = nexttile(t,2);
    step(ax2,sys_uncomp, 0.003); % 3 ms
    hold (ax2,'on');
    step(ax2,sys_comp, 0.003);
    legend('Uncompensated', ['Compensated (Rc = ', num2str(Rc), ' \Omega)']);
    title('Step Response Comparison');
    grid on;
    pause(1); % Pause to view each plot
end

% Superimposed frequency responses plot


ACL_ideal = s*C*R;
Av = A_o/((s*tau_o)+1);
beta = 1/((s*C*R)+1);
Avbeta = Av*beta;
%compensatedTf = 

figure(1)
h = bodeplot(ACL_ideal, 'b', Av, 'r',beta,'g',Avbeta,'k');
p=getoptions(h);									% Create a plot options handle p.
p.FreqUnits = 'Hz';               % Modify frequency units.
setoptions(h,p);									% Apply plot options to the Bode plot and render.

% The legend may be repositioned by hand so as not to occlude the plots.
legend('Low-Pass', 'High-Pass')
grid on