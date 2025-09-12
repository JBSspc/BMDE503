function y = OutOfBounds(TestValue, LowerLimit, UpperLimit)

% OUTOFBOUNDS returns TRUE if a test value falls beyond a range and returns
% FALSE otherwise.
%
% Y = OutOfBounds(X, LB, UB) returns FALSE when LB <= X <= UB and returns
% TRUE otherwise.
%
% Parameter   Type                  Description
% ------------------------------------------------------------------
% X           Scaler or 1-D array   Value(s) to test against bounds
% LB          Single value          Lower bound, inclusive
% UB          Single value          Upper bound, inclusive

range = [min([LowerLimit UpperLimit]) max([LowerLimit UpperLimit])];

ii = (TestValue >= range(1)) & (TestValue <= range(2));
y = ~all(ii);