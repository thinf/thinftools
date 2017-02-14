function  rosedat = th_rose(cv,varargin)
% rosedat = th_rose(cv,[sect])
%
% computes statistical properties of hrizontal currets,
% prepared in standard format to be used with apn_roseplot.m.
% 
% Input:
% cv - complex current meter time series(cm/s),
% sect - number of direction sectors to be divided (if empty, default of 24 sectors à 15 deg will be used)
%
% Output:
% struct "rosedat" with the following vector fields:
% 1)    sect_raw        - struct with raw data from sector analysis containg the fields
%       -> sect_dr      - center direction (geographical degrees) of each sector
%       -> sect_hist    - histogram of relative occurence of currents in each sector
%                         (noramlized units such that sum(hist_sect) =1;)
%       -> sect_sp      - average current speed in each sector (cm/s)
%       -> sect_spvar   - variance of current speed in each sector (cm/s)
%       -> sect_transp  - integrated "vanntarnsport" in each sector in units
%                         of m^3/(days*m^2), divide by 86 to obtain Liter/(s*m^2)
%
% 2)    polarplot       - same data (with prefix plt_) as in sect_raw, but
%                         reformatted to do "nice" rosepots with "polargeo.m"
%
% 3)    elipara         - struct with data from co-varaince analysis that can
%                         be to plot varainace ellipses (ellipseplot.m)
%       -> m            - mean, time averaged complex vector of mean current(cm/s)
%       -> k            - kappa, magnitude of covariance ellipse (cm/s), corresponding to
%                         1st std deviation of current speed
%       -> l            - lambda, elongation of ellipse, indicating the anisotropy
%                         of current vairability (0 = circular, 1 = linear)
%       -> th           - th, phase angle (rad, math convention) indicating ellipse orientation
%
% (c) by Tore.Hattermann@akvaplan.niva.no, v0.1 Dec 2013

if nargin == 1
    sect = 24; % use default 15 deg sectors
else
    sect = varargin{1};
end


%% prepare data for rose plots:
sp = abs(cv); % compute current speed
dr = mod(pi()/2-(angle(cv)),2*pi()); % compute current direction

% dummy rose, unity histogram for sectors
[plt_dr,rho] = rose(pi()/180*(0:0.5:360),sect);
ii= find(rho~=0);
rho(ii)=1; %unity rose histogam dummy


% compute average speed and histogram in each bin:
dr_bin = [0:360/sect:360]*pi()/180; % define 24 bins à 15 degrees and convert to radians
dummy_bin = [0.5 1.5]; % define additional dummy bin for second (unused) dimension in "twodmean" function

[mz,xmid,ymid,numz,stdz]=twodstats(dr,ones(size(dr)),sp,dr_bin,dummy_bin);

% normalization factor for the integrated transport in m^3/(days*m^2):
    % 36*24 =86  -> convert curent speed from cm/s to m/day 
    % /vsum(hist_sec,2) -> divide by total elements in histogram 

% raw data fields
sect_dr = xmid'*180/pi();
sect_hist = numz./vsum(numz,2);
sect_sp = mz;
sect_spvar = stdz;
sect_transp = sect_hist .* sect_sp *86;

% compute plottable rose histogram
plt_hist = rho;
plt_hist(ii(1:2:end-1))=plt_hist(ii(1:2:end-1)).*sect_hist;
plt_hist(ii(2:2:end))=plt_hist(ii(2:2:end)).*sect_hist;

% compute plottable speed
plt_sp = rho;
plt_sp(ii(1:2:end-1))=plt_sp(ii(1:2:end-1)).*sect_sp;
plt_sp(ii(2:2:end))=plt_sp(ii(2:2:end)).*sect_sp;

% compute plottable speed
plt_spvar = rho;
plt_spvar(ii(1:2:end-1))=plt_spvar(ii(1:2:end-1)).*sect_spvar;
plt_spvar(ii(2:2:end))=plt_spvar(ii(2:2:end)).*sect_spvar;

plt_transp = plt_sp .* plt_hist * 86;

make rosedat.sect_raw sect_dr sect_hist sect_sp sect_spvar sect_transp 
make rosedat.polarplt plt_dr plt_hist plt_sp plt_spvar plt_transp

if nargin > 2
    for i = 1:length(varargin(2:end))
    sect_mz{i}=twodmean(dr,ones(size(dr)),varargin{i+1},dr_bin,dummy_bin);
    
    plt_mzd = rho;
    plt_mzd(ii(1:2:end-1))=plt_mzd(ii(1:2:end-1)).*sect_mz{i};
    plt_mzd(ii(2:2:end))=plt_mzd(ii(2:2:end)).*sect_mz{i};
    plt_mz{i} = plt_mzd;
    end
    
    rosedat.sect_raw.sect_mz = sect_mz;
    rosedat.polarplt.plt_mz = plt_mz;
end

%% prepare data for variance ellipse plots
% compute time-mean current and variance ellipse parameters
    mcv = vrep(vmean(cv,1),length(cv),1); % time mean current (padded into full length vector for computations)
    % variance ellipse parameters as described in 'help ellipseplot'
    [Rxx,Ryy,Rxy]=vmean((real(cv-mcv)).^2,imag(cv-mcv).^2,real(cv-mcv).*imag(cv-mcv),1);
    [d1,d2,th]=specdiag(Rxx,Ryy,Rxy);
    a=sqrt(d1);
    b=sqrt(d2);
    [kappa,lambda]=ab2kl(a,b);
    
 m = unique(mcv);
 k = kappa;
 l = lambda;
 th = th;
 
 make rosedat.elipara m k l th
 
 
end