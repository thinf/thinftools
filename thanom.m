function[varargout]=thanom(varargin)
% thnorm - center series of datapoints
    
if strcmp(varargin{1}, '--t')
  vnd_test,return
end


for i=1:nargin
  x=varargin{i};
  nd=(x-vmean(x,1));
  varargout{i}=nd;
end

if nargout==0 || nargout==1
   varargout{1}=nd;
end

function[]=vnd_test
reporttest('VND', all(vnd(1,(1:10),[ (1:10)' (1:10)'])==[0 1 2]))

