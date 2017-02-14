function thscr2eps(name,varargin)
% thprint(name,[directory])
% Print current figure as eps file with paper position mode auto
% output directory is specified via "thset('dir.fig')" or the directory
% that is provided
% figure name
% format may be switched to jpg (1) and png (2), default is eps

if nargin > 1
path = cell2mat(varargin);
else
path = thset('dir.fig'); 
end

current_dir = pwd;
cd(path)

set(gcf,'units','centimeters')
cmpos = get(gcf,'position');
set(gcf,'units','pixels')

set(gcf, 'PaperPositionMode', 'auto','PaperType','<custom>',...
    'PaperSize',[cmpos(3) cmpos(4)]);
%print('-depsc2', name);
print('-depsc', name);

cd(current_dir)
end


