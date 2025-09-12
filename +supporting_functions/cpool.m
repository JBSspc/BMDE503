function y=cpool
% CPOOL Returns standard capacitor values from the 10% line.
%
%       C  = CPOOL returns capacitor values from the 10% capacitor
%       line as shown in the table in the BMDE-503 Electronics Circuits
%       notes. Values are in farads.

% cpool holds the capacitor pool values from the 10%-tolerance line.
% Allowable capacitor values are formed by multiplying pool entries by
% powers of 10.
%
% MATLAB R2024a

cpool = [10 12 15 18 22 27 33 39 47 56 68 82].';  % pF

% Build up contiguous table of capacitor values. Add in 10uF, 22uF, 33uF,
% and 47uF values at the end.

len = length(cpool);            % Number of capacitor base values

% Build up capacitor values derived directly from 'cpool', i.e., complete
% runs. There are 6 runs of values derived from the base values, where each
% run is in a subsequent decade.
N = 6;                              % Number of runs (array column)
scale = 10 .^ (0:N-1);              % Powers along a single row (run)
scale = repmat(scale, len, 1);      % Replicate powers along rows

cpool = repmat(cpool, 1, N);        % Replicate cap values along rows
cpool = cpool .* scale;             % Compute capacitor values (pF)
cpool = reshape(cpool, [len*N, 1]); % Reshape matrix into a column vector

% Add in missing values
cpool = [cpool; [10;22;33;47]*10^N];  % pF

% Convert values into farads
y = cpool * 10^-12;