function y = rp(varargin)
% RP Finds parallel combination of resistors.
%
%     Y = RP(RA, RB, RC, ...) returns RA||RB||RC||...
%     Y = RP([RA RB RC ...]) returns RA||RB||RC||...
%     Y = RP([RA RB], [RC RD], [RE RF]) returns [RA||RC||RE RB||RD||RF]
%
%     Row vectors of arbitrary length may be used to input resistor values.
%     But all must be of the same length.

if nargin == 0
  errmsg('At least one argument must be provided.')
elseif nargin == 1
  % One vector specified. Interpret as set of parallel resistors.
  y = 1 ./ sum(1./varargin{1});
else
  % Multiple row vectors supplied. Interpret as parallel combination of ith
  % element from each vector.
  if isnumeric(varargin{1})
	r = cell2mat(varargin);
  else
	% varargin is a cell array of numandtol objects.
	r = [varargin{:}];
  end
  % r is now a row vector. Reshape into a matrix so that entry at index (i,j)
  % is the ith element of the jth vector.
  vector_size = size(varargin);
  r_size = size(r);
  rmat = reshape(r, r_size(2)/vector_size(2), vector_size(2))';

  y = 1 ./ sum(1./rmat);
end
