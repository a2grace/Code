% APR 12 2017 %
%========================
%Created document
%migrated over from export_pics.m
%Make hovmoller pictures
%========================
clear all
close all


%MAC PATH=============================================================
diagram_path = strcat('/Volumes/','Ext. Drive','/Data');
savepath = strcat('/Volumes/','Ext. Drive','/Notes/Pictures/');
S5path = strcat('/Volumes/','Ext. Drive','/seiche2D/S5');
M5path = strcat('/Volumes/','Ext. Drive','/seiche2D/M5');
L5path = strcat('/Volumes/','Ext. Drive','/seiche2D/L5');
%=====================================================================

%WINDOWS PATH=========================================================
% diagpath = 'e:/seiche2D/Notes';
% savepath = 'e:/seiche2D/Notes/';
% datapath = 'e:/seiche2D/2048x1024/Amp0825/h005/';
%=====================================================================

%===================
%Make varsum, mixsum, KEsum, rhosum, uz hovmoller plots
%===================

mylabelfontsize = 15;
mytickfontsize = 12;
mylabelxpos = 0.02;
mylabelzpos = 0.05;


%% 
%==================
%Control Run
%==================
cd(diagram_path)
load control.mat
mylabelfontsize = 15;
mytickfontsize = 12;
mylabelxpos = 0.02;
mylabelzpos = 0.05;
%===========
%Variability
%===========



hfig1 = figure();
varsum = varsum'/Nz;
mymaxvar = max(max(varsum));
myminvar = min(min(varsum));
mytitle = 'Variability';
numticks = 3;


numouts = final_time/plot_interval;

xs = linspace(0,Lx,Nx);
ts = linspace(0,final_time,numouts+1);

[xx,tt] = meshgrid(xs,ts);

colormap(temperature)

pcolor(xx,tt,varsum), shading interp
caxis([myminvar mymaxvar]);
title(mytitle);
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 Lx],'YLim',[0 final_time],...
   'XTick',[0 Lx/2 Lx],'YTick',-0:final_time/numticks:final_time)

t1 = text(mylabelxpos,mylabelzpos,'(a)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
set(t1,'Visible','off');

xlab = xlabel({'x (m)'},'fontw','b');
zlab = ylabel({'t (s)'},'fontw','b');
cb = colorbar;

set(xlab,'Visible','on');
set(zlab,'Visible','on');
set(cb,'Visible','on');


set(hfig1,'Units','Inches');
pos = get(hfig1,'Position');
set(hfig1,'PaperPositionMode','Auto',...
    'PaperUnits','Inches',...
    'PaperSize',[pos(3) pos(4)])



%% 
%===========
%Mixing
%===========



hfig2 = figure(2);
mixsum= mixsum'/Nz;
mymaxmix = max(max(mixsum));
myminmix = min(min(mixsum));
mytitle = 'Mixing';
numticks = 3;


numouts = final_time/plot_interval;

xs = linspace(0,Lx,Nx);
ts = linspace(0,final_time,numouts+1);

[xx,tt] = meshgrid(xs,ts);

colormap(temperature)

pcolor(xx,tt,mixsum), shading interp
caxis([myminmix mymaxmix]);
title(mytitle);
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 Lx],'YLim',[0 final_time],...
   'XTick',[0 Lx/2 Lx],'YTick',-0:final_time/numticks:final_time)

t1 = text(mylabelxpos,mylabelzpos,'(a)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
set(t1,'Visible','off');

xlab = xlabel({'x (m)'},'fontw','b');
zlab = ylabel({'t (s)'},'fontw','b');
cb = colorbar;

set(xlab,'Visible','on');
set(zlab,'Visible','on');
set(cb,'Visible','on');


set(hfig2,'Units','Inches');
pos = get(hfig2,'Position');
set(hfig2,'PaperPositionMode','Auto',...
    'PaperUnits','Inches',...
    'PaperSize',[pos(3) pos(4)])

%===========
%Pycnocline Width
%===========



hfig3 = figure(3);
rhosum= rhosum'; %The data is already normalized over Nz
mymaxwidth = max(max(rhosum));
myminwidth = min(min(rhosum));
mytitle = 'Pycnocline Width';
numticks = 3;


numouts = final_time/plot_interval;

xs = linspace(0,Lx,Nx);
ts = linspace(0,final_time,numouts+1);

[xx,tt] = meshgrid(xs,ts);

colormap(temperature)

pcolor(xx,tt,rhosum), shading interp
caxis([myminwidth mymaxwidth]);
title(mytitle);
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 Lx],'YLim',[0 final_time],...
   'XTick',[0 Lx/2 Lx],'YTick',-0:final_time/numticks:final_time)

