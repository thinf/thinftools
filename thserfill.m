function [yfill iraw ifill] = thserfill(x,y)
%
% [yfill iraw icont] = thserfill(x,y)
% fills interior nans of discontinous vector y
% by interpolation along basis x
%
% vector length and nans at the beginning and end of output series
% yfill are conserved.
%
% iraw - indices of finite values in original distribution
% ifill - indices of finite values in interpolated series
%
% EXAMPLE for using to filter a discontinous series:
% 
% y = raw_data_y;
% x = raw data_x;
% filt_data_y = nans(size(x));
% [yfill iraw ifill] = thserfill(x,y)
% filt_data_y(ifill) = vfilt(yfilt(ifill),10,'mirror');
%
% by thinf, june 2012

iraw = find(isfinite(y)); % find finite data
ifill = iraw(1):iraw(end); % max range
yfill = nans(size(y));
yfill(ifill) = interp1(x(iraw),y(iraw),x(ifill));