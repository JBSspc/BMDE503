function y = iseven(x)
% ISEVEN tests for the input value being even
%
%     Y = ISEVEN(X) returns 1 if X ix even and returns 0 otherwise. At present this
%     function accepts scalar X.

y = fix(x/2) * 2 == x;
