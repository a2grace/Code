clear 
close all

data_path = '/work/a2grace/hov/';
save_path = '/work/a2grace/figures/';

mylabelfontsize = 15;
mytickfontsize = 12;
mylabelxpos = 0.02;
mylabelzpos = 0.05;



load hov_KE.mat

hfig1 = figure(1);

xs = linspace(0,1,Nx);
tmax = 58;
ts3D = linspace(0,58,58/plot_interval + 1);

[xx,tt] = meshgrid(xs,ts3D);
colorbar
colormap(bone)

rho1 = squeeze(1/Ny*sum(rhosum,2))';
denmin = min(min(rho1));
denmax = max(max(rho1));
ax1den = subplot(1,2,1);
pcolor(xx,tt,rho1), shading interp
caxis([denmin denmax])
title('L253D Density')
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 1],'YLim',[0 58],...
   'XTick',[0 .5 1],'YTick',0:10:60)

t1 = text(mylabelxpos,mylabelzpos,'(a)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 

hfig2 = figure(2);
KE1 = squeeze(1/Ny*sum(KEsum,2))';
KEmin = min(min(KE1));
KEmax = max(max(KE1));

ax1KE = subplot(1,2,1);
pcolor(xx,tt,KE1), shading interp
caxis([KEmin KEmax])
title('L253D KE')
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 1],'YLim',[0 58],...
   'XTick',[0 .5 1],'YTick',0:10:60)

t2 = text(mylabelxpos,mylabelzpos,'(a)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 

load L25.mat

hfig1 = figure(1);
ts2D = linspace(0,58,58/plot_interval + 1);
[xx,tt] = meshgrid(xs,ts2D);

rho2 = rhosum(:,1:58/plot_interval + 1)';
ax2den = subplot(1,2,2);
pcolor(xx,tt,rho2), shading interp
caxis([denmin denmax]);
title('L25 density')
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 1],'YLim',[0 58],...
   'XTick',[0 .5 1],'YTick',[])

t3 = text(mylabelxpos,mylabelzpos,'(b)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold');

set(gcf,'NextPlot','add');
axes;
set(gca,'Visible','off');
xlab = xlabel({'x (m)'},'fontw','b');
zlab = ylabel({'t (s)'},'fontw','b');
set(xlab,'Visible','on','Position',[.5 -.06 0]);
set(zlab,'Visible','on','Position',[-0.07 0.45 0]);

set(hfig1,'Units','Inches');
pos = get(hfig1,'Position');
set(hfig1,'PaperPositionMode','Auto',...
    'PaperUnits','Inches',...
    'PaperSize',[pos(3) pos(4)])

hfig2 = figure(2);
KE2 = KEsum(:,1:58/plot_interval + 1)';
ax2KE = subplot(1,2,2);
pcolor(xx,tt,KE2), shading interp
caxis([KEmin KEmax]);
title('L25 KE')
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 1],'YLim',[0 58],...
   'XTick',[0 .5 1],'YTick',[])

t4 = text(mylabelxpos,mylabelzpos,'(b)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold');


set(gcf,'NextPlot','add');
axes;
set(gca,'Visible','off');
xlab = xlabel({'x (m)'},'fontw','b');
zlab = ylabel({'t (s)'},'fontw','b');
set(xlab,'Visible','on','Position',[.5 -.06 0]);
set(zlab,'Visible','on','Position',[-0.07 0.45 0]);

set(hfig2,'Units','Inches');
pos = get(hfig2,'Position');
set(hfig2,'PaperPositionMode','Auto',...
    'PaperUnits','Inches',...
    'PaperSize',[pos(3) pos(4)])