t1 = text(mylabelxpos,mylabelzpos,'(a)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
set(t1,'Visible','off');

xlab = xlabel({'x (m)'},'fontw','b');
zlab = ylabel({'t (s)'},'fontw','b');
cb = colorbar;

set(xlab,'Visible','on');
set(zlab,'Visible','on');
set(cb,'Visible','on');


set(hfig3,'Units','Inches');
pos = get(hfig3,'Position');
set(hfig3,'PaperPositionMode','Auto',...
    'PaperUnits','Inches',...
    'PaperSize',[pos(3) pos(4)])

%===================================
%Vertical Shear
%===================================

hfig4 = figure(4);
uz = uz'; 
mymaxshear = max(max(uz));
myminshear = min(min(uz));
mytitle = 'Vertical Shear';
numticks = 3;


numouts = final_time/plot_interval;

xs = linspace(0,Lx,Nx);
ts = linspace(0,final_time,numouts+1);

[xx,tt] = meshgrid(xs,ts);

colormap(temperature)

pcolor(xx,tt,uz), shading interp
caxis([myminshear mymaxshear]);
title(mytitle);
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 Lx],'YLim',[0 final_time],...
   'XTick',[0 Lx/2 Lx],'YTick',-0:final_time/numticks:final_time)

t1 = text(mylabelxpos,mylabelzpos,'(a)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
set(t1,'Visible','off');

xlab = xlabel({'x (m)'},'fontw','b');
zlab = ylabel({'t (s)'},'fontw','b');
cb = colorbar;

set(xlab,'Visible','on');
set(zlab,'Visible','on');
set(cb,'Visible','on');


set(hfig4,'Units','Inches');
pos = get(hfig4,'Position');
set(hfig4,'PaperPositionMode','Auto',...
    'PaperUnits','Inches',...
    'PaperSize',[pos(3) pos(4)])


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
mysize = linspace(1,length(myfigs),length(myfigs));
M5pos = [.34 .07 .3 .1];
L5pos = [.4 .07 .2 .1];
%=================================================


for kk = 1:length(myfigs)
    myfigs{kk} = figure(mysize(kk));
    set(myfigs{kk},'Name',(mytitles{kk}));
end

for jj = 1:length(mypaths)
    figure(myfigs{jj})
    cd((mypaths{jj}))
    gdpar = spins_gridparams('vector',false); split_gdpar; par2var(params);
    x = xgrid_reader();
    z = zgrid_reader();
    format short
    xticks = Lx*0:.25:1;
    yticks = Lz*.25:.25:1;


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

%%
%=====================
%Spacetime plots
%=====================

hfig6 = figure(6);
cd(diagram_path)
load('M5_spacetime.mat')
mymaxwidth = max(max(rhosum));
myminwidth = min(min(rhosum));
widthtitle = 'Pycnocline Width';
mymaxmix = max(max(mixsum));
myminmix = min(min(mixsum));
mixtitle = 'Mixing';
mymaxvar = max(max(varsum));
myminvar = min(min(varsum));
vartitle = 'Variability';
numticks = 3;


numouts = final_time/plot_interval;

xs = linspace(0,Lx,Nx);
ts = linspace(0,final_time,numouts+1);

[xx,tt] = meshgrid(xs,ts);


colormap((hot))
ax1 = subplot(1,3,1);
pcolor(xx,tt,varsum'/mymaxvar), shading interp
caxis([0 1]);
title(vartitle);
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 Lx],'YLim',[0 final_time],...
   'XTick',[0 Lx/2 Lx],'YTick',0:final_time/numticks:final_time)
te = text(mylabelxpos,mylabelzpos,'(e)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
set(te,'Visible','on');


ax2 = subplot(1,3,2);
pcolor(xx,tt,mixsum'/mymaxmix), shading interp
caxis([0 1]);
title(mixtitle);
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 Lx],'YLim',[0 final_time],...
   'XTick',[0 Lx/2 Lx],'YTick',0:final_time/numticks:final_time)
