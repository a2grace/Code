%%
close all

%============================
%States of the density interface
%============================

%=================================================
L5outs = [58 105 350 440];
M5outs = [100 114 140 320];
mytitles = {'M5' 'L5'};
mypaths = {M5path L5path};
mytimes = {M5outs L5outs};
myfigs = cell(1,length(mytimes));
num_figs = linspace(1,length(myfigs),length(myfigs));
M5pos = [.34 .07 .3 .1];
L5pos = [.4 .07 .2 .1];
%=================================================


for kk = 1:length(myfigs)
    myfigs{kk} = figure(num_figs(kk));
    set(myfigs{kk},'Name',(mytitles{kk}));
end

for jj = 1:length(mypaths)
    figure(myfigs{jj})
    cd((mypaths{jj}))
    gdpar = spins_gridparams('vector',false); split_gdpar; par2var(params);
    x = xgrid_reader();
    z = zgrid_reader();
    format short
    xticks = Lx*(0:.25:1);
    yticks = Lz*(0:.5:1);


    rho = spins_reader_new('rho',mytimes{jj}(1));
    ax1 = subplot(4,1,1);
    pcolor(x,z,rho), shading interp
    set(gca,'fontw','b',...
        'XLim',xlim,'YLim',zlim,...
        'XTick',[],'YTick',yticks);
    caxis([-.01 .01]), colormap(flipud(temperature)) 
    ta = text(mylabelxpos,mylabelzpos,'(a)',...
        'Units', 'Normalized', ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
        'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
    set(ta,'Visible','on');


    rho = spins_reader_new('rho',mytimes{jj}(2));
    ax2 = subplot(4,1,2);
    pcolor(x,z,rho), shading interp
    set(gca,'fontw','b',...
        'XLim',xlim,'YLim',zlim,...
        'XTick',[],'YTick',yticks);
    caxis([-.01 .01]), colormap(flipud(temperature)) 
    tb = text(mylabelxpos,mylabelzpos,'(b)',...
        'Units', 'Normalized', ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
        'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
    set(tb,'Visible','on');


    rho = spins_reader_new('rho',mytimes{jj}(3));
    ax3 = subplot(4,1,3);
    pcolor(x,z,rho), shading interp
    set(gca,'fontw','b',...
        'XLim',xlim,'YLim',zlim,...
        'XTick',[],'YTick',yticks);
    caxis([-.01 .01]), colormap(flipud(temperature)) 
    tc = text(mylabelxpos,mylabelzpos,'(c)',...
        'Units', 'Normalized', ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
        'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
    set(tc,'Visible','on');


    rho = spins_reader_new('rho',mytimes{jj}(4));
    ax4 = subplot(4,1,4);
    pcolor(x,z,rho), shading interp
    set(gca,'fontw','b',...
        'XLim',xlim,'YLim',zlim,...
        'XTick',xticks,'YTick',yticks);
    caxis([-.01 .01]), colormap(flipud(temperature)) 
    td = text(mylabelxpos,mylabelzpos,'(d)',...
        'Units', 'Normalized', ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
        'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
    set(td,'Visible','on');


    set(gcf,'NextPlot','add');
    axes;
    set(gca,'Visible','off');


    xlab = xlabel({'x (m)'},'fontsize',mylabelfontsize,'fontw','b');
    zlab = ylabel({'z (m)'},'fontsize',mylabelfontsize,'fontw','b');
    set(xlab,'Visible','on','Position',[.5 -.06 0]);
    set(zlab,'Visible','on','Position',[-.09 .45 0]);

    cb = colorbar;
    set(cb,'Location','eastoutside',...
        'fontsize',mylabelfontsize,'fontw','b',...
        'Direction','reverse','Position',[0.9300    0.1095    0.0357    0.8167]);
    caxis([-.01 .01])

    set(xlab,'Visible','on');
    set(zlab,'Visible','on');
    set(cb,'Visible','off');

    set(gcf,'Units','Inches');
    pos = get(gcf,'Position');
    set(gcf,'PaperPositionMode','Auto',...
        'PaperUnits','Inches',...
        'Papersize',[pos(3) pos(4)])
end 

%set boxes around important parts
ax = myfigs{1}.Children(5);
rectangle(ax,'Position',M5pos,'EdgeColor','w','Linew',3);
ax = myfigs{2}.Children(6);
rectangle(ax,'Position',L5pos,'EdgeColor','w','Linew',3);

%=================================================================
%Figure comparing the different intial instabilities for L5 and M5
%=================================================================

%M5 --  23 seconds
%L5 --  21 seconds

hfig = figure();
cd(M5path)
x = xgrid_reader();
z = zgrid_reader();
M5pos = [.34 .07 .3 .1];
L5pos = [.4 .07 .2 .1];
subplot(2,1,1)
dummy = spins_reader_new('rho',115);
pcolor(x,z,dummy), shading interp, colormap(flipud(temperature));
caxis([-.01 .01])
set(gca,'fontw','b',...
    'XLim',[M5pos(1) M5pos(1)+M5pos(3)],'YLim',[M5pos(2) M5pos(2)+M5pos(4)],...
    'XTick',[M5pos(1):M5pos(3)/5:M5pos(1)+M5pos(3)],...
    'YTick',[M5pos(2):M5pos(4)/5:M5pos(2)+M5pos(4)]);
axis([M5pos(1) M5pos(1)+M5pos(3) M5pos(2) M5pos(2)+M5pos(4)])
subplot(2,1,2)
cd(L5path)
dummy = spins_reader_new('rho',58);
pcolor(x,z,dummy), shading interp, colormap(flipud(temperature));
caxis([-.01 .01])
set(gca,'fontw','b',...
    'XLim',[L5pos(1) L5pos(1)+L5pos(3)],'YLim',[L5pos(2) L5pos(2)+L5pos(4)],...
    'XTick',[L5pos(1):L5pos(3)/5:L5pos(1)+L5pos(3)],...
    'YTick',[L5pos(2):L5pos(4)/5:L5pos(2)+L5pos(4)]);
axis([L5pos(1) L5pos(1)+L5pos(3) L5pos(2) L5pos(2)+L5pos(4)])

set(gcf,'NextPlot','add');
axes;
set(gca,'Visible','off');
xlab = xlabel({'x (m)'},'fontsize',mylabelfontsize,'fontw','b');
zlab = ylabel({'z (m)'},'fontsize',mylabelfontsize,'fontw','b');
set(xlab,'Visible','on','Position',[.5 -.06 0]);
set(zlab,'Visible','on','Position',[-.09 .50 0]);

set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto',...
    'PaperUnits','Inches',...
    'PaperSize',[pos(3) pos(4)])