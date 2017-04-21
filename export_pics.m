

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to create nice figures                  %
% Last modified March 15th, 2017                 %
% Andrew Grace, 2017                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FEB 25th 2017 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% y ticks done for evolution figure. %   
% Cleaned up search path declaration %
% for folder for initial state.      %
% Changed the specifications for     %
% first plot to be in a set          %
% statement.                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FEB 27th 2017 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure windows were sized differently
% and fixed for exporting. I still need
% to find a better way of exporting these
% figures as they are currently blurry
% when exported to an eps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MAR 15th 2017 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Added a plot of the pycnocline width vs time
%for each simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% APR 12 2017 %
%========================
%Added a bunch of stuff. Also separated into another
%file because this one was getting quite large.
%========================
%MAC PATH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path_lineplot = strcat('/Volumes/','Ext. Drive','/seiche2D/Notes/');
path_h005 = strcat('/Volumes/','Ext. Drive','/seiche2D/2048x1024/Amp0825/h005/');
path_h025 = strcat('/Volumes/','Ext. Drive','/seiche2D/2048x1024/Amp0825/h025/');
savepath = strcat('/Volumes/','Ext. Drive','/seiche2D/Notes/');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%WINDOWS PATH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% path_h005 = 'e:/seiche2D/2048x1024/Amp0825/h005/';
% path_h025 = 'e:/seiche2D/2048x1024/Amp0825/h025/';
% savepath = 'e:/seiche2D/Notes/';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




mylabelfontsize = 15;
mytickfontsize = 12;
mylabelxpos = 0.02;
mylabelzpos = 0.05;

