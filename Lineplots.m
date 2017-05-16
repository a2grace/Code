%==========
%Basic sates of the perturbed cases
%==========

%This code makes a contour plots showing the basic states of the perturbed
%cases. The only two contours are rhohigh and rholow.

%Going to make a 3 row by 2 column figure to show all the states. One
%column will be Ln* and the other column will be Sn*

%Background state
%psi = @(z_0,eta_0,L,eps,n,x) z_0 + eta_0*cos(pi*x/L) + eps*eta_0*cos(n*pi*x/L);


Ln2path = strcat('/Volumes/','Ext. Drive','/seiche2D/Ln2');
Ln4path = strcat('/Volumes/','Ext. Drive','/seiche2D/Ln4');
Ln5path = strcat('/Volumes/','Ext. Drive','/seiche2D/Ln5');

Sn2path = strcat('/Volumes/','Ext. Drive','/seiche2D/Sn2');
Sn4path = strcat('/Volumes/','Ext. Drive','/seiche2D/Sn4');
Sn5path = strcat('/Volumes/','Ext. Drive','/seiche2D/Sn5');

control_eta_0 = 0.0825;
psi = @(z_0,eta_0,Lx,da,n,x) z_0 + eta_0*cos(pi*x/Lx) + da*eta_0*cos(n*pi*x/Lx);
myannos = {'(i)' '(ii)' '(iii)' '(iv)' '(v)' '(vi)'};
mypaths = {Ln2path Ln4path Ln5path Sn2path Sn4path Sn5path};
hfig = figure();
for ii = 1:length(mypaths)
    cd(mypaths{ii})
    gdpar = spins_gridparams('vector', false); split_gdpar; 
    par2var(params);
    par2var(gd);
    subplot(2,3,ii)
    
    plot(x,psi(z_0,eta_0,Lx,da,n,x),'k','Linewidth',2.5)
    hold on
    plot(x,psi(z_0,control_eta_0,Lx,0,0,x),'Color',[1 0 0 .5],...
        'Linewidth',2.5);
    
    text(mylabelxpos,mylabelzpos,(myannos{ii}),...
        'Units', 'Normalized', ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment','left',...
        'color','k','fontsize',mylabelfontsize,'fontweight','bold'); 
    
    set(gca,'fontsize',mytickfontsize,'fontw','b',...
           'XLim',[min_x Lx],'YLim',[min_z Lz],...
           'XTick',Lx*(0:1/4:1),'YTick',Lz*(0:1/5:1)) 
    grid on
    
    if ii == 1 
        set(gca,'Xticklabel',[])
        
    elseif ii>1 && ii<4 
        set(gca,'XTickLabel',[],'YTicklabel',[])
       
    elseif ii > 4
        set(gca,'YTickLabel',[])    
       
    end

end
set(gcf,'NextPlot','add');
axes;
set(gca,'Visible','off');
xlab = xlabel({'x (m)'},'fontsize',mylabelfontsize,'fontw','b');
zlab = ylabel({'z (m)'},'fontsize',mylabelfontsize,'fontw','b');
set(xlab,'Visible','on','Position',[.5 -.06 0]);
set(zlab,'Visible','on','Position',[-.09 .5 0]);

set(hfig,'Units','Inches');
pos = get(hfig,'Position');
set(hfig,'PaperPositionMode','Auto',...
    'PaperUnits','Inches',...
    'PaperSize',[pos(3) pos(4)])

%%

%========
%Line plot to compare the pycncline width between cases
%========


close all
clear 
%MACPATH=========================================================
savepath = strcat('/Volumes/','Ext. Drive','/Notes/Pictures/');
datapath = strcat('/Volumes/','Ext. Drive','/Data');
%WINPATH=========================================================
% savepath = 'e:/Notes/Pictures/';
% datapath = 'e:/Data/';
%================================================================

cd(datapath)

mylabelfontsize = 15;
mytickfontsize = 12;
mylabelxpos = 0.02;
mylabelzpos = 0.05;

plotskip = 20;
plotmax = 451;
load myarea.mat
Nx = 2048;
Nz = 1024;
Lx = 1;
Lz = 0.25;

dx = Lx/Nx;
dz = Lz/Nz;

myplots = {L5 M5 S5};
legendtitles = {'L5' 'M5' 'S5'};
mymarkers = {'+' '^' 'x' 's' '*' '.' 'd' 'o' 'n' '>' '<' 'p' 'h'};

hfig = figure();
hold on
for ii = 1:length(myplots)    
    plot(t1(1:plotskip:plotmax),dx*dz*myplots{ii}(1:plotskip:plotmax),...
        'Linewidth',2,'Color','k','Marker',(mymarkers{ii}),...
        'MarkerSize',8);
end
grid on
set(gca,'fontsize',mytickfontsize,'fontw','b')
xlab = xlabel({'t(s)'},'fontsize',mylabelfontsize,'fontweight','bold');
ylab = ylabel({'Fluid entrained during evolution (m^2)'},...
    'fontsize',mylabelfontsize,'fontweight','bold');

leg = legend(legendtitles{:});
set(leg,'Location','northwest')
set(xlab,'Visible','on')
set(ylab,'Visible','on')

set(hfig,'Units','Inches');
pos = get(hfig,'Position');
set(hfig,'PaperPositionMode','Auto',...
    'PaperUnits','Inches',...
    'PaperSize',[pos(3) pos(4)])
