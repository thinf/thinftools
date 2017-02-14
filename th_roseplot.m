function  hout = th_roseplot(rd,varargin)
%
% function  hout = apn_roseplot(rosedat,[h],[x0 y0])

if nargin > 1
    fh = gcf;
    ax0 = varargin{1};
    axis(ax0)
else
    fh = figure;
    ax0 = axes;
end
%% sector speed stuff

use rd.sect_raw

sect_sp(isnan(sect_sp))=0;
sect_spvar(isnan(sect_spvar))=0;
dr_pl = [sect_dr, sect_dr(1)]/180*pi();
sp_pl = [sect_sp, sect_sp(1)];
spvar_pl = [sect_spvar, sect_spvar(1)];

px = [dr_pl, fliplr(dr_pl)];
py = [sp_pl+spvar_pl/2, fliplr(sp_pl-spvar_pl/2)];

% variance patch
varcol = 0.6*[1 1 1];
hpx = polargeo(px,py);
set(hpx,'Color',varcol);
hold on
pa = patch( get(hpx,'XData'), get(hpx,'YData'), varcol,'edgecolor',varcol);
%delete(hpx);

% average speed
hp(1) = polargeo(dr_pl,sp_pl);
set(hp(1),'linewidth',1,'color','k');

% scaling
% mag = 2*max(abs(m),k);
%mag = 1*(abs(m)+abs(k));
% mag = 1.6*(max(sect_sp)+max(sect_spvar)/2);
%ylim([-mag mag]);
%xlim([-mag mag]);
%% sector transport stuff

use rd.polarplt

apos = get(ax0,'position');
ax1 = axes('position',apos,'color','none');
axis off
mag = 1.5*(max(plt_transp));
ylim([-mag mag]);
xlim([-mag mag]);

hold on
axes(ax1)
hp(2) = polargeo(plt_dr,plt_transp);
set(hp(2),'linewidth',2,'color','b');

%% mean transport stuff
% FIXME: add scales
ax2 = axes('position',apos,'color','none');
axis off
ylim(get(ax0,'ylim'))
xlim(get(ax0,'xlim'))
hold on

% mean and variance ellipse
use rd.elipara
%ar = get(ha(2),'plotboxaspectratio');
he(1) = ellipseplot(k,l,th,m);
set(he(1),'color','k','linewidth',2)

he(2) = plot([0 m],'k','linewidth',2,'parent',ax2);
he(3) = plot(m,'ko','markerfacecolor','k','parent',ax2);

%he(2) = plot3(real([0 m]), imag([0 m]), [100 100],'k','linewidth',2,'parent',ax2);
%he(3) = plot3(real(m),imag(m),100,'ko','markerfacecolor','k','parent',ax2);


%axes(ax1)

%% output handles
make hout fh ax0 ax1 ax2 hp

end