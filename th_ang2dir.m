function dr = th_ang2dir(ang)
dr = mod(pi()/2-(ang),2*pi()); % compute current direction
