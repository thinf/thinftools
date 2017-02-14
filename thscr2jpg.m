function thscr2jpg(filename,varargin)
%thscr2jpg Generate a JPEG file of the current figure with
% dimensions consistent with the figure's screen dimensions.
%
% SCREEN2JPEG('filename',[resolution],[path]) saves the current figure to the
% JPEG file "filename".
% output directory is specified via "thset('dir.fig')" or the directory
% that is provided
% Sean P. McCarthy
% Copyright (c) 1984-98 by MathWorks, Inc. All Rights Reserved

if nargin < 1
error('Not enough input arguments!')
end

if nargin > 1
res = (varargin(1));
end

if nargin > 2
path = varargin(2);
else
path = thset('dir.fig'); 
end

current_dir = pwd;
cd(char(path))


oldscreenunits = get(gcf,'Units');
oldpaperunits = get(gcf,'PaperUnits');
oldpaperpos = get(gcf,'PaperPosition');
set(gcf,'Units','pixels');
scrpos = get(gcf,'Position');
newpos = scrpos/100;
set(gcf,'PaperUnits','inches',...
'PaperPosition',newpos)

if nargin >=2
    print('-djpeg', filename, ['-r' char(res)]);
else
print('-djpeg', filename, '-r100');
end
drawnow
set(gcf,'Units',oldscreenunits,...
'PaperUnits',oldpaperunits,...
'PaperPosition',oldpaperpos)
cd(current_dir)