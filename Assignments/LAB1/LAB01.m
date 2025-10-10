%% Part 1
% Parameters
R1 = 20.004e3;          % Ohms
R2 = 20.010e3;          % Ohms
C  = 22.3e-9;         % Farads
Vb = 4;            % DC source (V)
A  = 1;            % Input AC amplitude (V)
f  = 5e3;         % Input frequency (Hz)
w  = 2*pi*f;

% --- DC Component ---
Vo_DC = Vb * (R1 / (R1 + R2));

% --- AC Component ---
Zc = 1 / (1j*w*C);
Zpar = (Zc * R2) / (Zc + R2);
H = Zc / (R1 + Zpar);      % Transfer function
Vo_AC = abs(H) * A;        % Output AC amplitude

DC_exp = 1.93750;
DC_AbsError = DC_exp - Vo_DC;
DC_PercentError = (abs(DC_AbsError) / Vo_DC) * 100;

AC_exp = 71.25e-3;
AC_AbsError = AC_exp - Vo_AC;
AC_PercentError = (abs(AC_AbsError) / Vo_AC) * 100;

% Display results
fprintf('\n-- PART 1 --------\n');
fprintf('DC Component: %.3f V\n', Vo_DC);
fprintf('AC Component Amplitude: %.3f V\n', Vo_AC);
fprintf('Percent Error DC: %.3f \n', DC_PercentError);
fprintf('Percent Error AC: %.3f \n', AC_PercentError);

%% Part 2
fprintf('\n-- PART 2 --------\n');
fc = (R1 + R2)/(2*pi*R1*R2*C);
phic = rad2deg(-atan(1));

fc_exp = 719;
fc_AbsError = fc_exp - fc;
fc_PercentError = (abs(fc_AbsError) / fc) * 100;

phic_exp = -44;
phic_AbsError = phic_exp - phic;
phic_PercentError = (abs(phic_AbsError) / phic) * 100;

fprintf('Percent Error fc: %.3f \n', fc_PercentError);
fprintf('Percent Error phi_c: %.3f \n', phic_PercentError);

%% Part 3
fprintf('\n-- PART 3 --------\n');
tau = (R1*R2*C)/(R1+R2);
tr = tau*2.2;
tr_exp = 480.82e-6;
tau_tr_exp = tr_exp/2.2;

tr_ss =5*tau;
tr_ss_exp = 1.04e-3;

tr_ss_AbsError = tr_ss_exp - tr_ss;
tr_ss_PercentError = (abs(tr_ss_AbsError) / tr_ss) * 100;

fc_tr = 0.35/tr;
fc_tr_exp = 0.35/tr_exp;

fc_tr_AbsError = fc_tr_exp - fc_tr;
fc_tr_PercentError = (abs(fc_tr_AbsError) / fc_tr) * 100;

fc3_AbsError = fc_tr_exp - fc_exp;
fc3_PercentError = (abs(fc3_AbsError) / fc_exp) * 100;

fprintf('Percent Error tr_ss: %.3f \n', tr_ss_PercentError);
fprintf('Percent Error fc_tr: %.3f \n', fc_tr_PercentError);
fprintf('Percent Error fc_tr compared to fc from 2: %.3f \n', fc3_PercentError);







