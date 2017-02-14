function [varargout] = thsourcew(s,t,varargin)
%thsourcew - computes salinity (and temperature), as properties change
% along melting-freezing line
%
% sf = thsourcew(s,t,[method])
% [sf tf] = thsourcew(s,t,[method])
%
% linearized freezing pont salinity-dependency
% around reference point: s0 = 34.303; t0 = -1.83;
% 
% method may be 'exact' for solution of quadratic equation
% or 'approx' for constant Gade line slope
% or 'both' for both:
% [sf tf sf_approx tf_approx] = thsourcew(s,t,'both')
% Default: exact
%
%% compute source water salinity

if nargin == 2
    method = 'exact';
elseif nargin == 3
    method = varargin{1};
end

L = 3.34e5;
cp = 4000;

% freezing point temperature linearized around reference point:
% tf = t0(s0) + alph * (s-s0)
s0 = 34.303;
t0 = -1.8828;
pp = polyfit((-0.2):0.02:(0.2),fp_t((s0-0.2):0.02:(s0+0.2),zeros(size((-0.2):0.02:(0.2))))-t0,1);
alph = pp(1);% -0.0571;

% intersection of Gade line with freezing point:
gamma = (L+cp.*(t-t0+alph.*s0));
% positive square root
sf = gamma/2/alph/cp + ((gamma/2/alph/cp).^2 - s.*L/alph/cp).^(1/2);
% negative square root gives unphysical solution:
% sf_n = gamma/2/alph/cp - ((gamma/2/alph/cp).^2 - s.*L/alph/cp).^(1/2);

% Approximation for constant slope on Gade line
sf_approx = s.*(1-cp/L.*(t-t0+alph.*s0))./(1-s.*alph*cp/L);

if strcmpi(char(method),'exact')
    varargout{1} = sf;
elseif strcmpi(char(method),'approx')
    varargout{1} = sf_approx;
end

if nargout == 2 && ~strcmpi(char(method),'both')
    varargout{2} = fp_t(sf,zeros(size(sf)));
elseif strcmpi(char(method),'both')
    if nargout ~= 4
        error(['Output argument must assign four variables if method = both']);
    end
    varargout{1} = sf;
    varargout{2} = fp_t(sf,zeros(size(sf)));
    varargout{3} = sf_approx;
    varargout{4} = fp_t(sf,zeros(size(sf_approx)));
elseif nargout ~= 1
    error(['Output argument must assign one or two variables']);
end
