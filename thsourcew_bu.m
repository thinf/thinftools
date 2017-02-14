function [varargout] = thsourcew(s,t)
%thsourcew - computes salinity (and temperature), as properties change
% along melting-freezing line
%
% sf = thsourcew(s,t)
% [sf tf] = thsourcew(s,t)
%
% linearized freezing pont salinity-dependency
% around reference point: s0 = 34.303; t0 = -1.83;
% 

%% compute source water salinity

L = 3.34e5;
cp = 4000;

% freezing point temperature linearized around reference point:
% tf = t0(s0) + alph * (s-s0)
s0 = 34.303;
t0 = -1.8828;
pp = polyfit((-0.2):0.02:(0.2),fp_t((s0-0.2):0.02:(s0+0.2),zeros(size((-0.2):0.02:(0.2))))-t0,1);
alph = pp(1);% -0.0571;

sf = s.*(1-cp/L.*(t-t0+alph.*s0))./(1-s.*alph*cp/L);
varargout{1} = sf;

if nargout == 2
    varargout{2} = fp_t(sf,zeros(size(sf)));
elseif nargout ~= 1
    error(['Output argument must assign one or two variables']);
end
