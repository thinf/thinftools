function[hz,hl,ax]=thcolorlineplot_img(varargin)
%
% [hz,hl,ax]=thcolorlineplot(xz, yz, zz, [x1 ,y1,...xn, yn],[options])
%
% Makes an image plot of (xz, yz, zz) and draws n-lines with a new set of
% axis (top/right) on top.
%
% Options may be ['linear'/ 'log'] for linear or logarythmic y axes on the
% image plot and ['parent',ax1], to plot everything within existing axis
% given by ax1.
%
% INPUT:
% xz & yz must be vectors or matrices with only one non-singelton dimension
% determining the coordinates of zz(xz,yz).
%
% xn,yn must be pairs of column vectors of the same length. If no line-data is
% provided, the function will generate a second pair of empty axes 
% 
% OUTPUT:
% hz - handle to the image
% hl - handle to the lines
% ax - handle to the the two pairs of axes
%
% by thinf (tore@npolar.no), May 2011

xz=(varargin{1});
yz=(varargin{2});
zz=varargin{3}';

for i = 1:nargin-3
args{i} = varargin{i+3};
end

ax1 = 0; % default no parent axes
ytype = 'linear'; % default linear y-axis on color shade

if ischar(args{end})
ytype = args{end};
n = nargin-3-1;
    if ischar(args{end-3}) && strcmpi(args{end-3},'parent')
        ax1=args{end-2};
        n = nargin-3-3;
    end
elseif ischar(args{end-1}) && strcmpi(args{end-1},'parent')
    ax1=args{end};    
    n = nargin-3-2;
    if ischar(args{end-2})
        ytype = args{end-2};
        n = nargin-3-3;
    end
else n = nargin-3;
end

% get line data
if n>=2
    for i = 1:2:n
        dummy1 = args{i};
        dummy2 = args{i+1};
        ni1 = find(isfinite(dummy1));
        ni2 = find(isfinite(dummy2));
        if size(ni1)~=size(ni2)
            disp('Warning: x and y of each line do not have same number of finite points')
            disp('use only good x points and replace nans in y with infs')
            dummy2(isnan(dummy2)) = inf;
        end   
        x{(i+1)/2} = dummy1(ni1);
        y{(i+1)/2} = dummy2(ni1);
        lines = i;
    end
elseif n~=0
    disp('STOP: provide the right number of arguments')
    return
else
    lines=0;
end
cell2col(x,y); col2mat(x,y);
disp('')
disp(['Plot ' num2str(lines) ' lines...'])

if 0
% remove nans from color data
kk = find(isfinite(xz));
xz = xz(kk);
zz = zz(:,kk);
kk = find(isfinite(yz));
yz = yz(kk);
zz = zz(kk,:);
is = find(isfinite(zz(1,:)),1,'first');
ie = find(isfinite(zz(1,:)),1,'last');
xz = xz(is:ie);
zz = zz(:,is:ie);
end

% color plot
if ax1==0    
    %hz = pcolorjw(xz, yz, zz);
    %hz = imagesc(xz, yz, zz);
    %set(gca,'ydir','rev')
    hz = contourf(xz, yz, zz,64); shading flat;
    
    ax(1)=gca;
else
hz = imagesc(xz, yz, zz,'Parent',ax1);
ax(1)=ax1;
end

set(ax(1),...
    'XAxisLocation','bottom',...
    'YAxisLocation','left',...
    'Color','none',...
    'XColor','k','YColor','k',...
    'yscale',ytype,...
    'ydir','normal','zdir','normal',...
    'xticklabel','',...
    'box','off')
axis(ax(1),'tight')

% Create 2nd axes and plot lines
ax(2) = axes('Position',get(ax(1),'Position'));
set(ax(2),...
            'XAxisLocation','top',...
            'YAxisLocation','right',...
            'Color','none',...
            'XColor','k','YColor','k',...
            'xticklabel','',...
            'box','off');
if lines ~=0
    hl = line(x,y,'Parent',ax(2));
    disp(['line handle size: ' num2str(size(hl))])
    axis(ax(2),'tight')
else
    hl = lines;
end