%%
%==================
%Comparison of the space-time plots over a 50 second time interval -- Will
%do up to 5 plots per figure
%==================
close all
clear all
%The user should only have to change the following lines. The path
%specifies where the data is. mytitles is a cell array where entries MUST
%match the titles of the data in the .mat file specified in mydata
%=======================================================================
datapath = strcat('/Volumes/','Ext. Drive','/Data');
mydata = {'L5_spacetime.mat' 'M5_spacetime.mat' 'S5_spacetime.mat'};
mytitles = {'mix_mag'};
scale = 1; %normalization constant for each of the spacetime plots
mylabelfontsize = 15;
mytickfontsize = 12;
mylabelxpos = 0.02;
mylabelzpos = 0.05;
%=======================================================================




cd(datapath)
max_scales = zeros(length(mydata),length(mytitles));

%Will do up to 5 plots per figure, any more and things get a little
%cluttered
myfields = cell(1,length(mytitles));
myannos = {'(i)' '(ii)' '(iii)' '(iv)' '(v)'};


myfigs = cell(1,length(mytitles));
num_figs = linspace(1,length(mytitles),length(mytitles));

for kk = 1:length(myfigs)
    myfigs{kk} = figure(num_figs(kk));
    set(myfigs{kk},'Name',(mytitles{kk}));
end

for ii = 1:length(mydata)
    load((mydata{ii}));
    max_scales = (delta_rho/(2*h_halfwidth))^2;% kappa_rho*delta_rho^2/(2*h_halfwidth)^4];
    final_time = 50;
    
    numticks = 5;
    numouts = final_time/plot_interval;
    
    xs = linspace(0,Lx,Nx);
    ts = linspace(0,final_time,numouts+1);
    
    multipliers = [1e8];
    [xx,tt] = meshgrid(xs,ts);
    for ll = 1:length(mytitles);
        if ~exist(mytitles{ll})
            error(strcat('You have a field that may not exist '))
            break;
        end
        dummy = eval((mytitles{ll}));
        myfields{ll} = (dummy(:,1:numouts+1))';
    end
    
    for jj = 1:length(myfigs)
        figure(myfigs{jj});
        plotme = abs((myfields{jj}))/max_scales(jj);
        disp([num2str(max(max(log10(plotme)))) ' is max for ' mydata{ii} ' ' mytitles{jj}])
        subplot(1,length(mydata),ii)
        pcolor(xx,tt,log10(plotme)), shading interp, caxis([-1 3.9])
        
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
    figure(num_figs(kk));
    colormap hot

    set(myfigs{kk},'NextPlot','add');
    axes;
    set(gca,'Visible','off');
    xlab = xlabel({'x (m)'},'fontsize',mylabelfontsize,'fontw','b');
    zlab = ylabel({'t (s)'},'fontsize',mylabelfontsize,'fontw','b');
    set(xlab,'Visible','on','Position',[.5 -.06 0]);
    set(zlab,'Visible','on','Position',[-.09 .45 0]);
    cb = colorbar;
    caxis([-1 3.9])
    set(cb,'Location','northoutside',...
        'fontsize',15,'fontw','b',...
        'Position',[0.1304 0.93 0.7745 0.0286],...
        'Ticks',-1:2.45:3.9);
    
    myeps = 1000;
    set(myfigs{kk},'Units','Inches');
    pos = get(myfigs{kk},'Position');
    set(myfigs{kk},'Position',[pos(1:2)/4 pos(3) pos(4)*1.3])
    set(myfigs{kk},'PaperPositionMode','Auto',...
        'PaperUnits','Inches',...
        'PaperSize',[pos(3) pos(4)*1.4])
end 
