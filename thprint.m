function thprint(name)
% thprint(name)
% Print current figure as eps file with paper position mode auto
% output directory is specified via "thsettings('dirnames.figures')"
% figure name
% format may be switched to jpg (1) and png (2), default is eps

current_dir = pwd;
cd(thsettings('dirnames.figures'))

set(gcf, 'PaperPositionMode', 'auto');
print('-depsc',name);

cd(current_dir)
end


