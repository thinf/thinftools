function thfig(fn,varargin)
% thfig(fn)
% opens and clears a full screen figure
% figure(fn); clf; set(gcf,'position', [63           1        1538         823])
if ~isempty(varargin)
    switch varargin{1}
        case 'left'
            figure(fn); clf; set(gcf,'position', [63           1        1538/2         823])
        case 'right'
            figure(fn); clf; set(gcf,'position', [63+1538/2           1        1538/2         823])
        case 'upper'
            figure(fn); clf; set(gcf,'position', [63           1+823/2        1538         823/2])
        case 'lower'
            figure(fn); clf; set(gcf,'position', [63           1        1538         823/2])
        otherwise
            error('Unknown format')
    end
else
        figure(fn); clf; set(gcf,'position', [63           1        1538         823])
end
end