%%%%%%% INITIAL STATES %%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hfig1 = figure(1);
% clf
% 
% cd(path_h005)
% gdpar = spins_gridparams('vector',false); split_gdpar;
% ax1 = subplot(2,1,1,'Position',[0.1300 0.5 0.7750 0.3412]);
% 
% x = xgrid_reader();
% z = zgrid_reader();
% rhoh005 = rho_reader(0);
% pcolor(x,z,rhoh005), shading interp
% set(gca,'fontsize',mytickfontsize,'fontw','b',...
%     'XLim',params.xlim,'YLim',params.zlim,...
%     'XTick',[],'YTick',[.05 .1 .15 .20 .25])
% 
% text(mylabelxpos,mylabelzpos,'(a)','Units', 'Normalized', ...
%     'VerticalAlignment', 'Bottom', 'HorizontalAlignment','left',...
%     'color','w','fontsize',mylabelfontsize,'fontweight','bold')
% 
% cd(path_h025)
% gdpar = spins_gridparams('vector',false); split_gdpar;
% 
% ax2 = subplot(2,1,2);
% 
% x = xgrid_reader();
% z = zgrid_reader();
% rhoh025 = rho_reader(0);
% pcolor(x,z,rhoh025), shading interp
% set(gca,'fontsize',mytickfontsize,'fontw','b',...
%     'XLim',params.xlim,'YLim',params.zlim,...
%     'XTick',[0 .25 .5 .75 1],'YTick',[.05 .1 .15 .20 .25])
% 
% text(mylabelxpos,mylabelzpos,'(b)','Units', 'Normalized', ...
%     'VerticalAlignment', 'Bottom', 'HorizontalAlignment','left',...
%     'color','w','fontsize',mylabelfontsize,'fontweight','bold')
% 
% 
% set(gcf,'NextPlot','add');
% axes;
% set(gca,'Visible','off');
% xlab = xlabel({'x (m)'},'fontsize',mylabelfontsize,'fontw','b');
% zlab = ylabel({'z (m)'},'fontsize',mylabelfontsize,'fontw','b');
% set(xlab,'Visible','on','Position',[.5 -.06 0]);
% set(zlab,'Visible','on','Position',[-0.07 0.45 0]);
% 
% cb = colorbar;
% set(cb,'Location','northoutside',...
%     'fontsize',mylabelfontsize,'fontw','b',...
%     'Direction','reverse','Position',[0.1304 0.88 0.7745 0.0386]);
% caxis([-0.01 0.01])
% colormap(flipud(temperature))
% %Figure window size is set to units of pixels. This is SCREEN DEPENDANT
% set(hfig1,'Units','Inches');
% pos = get(hfig1,'Position');
% set(hfig1,'PaperPositionMode','Auto',...
%     'PaperUnits','Inches',...
%     'PaperSize',[pos(3) pos(4)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% %%%%%%%%%%%%% VORTEX FOCUSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hfig2 = figure(2);
% clf
% 
% cd(path_h005)
% gdpar = spins_gridparams('vector',false); split_gdpar;
% 
% x = xgrid_reader();
% z = zgrid_reader();
% 
% ax1 = subplot(2,1,1,'Position',[0.1300 0.5 0.7750 0.3412]);
% pcolor(x,z,rho_reader(45)), shading interp
% set(ax1,'fontsize',mytickfontsize,'fontw','b',...
%     'XLim',params.xlim,'YLim',params.zlim,...
%     'XTick',[],...
%     'YTick', [0.05 0.1 0.15 0.2 .25])
% 
% t1 = text(mylabelxpos,mylabelzpos,'(a)',...
%     'Units', 'Normalized', ...
%     'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
%     'color','w','fontsize',mylabelfontsize,'fontweight','bold');  
% 
% hold on
% 
% 
% an1 = annotation('arrow',[0.4232 0.4732],[0.6382 0.6691]);
% set(an1,'Color','w','Linewidth',2)
% an2 = annotation('arrow',[0.6125 0.5607],[0.7000 0.6714]);
% set(an2,'Color','w','Linewidth',2)
% 
% ax2 = subplot(2,1,2);%,'Position',[0.1300 0.1100 0.7750 0.4412]);
% pcolor(x,z,rho_reader(60)), shading interp
% set(ax2,'fontsize',mytickfontsize,'fontw','b',...
%     'XLim',params.xlim,'YLim',params.zlim,...
%     'XTick',[0 0.25 0.5 0.75 1],...
%     'YTick', [0.05 0.1 0.15 0.2 .25])
% 
% t2 = text(mylabelxpos,mylabelzpos,'(b)',...
%     'Units', 'Normalized', ...
%     'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
%     'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
% 
% set(an1,'Visible','on'); set(an2,'Visible','on');
% 
% set(gcf,'NextPlot','add');
% axes;
% set(gca,'Visible','off');
% xlab = xlabel({'x (m)'},'fontsize',mylabelfontsize,'fontw','b');
% zlab = ylabel({'z (m)'},'fontsize',mylabelfontsize,'fontw','b');
% set(xlab,'Visible','on','Position',[.5 -.06 0]);
% set(zlab,'Visible','on','Position',[-.09 .45 0]);
% 
% cb = colorbar;
% set(cb,'Location','northoutside',...
%     'fontsize',mylabelfontsize,'fontw','b',...
%     'Direction','reverse','Position',[0.1304 0.88 0.7745 0.0386]);
% caxis([-0.01 0.01])
% colormap(flipud(temperature))
% 
% set(hfig2,'Units','Inches');
% pos = get(hfig2,'Position');
% set(hfig2,'PaperPositionMode','Auto',...
%     'PaperUnits','Inches',...
%     'PaperSize',[pos(3) pos(4)])
% 


%%%%%%% VARIOUS PICTURES OF EVOLUTION OF INTERFACE %%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%
% cd(path_h005);
% hfig3 = figure(3);
% clf
% 
% gdpar = spins_gridparams('vector',false); split_gdpar;
% 
% x = xgrid_reader();
% z = zgrid_reader();
% umax = 0.0165;
% umin = -umax;
% wmax = 0.04;
% wmin = -wmax;
% ax1 = subplot(2,1,1);
% b1 = contourf(x,z,spins_reader_new('u',38),8); shading interp;
% set(ax1,'fontsize',mytickfontsize,'fontw','b',...
%     'XLim',params.xlim,'YLim',params.zlim,...
%     'XTick',[],...
%     'YTick', [0.05 0.1 0.15 0.2 .25]);
% 
% t1 = text(mylabelxpos,mylabelzpos,'(a)',...
%     'Units', 'Normalized', ...
%     'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
%     'color','w','fontsize',mylabelfontsize,'fontweight','bold');  
% 
% cb1 = colorbar;
% set(cb1,'fontsize',mylabelfontsize,'fontw','b');
% 
% hold on
% 
% ax2 = subplot(2,1,2);%,'Position',[0.1300 0.1100 0.7750 0.4412]);
% b2 = contourf(x,z,spins_reader_new('w',38),8); shading interp;
% set(ax2,'fontsize',mytickfontsize,'fontw','b',...
%     'XLim',params.xlim,'YLim',params.zlim,...
%     'XTick',[0 0.25 0.5 0.75 1],...
%     'YTick', [0.05 0.1 0.15 0.2 .25]);
% 
% t2 = text(mylabelxpos,mylabelzpos,'(b)',...
%     'Units', 'Normalized',...
%     'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
%     'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
% 
% cb2 = colorbar;
% set(cb2,'fontsize',mylabelfontsize,'fontw','b');
% 
% set(t1,'Visible','on','color','k'); set(t2,'Visible','on','color','k');
% 
% set(gcf,'NextPlot','add');
% axes;
% set(gca,'Visible','off');
% xlab = xlabel({'x (m)'},'fontsize',mylabelfontsize,'fontw','b');
% zlab = ylabel({'z (m)'},'fontsize',mylabelfontsize,'fontw','b');
% set(xlab,'Visible','on','Position',[.5 -.06 0]);
% set(zlab,'Visible','on','Position',[-.09 .45 0]);
% 
% 
% %caxis([-0.01 0.01])
% colormap(temperature)
% 
% set(hfig3,'Units','Inches');
% pos = get(hfig3,'Position');
% set(hfig3,'PaperPositionMode','Auto',...
%     'PaperUnits','Inches',...
%     'PaperSize',[pos(3) pos(4)])
% 

%%%%%
% 
% %%%%%
% ax3 = subplot(2,2,3,'Position',[0.1 0.1100 0.3175 0.3412]);
% pcolor(x,z,rho_reader(90)), shading interp, axis normal
% set(gca,'fontsize',mytickfontsize,'fontw','b',...
%      'XTick', [0 0.25 0.5 0.75 1],...
%      'YTick', [.05 .1 .15 .2 .25],...
%      'XLim', params.xlim,...
%      'YLim', params.zlim)
% 
% text(mylabelxpos,mylabelzpos,'(c)','Units', 'Normalized', ...
%     'VerticalAlignment', 'top', 'HorizontalAlignment','left',...
%     'color','w','fontsize',mylabelfontsize,'fontweight','bold')
% rectangle('Position',[.45 .08 .2 .08],...
%     'edgecolor','w','linewidth',0.1*mytickfontsize);
% %%%%%
% 
% %%%%%
% ax4 = subplot(2,2,4,'Position',[0.5503 0.1100 0.3175 0.3412]);
% pcolor(x,z,rho_reader(90)), shading interp, axis([.45 .65 .08 .16])
% set(gca,'fontsize',mytickfontsize,'fontw','b',...
%      'XTick', [.5 .55 .6],...
%      'YTick', [.08 .12 .16])
% 
% 
% text(mylabelxpos,mylabelzpos,'(d)','Units', 'Normalized', ...
%     'VerticalAlignment', 'top', 'HorizontalAlignment','left',...
%     'color','w','fontsize',mylabelfontsize,'fontweight','bold')
% %%%%%

% set(gcf,'NextPlot','add');
% axes;
% set(gca,'Visible','off');
% xlab = xlabel({'x','(m)'},'fontsize',mylabelfontsize,'fontweight','bold');
% ylab = ylabel({'z','(m)'},'fontsize',mylabelfontsize,'fontweight','bold');
% set(xlab,'Visible','on','Position',[0.455 -0.04]);
% set(ylab,'Visible','on','Position',[-0.08 0.5]);
% colormap(flipud(temperature))
% cb = colorbar;
% caxis([-0.01 0.01])
% set(cb,'Visible','on','Position',[0.91 0.1095 0.02 0.8167],...
%     'fontsize',mytickfontsize,'Direction','reverse');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Line plots of the area between two contours %%%%%%%%%%%%%

% cd(path_lineplot)
% %We are going to create 2 plots here, one with the h005 runs and one
% %with the h025 runs
% close all
% plotskip = 20;
% %%%%% h005 %%%%%%
% load structv.mat
% hfig4 = figure(4);
% hold on
% p1 = plot(t1(1:plotskip:end),L5(1:plotskip:end)); 
% p2 = plot(t1(1:plotskip:end),M5(1:plotskip:end));
% p3 = plot(t1(1:plotskip:end),S5(1:plotskip:end));
% 
% set(p1,'LineWidth',1.5,'Color','k',...
%     'Marker','+','MarkerSize',6)
% 
% set(p2,'LineWidth',1.5,'Color','k',...
%     'Marker','^','MarkerSize',6)
% 
% set(p3,'LineWidth',1.5,'Color','k',...
%     'Marker','o','MarkerSize',6)
% 
% set(gca,'fontsize',mytickfontsize,'fontw','b')
% xlab = xlabel({'t','(s)'},'fontsize',mylabelfontsize,'fontweight','bold');
% ylab = ylabel({'Area due to pycnocline widening','(m)'},...
%     'fontsize',mylabelfontsize,'fontweight','bold');
% leg = legend('\eta_0 = 0.0825m','\eta_0 = 0.065m','\eta_0 = 0.05m');
% set(leg,'Location','northwest')
% 
% set(hfig4,'Units','Inches');
% pos = get(hfig4,'Position');
% set(hfig4,'PaperPositionMode','Auto',...
%     'PaperUnits','Inches',...
%     'PaperSize',[pos(3) pos(4)])
% 
% %%%%% h025 %%%%%
% hfig5 = figure(5);
% 
% hold on
% p1 = plot(t2(1:plotskip:end),L25(1:plotskip:end)); 
% p2 = plot(t2(1:plotskip:end),M25(1:plotskip:end));
% p3 = plot(t1(1:plotskip:end),S5(1:plotskip:end));
% 
% set(p1,'LineWidth',1.5,'Color','k',...
%     'Marker','+','MarkerSize',6)
% 
% set(p2,'LineWidth',1.5,'Color','k',...
%     'Marker','^','MarkerSize',6)
% 
% set(p3,'LineWidth',1.5,'Color','k',...
%     'Marker','o','MarkerSize',6)
% 
% set(gca,'fontsize',mytickfontsize,'fontw','b')
% xlab = xlabel({'t','(s)'},'fontsize',mylabelfontsize,'fontweight','bold');
% ylab = ylabel({'Area due to pycnocline widening','(m)'},'fontsize',mylabelfontsize,'fontweight','bold');
% leg = legend('\eta_0 = 0.0825m','\eta_0 = 0.065m','\eta_0 = 0.05m');
% set(leg,'Location','northwest')
% 
% set(hfig5,'Units','Inches');
% pos = get(hfig5,'Position');
% set(hfig5,'PaperPositionMode','Auto',...
%     'PaperUnits','Inches',...
%     'PaperSize',[pos(3) pos(4)])
%%

%%% INITIAL ROLLUP %%%%%
% 
% hfig6 = figure(6);
% clf
% 
% cd(path_h005)
% gdpar = spins_gridparams('vector',false); split_gdpar;
% ax1 = subplot(2,1,1,'Position',[0.1300 0.5 0.7750 0.3412]);
% 
% x = xgrid_reader();
% z = zgrid_reader();
% pcolor(x,z,spins_reader_new('rho',40)), shading interp
% set(gca,'fontsize',mytickfontsize,'fontw','b',...
%     'XLim',params.xlim,'YLim',params.zlim,...
%     'XTick',[0 .25 .5 .75 1],'YTick',[ .05 .1 .15 .20 .25])
% 
% text(mylabelxpos,mylabelzpos,'(a)','Units', 'Normalized', ...
%     'VerticalAlignment', 'Bottom', 'HorizontalAlignment','left',...
%     'color','w','fontsize',mylabelfontsize,'fontweight','bold')
% rectangle('Position',[.43 .1 .17 .06],...
%      'edgecolor','w','linewidth',0.15*mytickfontsize);
% 
% ax2 = subplot(2,1,2);
% pcolor(x,z,spins_reader_new('rho',40)), shading interp, axis([.43 .6 .1 .16])
% set(gca,'fontsize',mytickfontsize,'fontw','b',...
%    'XTick',[.44 .48 .52 .56 .6],'YTick',[.1 .12 .14 .16])
% 
% text(mylabelxpos,mylabelzpos,'(b)','Units', 'Normalized', ...
%     'VerticalAlignment', 'Bottom', 'HorizontalAlignment','left',...
%     'color','w','fontsize',mylabelfontsize,'fontweight','bold')
% 
% 
% set(gcf,'NextPlot','add');
% axes;
% set(gca,'Visible','off');
% xlab = xlabel({'x (m)'},'fontsize',mylabelfontsize,'fontw','b');
% zlab = ylabel({'z (m)'},'fontsize',mylabelfontsize,'fontw','b');
% set(xlab,'Visible','on','Position',[.5 -.06 0]);
% set(zlab,'Visible','on','Position',[-0.07 0.45 0]);
% 
% cb = colorbar;
% set(cb,'Location','northoutside',...
%     'fontsize',mylabelfontsize,'fontw','b',...
%     'Direction','reverse','Position',[0.1304 0.88 0.7745 0.0386]);
% caxis([-0.01 0.01])
% colormap(flipud(temperature))
% set(hfig6,'Units','Inches');
% pos = get(hfig6,'Position');
% set(hfig6,'PaperPositionMode','Auto',...
%     'PaperUnits','Inches',...
%     'PaperSize',[pos(3) pos(4)])


%%%%% To print whatever figure you are working on %%%%%

%print(figurename,'-dpdf','filename','-r0')



