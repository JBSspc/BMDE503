% Q3_OpEqn returns a transfer function object for Vo(s)/Vi(s) for the
% system shown in Q3.
%
% y = Q3_OpEqn(Ri, Rf, Av) returns a transfer function
% Vo(s)/Vi(s) for the system shown in Q3 using the provided parameters.
%
% Ri & Rf are the resistances (Units: ohms)
% Av is the op-amp open-loop gain, supplied either as a transfer function
% (tf) object or a scalar (including infinity). The parameter may be an
% array of scalars.