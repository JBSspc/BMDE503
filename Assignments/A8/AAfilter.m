function h = AAfilter(wc)
% AAfilter generates the transfer function of the anti-aliasing filter.
%
% H = AAfilter(Wc) returns the filter transfer function with cut-off
% frequency Wc rad/s.

[num, den] = butter(8, wc, 's');
h = tf(num, den);
end