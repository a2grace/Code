clear 
close all

data_path = '/work/a2grace/hov/';
save_path = '/work/a2grace/figures/';

load hov_KE.mat

%take a slice through ny = 1;
mylabelfontsize = 15;
mytickfontsize = 12;
mylabelxpos = 0.02;
mylabelzpos = 0.05;

hfig1 = figure(1);

xs = linspace(0,1,Nx);
tmax = 58;
ts3D = linspace(0,58,58/plot_interval + 1);

[xx,tt] = meshgrid(xs,ts3D);
colorbar
colormap(bone)
mymincolor = 0;
mymaxcolor = 2.5e3;



%KE1 = squeeze(KEsum(:,512,:))';

ax1 = subplot(1,2,1);
pcolor(xx,tt,KE1), shading interp
caxis([mymincolor mymaxcolor])
title('y avg L253D')
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 1],'YLim',[0 58],...
   'XTick',[0 .5 1],'YTick',0:10:60)
t1 = text(mylabelxpos,mylabelzpos,'(a)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 

% 
% KE2 = squeeze(KEsum(:,256,:))';
% ax2 = subplot(1,3,2);
% pcolor(xx,tt,KE2), shading interp
% caxis([mymincolor mymaxcolor]);
% %title('L253D y = 0.05 m','fontw','b')
% set(gca,'fontsize',mytickfontsize,'fontw','b',...
%    'XLim',[0 1],'YLim',[0 58],...
%    'XTick',[0 .5 1],'YTick',[])
% 
% t2 = text(mylabelxpos,mylabelzpos,'(b)',...
%     'Units', 'Normalized', ...
%     'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
%     'color','w','fontsize',mylabelfontsize,'fontweight','bold');

load L25.mat

ts2D = linspace(0,58,58/plot_interval + 1);
[xx,tt] = meshgrid(xs,ts2D);

KE3 = KEsum(:,1:58/plot_interval + 1)';
ax3 = subplot(1,2,2);
pcolor(xx,tt,KE3), shading interp
caxis([mymincolor mymaxcolor]);
title('L25')
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

print(hfig1,'-dpdf','KE','-opengl')


% hfig2 = figure(2);
% [xx,tt] = meshgrid(xs,ts3D);
% KEdiff1 = abs(KE1-KE3);
% ax4 = subplot(1,2,1);
% pcolor(xx,tt,KEdiff1), shading interp
% set(gca,'fontsize',mytickfontsize,'fontw','b',...
%    'XLim',[0 1],'YLim',[0 58],...
%    'XTick',[0 .5 1],'YTick',0:10:60)
% colormap(bone)
% 
% KEdiff2 = abs(KE2-KE3);
% ax5 = subplot(1,2,2);
% pcolor(xx,tt,KEdiff2), shading interp
% set(gca,'fontsize',mytickfontsize,'fontw','b',...
%    'XLim',[0 1],'YLim',[0 58],...
%    'XTick',[0 .5 1],'YTick',0:10:60)
% colormap(bone)
% 
% set(gcf,'NextPlot','add');
% axes;
% set(gca,'Visible','off');
% title('KE difference');
% xlab = xlabel({'x (m)'},'fontw','b');
% zlab = ylabel({'t (s)'},'fontw','b');
% set(xlab,'Visible','on','Position',[.5 -.06 0]);
% set(zlab,'Visible','on','Position',[-0.07 0.45 0]);
% 
% 
% set(hfig2,'Units','Inches');
% pos = get(hfig2,'Position');
% set(hfig2,'PaperPositionMode','Auto',...
%     'PaperUnits','Inches',...
%     'PaperSize',[pos(3) pos(4)])