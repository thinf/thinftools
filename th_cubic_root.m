function [x]= th_cubic_root(A,B,C,D,di)
%
% Analytical soultion after 
% http://en.wikipedia.org/wiki/Cubic_function
%
% d=delta
% Ad^3+Bd^2+Cd+D=0

u = [1, (-1+1i*sqrt(3))/2, (-1-1i*sqrt(3))/2];

di0 = B.^2 - 3.*A.*C;
di1 = 2.*B.^3 - 9.*A.*B.*C + 27.*A.^2.*D;
di22m4di03 = -27.*A.^2.*di;

c = ( (di1 + sqrt(di22m4di03) )/2).^(1/3);


for i = 1:3
 x(:,i) = -1./(3*A) .* (B + u(i).*c + di0./(u(i).*c));
end

