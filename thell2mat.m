
%%
x = 1:1000:100000;
x1 = 2.01*x;% (1.2*x+pi()/sqrt(2));

phi=1;

cv1= 2*cos(x)+1i*sin(x);
cv2= cos(x1)+5*1i*sin(x1);% sin(x1)+1i*cos(x1);
cv2a= cos(x1+phi)+5*1i*sin(x1+phi);% sin(x1)+1i*cos(x1);
cv3=cv1+cv2;
cv3a=cv1+cv2a;
%cv2 = sin(x) + 1i*sin(); 
%cv3 = sin(x)+1i*cos(x);
cv = [cv1',cv2',cv3',cv3a'];%,cv3'];
mcv = vrep(vmean(cv,1),length(cv),1);
[Rxx,Ryy,Rxy]=vmean((real(cv-mcv)).^2,imag(cv-mcv).^2,real(cv-mcv).*imag(cv-mcv),1);

[d1,d2,th,nu]=specdiag(Rxx,Ryy,Rxy);

[d1;d2;th;nu]

 a=sqrt(d1);
 b=sqrt(d2);
 [kappa,lambda]=ab2kl(a,b);

figure(1);clf
plot(cv(:,1),'linewidth',3)
hold on
plot(cv(:,2),'r')
plot(cv(:,3),'g')
plot(cv(:,4),'m')
axis equal

figure(2);clf
ellipseplot(kappa(1,1),lambda(1,1),th(1,1),'3b')
ellipseplot(kappa(1,2),lambda(1,2),th(1,2),'1r')
ellipseplot(kappa(1,3),lambda(1,3),th(1,3),'1g')
ellipseplot(kappa(1,4),lambda(1,4),th(1,4),'1m')

%% Combined variance ellipse from tidal components
% The autocovariance matrix at zero lag is the integral of the
% spectral matrix over all frequencies. 
%
% You can see this right away as follows from the definition of the 
% autocovariance function R(tau) in terms of the spectrum S(omega):
%  
% 1/(2 pi) int S(omega) e^{i omega tau} d omega = R(tau)
%  
% Then, if you let R and S be two by two matrices, this equation is 
% still true, as the components Fourier transform into each other. 
% Setting tau=0 you get
%  
% 1/(2 pi) int S(omega) d omega = R(0)
%  
% and you have the variance ellipses on the right.  If you know the tidal
% components and their phases, you should be able to compute S(omega).
% Actually, since you are dealing only with tides, you have delta functions
% on the left so you get a sum
%  
% 1/(2 pi) sum_{n=1}^N S_n  = R(0)
%  
% that is, the 2x2 matrices describing the ellipse associated
% with each tidal component are simply added up,
% and the eigenvector decomposition of this sum
% describes the total tidal variance ellipse.
%
% In this way you could compare predicted vs. observed variance ellipses. 

%% Matrix representation of time varying ellipse:
% We can write the equation for a time-varying ellipse as
% 
%    [u v]^T =  [cos theta  -sin theta;  sin theta   cos theta]   [a cos(phi + omega t)     b sin (phi+omega t)]^T
%               = J(theta) [a cos(phi + omega t)     b sin (phi+omega t)]^T
% 
% where J(theta) is the rotation matrix defined on the previous line. 
% The parameters here don't depend upon time.  
%
% The covariance matrix is  (1/T) int [u v]^T  [u v]   dt,
% (column vector times row vector) or
% 
%   J(theta)
%       (1/T)  int  [a cos(phi + omega t)     b sin (phi+omega t)]^T  [a cos(phi + omega t)     b sin (phi+omega t)] dt     
%   J(theta)^T
% 
% If write out all the terms in this matrix with some trigonometric identities,
% and make sure to integrate over a full period,
% all the phi terms vanish and you end up with
% 
% (1/2) J(theta) [a^2   0;  0 b^2] J(theta)^T   
% 
% which is conveniently in its eigendecomposition form. 

%%

i = 2;
te = 1/2*jmat(squeeze(th(i)'))*[a(i).^2   0;  0 b(i).^2]*permute(jmat(th(i)),[2,1,3])

[Rxx(i) Rxy(i); Rxy(i) Ryy(i)]