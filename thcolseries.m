function colseries = thcolseries(itmax)
% thcolseries(itmax)
% creates a rainbow colormap "colseries" from green tor red
% of length "itmax"
% can be called in a for loop (it = 1:itmax):
% plot(x,y,'color',colcode(it,:)
%
itmax = itmax+1;
colseries = [[zeros(itmax/2,1); ((1:itmax/2)/itmax*2)'] ...
    [((1:itmax/2)/itmax*2)'; 1-((1:itmax/2)/itmax*2)'] ...
    [1-((1:itmax/2)/itmax*2)'; zeros(itmax/2,1)]];