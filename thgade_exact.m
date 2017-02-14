function [varargout]= thgade(varargin)
%thgade - computes salinity or temperature on melting-freezing line
%
% y = thgade(x,[s0,t0,type])
% [y s0 t0] = thgade(x,[type])
%
% s0, t0 - reference point, default: s0 = 34.303; t0 = -1.83;
% 
% y - output, determined by 'type' variable (default = salt)
% salinity -> type='salt'
% temperature -> type='salt'

str='sal';

narg=nargin;
   if ischar(varargin{end})
        str=lower(varargin{end});
        str=str(1:3);
        varargin=varargin(1:end-1);
        narg=narg-1;
   end

if narg == 3
   s0 = cell2mat(varargin(2));
   t0 = cell2mat(varargin(3));
elseif narg == 1
    s0 = 34.303;
    t0 = -1.83;
else
    error(['Input must be either 1 or 3 numbers and maybe one string']);
end

if nargout == 3
    varargout{2} = s0;
    varargout{3} = t0;
end

x = cell2mat(varargin(1));
L = 3.34e5;
cp = 4000;

if strcmp(str,'sal')
%Gade line:
% melting line for water properties
% T_m = -2.2:0.01:-1.55;
% S_0 = 34.303;
% T_0 = -1.83;
y = s0.*(1-cp./L.*(t0-x));
varargout{1}= y;
elseif strcmp(str,'tem')
    y =  (x./s0-1).*L./cp+t0;
 varargout{1} = y;
else
    error(['type string must either be salt or temp']);
end