tf = text(mylabelxpos,mylabelzpos,'(f)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
set(tf,'Visible','on');


ax3 = subplot(1,3,3);
pcolor(xx,tt,rhosum'/mymaxwidth), shading interp
caxis([0 1]);
title(widthtitle);
set(gca,'fontsize',mytickfontsize,'fontw','b',...
   'XLim',[0 Lx],'YLim',[0 final_time],...
   'XTick',[0 Lx/2 Lx],'YTick',0:final_time/numticks:final_time)
tg = text(mylabelxpos,mylabelzpos,'(g)',...
    'Units', 'Normalized', ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
    'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
set(tg,'Visible','on');

for ii = 1:3
hline1 = line(subplot(1,3,ii),[0 Lx], [tt(timestamp(1),1) tt(timestamp(1),1)],...
    'Color','w','linewidth',1,'linestyle','-'); %reference line at 11s
hline2 = line(subplot(1,3,ii),[0 Lx], [tt(timestamp(2),1) tt(timestamp(2),1)],...
    'Color','w','linewidth',1,'linestyle','--'); %reference line at 21s
hline3 = line(subplot(1,3,ii),[0 Lx], [tt(timestamp(3),1) tt(timestamp(3),1)],...
    'Color','w','linewidth',1,'linestyle',':'); %reference line at 70s
hline4 = line(subplot(1,3,ii),[0 Lx], [tt(timestamp(4),1) tt(timestamp(4),1)],...
    'Color','w','linewidth',1,'linestyle','-.'); %reference line at 88s
end

set(gcf,'NextPlot','add');
axes;
set(gca,'Visible','off');
xlab = xlabel({'x (m)'},'fontsize',mylabelfontsize,'fontw','b');
zlab = ylabel({'t (s)'},'fontsize',mylabelfontsize,'fontw','b');
set(xlab,'Visible','on','Position',[.5 -.06 0]);
set(zlab,'Visible','on','Position',[-.09 .45 0]);

set(hfig6,'Units','Inches');
pos = get(hfig6,'Position');
set(hfig6,'PaperPositionMode','Auto',...
    'PaperUnits','Inches',...
    'PaperSize',[pos(3) pos(4)])

%%
%==================
%Comparison of the space-time plots over a 50 second time interval -- Will
%do up to 5 plots per figure
%==================
close all

%The user should only have to change the following lines. The path
%specifies where the data is. mytitles is a cell array where entries MUST
%match the titles of the data in the .mat file specified in mydata
%=======================================================================
datapath = strcat('/Volumes/','Ext. Drive','/Data');
mydata = {'L5_spacetime.mat' 'M5_spacetime.mat' 'S5_spacetime.mat'};
mytitles = {'variability' 'mixsum' 'bob'};
scale = 1; %normalization constant for each of the spacetime plots
mylabelfontsize = 15;
mytickfontsize = 12;
mylabelxpos = 0.02;
mylabelzpos = 0.05;
%=======================================================================




cd(datapath)
myscales = struct;
for index = 1:length(mydata)
    stopchar = strfind((mydata{index}),'_');
    myscales.(mydata{index}(1:stopchar-1)) = [];
end  
casenames = fieldnames(myscales);

%Will do up to 5 plots per figure, any more and things get a little
%cluttered
myfields = cell(1,length(mytitles));
myannos = {'(i)' '(ii)' '(iii)' '(iv)' '(v)'};


myfigs = cell(1,length(mytitles));
mysize = linspace(1,length(mytitles),length(mytitles));

for kk = 1:length(myfigs)
    myfigs{kk} = figure(mysize(kk));
    set(myfigs{kk},'Name',(mytitles{kk}));
end

for ii = 1:length(mydata)
    load((mydata{ii}));

    %final_time = 50;
    
    numticks = 5;
    numouts = final_time/plot_interval;
    
    xs = linspace(0,Lx,Nx);
    ts = linspace(0,final_time,numouts+1);

    [xx,tt] = meshgrid(xs,ts);

    %Find the maximum values of all fields to normalize. This is not a very
    %good way of doing this. Consider changing it.
    for ll = 1:length(mytitles);
        if ~exist(mytitles{ll})
            error(strcat('You have a field that may not exist '))
            break;
        end
        dummy = eval((mytitles{ll}));
        myfields{ll} = (dummy(:,1:numouts+1)/Nz)';
        myscales.casenames{ii}(ll) = max(max(myfields{ll}));
    end
    
    for jj = 1:length(myfigs)
        figure(myfigs{jj});
        plotme = (myfields{jj})/myscales.casenames{1}(jj);
        subplot(1,length(mydata),ii)
        pcolor(xx,tt,plotme), shading interp, caxis([0 1])
        
        if ii == 1
            
            set(gca,'fontsize',mytickfontsize,'fontw','b',...
               'XLim',[0 Lx],'YLim',[0 final_time],...
               'XTick',[0 Lx/2 Lx],'YTick',0:final_time/numticks:final_time)
        else
            set(gca,'fontsize',mytickfontsize,'fontw','b',...
               'XLim',[0 Lx],'YLim',[0 final_time],...
               'XTick',[0 Lx/2 Lx],'YTick',[])
        end
           
        text(mylabelxpos,mylabelzpos,(myannos{ii}),...
            'Units', 'Normalized', ...
            'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
            'color','w','fontsize',mylabelfontsize,'fontweight','bold'); 
    end
    
end
 
for kk = 1:length(myfigs)
    figure(mysize(kk));
    colormap hot

    set(myfigs{kk},'NextPlot','add');
    axes;
    set(gca,'Visible','off');
    xlab = xlabel({'x (m)'},'fontsize',mylabelfontsize,'fontw','b');
    zlab = ylabel({'t (s)'},'fontsize',mylabelfontsize,'fontw','b');
    set(xlab,'Visible','on','Position',[.5 -.06 0]);
    set(zlab,'Visible','on','Position',[-.09 .45 0]);
    
    cb = colorbar;
    set(cb,'Location','northoutside',...
        'fontsize',15,'fontw','b',...
        'Position',[0.1304 0.93 0.7745 0.0286],...
        'Ticks',[0 .5 1]);
    
    myeps = 1000;
    set(myfigs{kk},'Units','Inches');
    pos = get(myfigs{kk},'Position');
    set(myfigs{kk},'Position',[pos(1:2)/4 pos(3) pos(4)*1.3])
    set(myfigs{kk},'PaperPositionMode','Auto',...
        'PaperUnits','Inches',...
        'PaperSize',[pos(3) pos(4)*1.4])
end 





