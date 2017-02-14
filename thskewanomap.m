function cmap = thskewanomap(mlen)
% cmap = th_anomap(mlen)
% generates a centered red-blue anomaly colormap 
% of length "mlen"
% meln mus be an even number

frac = 1./(mlen/2);
b = [((1:mlen/2))'*frac;ones([mlen/2,1])];
g = [0.7*b(1:mlen/2);flipud(b(1:mlen/2))];
r = [ones([mlen/2,1]);zeros([mlen/2,1])];
xb = zeros([mlen/2,1]);
xg = flipud(b(1:mlen/2));
xr = ones([mlen/2,1]);

cmap=flipud([[xr xg xb]; [r g b]]);