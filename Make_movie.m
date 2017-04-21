
%
% HISTORY
% 2013-10-24 Created by CWM
% 2015-03-11 Modified by CWM
%   - General tidying
% 2015-07-21 Modified by Ben so that it works on Belize
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The MIT License (MIT)
% 
% Copyright (c) 2013 Christopher W. MacMinn
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all;

%============================================================
% This code allows the user to make an AVI movie. It's not great, but it
% works quite well. I haven't tried to make a moivie with a different file 
% format just yet, but feel free to do so.
% ============================================================


%=============================================================
% In my experience, I find putting fig2frame.m in the ~/Document/MATLAB/ 
% folder and this file either in the directory where your data is located
% or in a directory in which you would like to save your movies.

% The way I have it setup is that I keep this file in a folder called MyMovies/
% and from there, I tell the loop to run in the directory where my data is located
% and then send the completed movie back to MyMovies/

%All the code that the user is required to keep is documented. All other
%code can be removed as required
%=============================================================

%SHARCNET Paths
%============================================
% save_path = '/work/a2grace/MyMovies/';
% data_path = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp0825/h005/';
% diag_path = '/work/a2grace/hov/';
%============================================

%Local Paths
%============================================
save_path = strcat('/Volumes/','Ext. Drive','/Movies/');
data_path = strcat('/Volumes/','Ext. Drive','/seiche2D/2048x1024/Amp0825/h005/');
diag_path = strcat('/Volumes/','Ext. Drive','/seiche2D/Notes/');
%============================================

%Set some parameters for labels and font sizes and such
mylabelfontsize = 15;
mytickfontsize = 12;
mylabelxpos = 0.02;
mylabelzpos = 0.05;



cd(diag_path);
load control.mat
cd(data_path);


% Create a new VideoWriter object (an empty video file). Use whatever format you want,
% but in my experience MP4 (with H.264 codec) is by far the best.  
hvid = VideoWriter('./Mixing');
h = get(hvid,'Filename');
% Full quality, because why not?
set(hvid,'Quality',100);

% Set the frame rate
set(hvid,'FrameRate',5);

% Open the object for writing
open(hvid);

% Desired frame resolution (see fig2frame). The video will automatically adopt 
%   the resolution of the first frame (see HELP VIDEOWRITER).
% You could instead set the Width property of the video object.
framepar.resolution = [1024,768];

% Create a new figure
hfig = figure();
set(hfig, 'visible', 'off')



gdpar = spins_gridparams('vector',false); split_gdpar; par2var(params);
numouts = final_time/plot_interval;


varsum= varsum'/Nz;
mymaxvar = max(max(varsum));
myminvar = min(min(varsum));


rhosum= rhosum';
mymaxwidth = max(max(rhosum));
myminwidth = min(min(rhosum));
mytitle = 'Pycnocline Width';

numticks = 3;

xs = linspace(0,Lx,Nx);
ts = linspace(0,final_time,numouts+1);

[xx,tt] = meshgrid(xs,ts);

x = xgrid_reader();
z = zgrid_reader();
for ii=0:numouts %Each iteration of this loop is supposed to be one sigle frame
    %of your movie. I like to test out how long each fame takes to render
    %before I go ahead with the whole movie; tic and toc accomplish this
    tic
    disp(['Processing frame ' num2str(ii) '...']) %Tells the user what frame
    %is currently being rendered
    figure(hfig)
    
    %===============================================================
    %The following is where you will put the code to actually make the
    %figures. This is dependant on what you are actually making into a
    %movie
    %I recommend keeping the lines that set font sizes and widths and such
    %as required
    %===============================================================
    rho = spins_reader_new('rho',ii);


    ax1 = subplot(2,2,1:2);
	pcolor(x,z,rho), shading flat
	set(gca,'fontw','b',...
     	'XLim',params.xlim,'YLim',params.zlim,...
     	'XTick',[0 .25 .5 .75 1],'YTick',[.05 .1 .15 .20 .25]);
    caxis([-.01 .01]), colorbar, colormap(flipud(temperature)) 

    ax2 = subplot(2,2,3);
    pcolor(xx,tt,varsum), shading flat
    hline1 = refline(0, tt(ii+1,1));
    set(hline1,'Color','w');
    title('Variability');
    set(gca,'fontsize',mytickfontsize,'fontw','b',...
       'XLim',[0 Lx],'YLim',[0 final_time],...
       'XTick',[0 Lx/2 Lx],'YTick',-0:final_time/numticks:final_time)
    caxis([myminvar mymaxvar]), colorbar,colormap(temperature) 


    ax3 = subplot(2,2,4);
    pcolor(xx,tt,rhosum), shading flat
    hline2 = refline(0, tt(ii+1,1));
    set(hline2,'Color','w');
    title('Pycnocline Width');
    set(gca,'fontsize',mytickfontsize,'fontw','b',...
       'XLim',[0 Lx],'YLim',[0 final_time],...
       'XTick',[0 Lx/2 Lx],'YTick',-0:final_time/numticks:final_time)
    caxis([myminwidth mymaxwidth]), colorbar,colormap(temperature) 

    set(gcf,'NextPlot','add');
    axes;
    set(gca,'Visible','off');
    xlab = xlabel({'x (m)'},'fontsize',mylabelfontsize,'fontw','b');
    zlab = ylabel({'z (m)'},'fontsize',mylabelfontsize,'fontw','b');
    set(xlab,'Visible','on','Position',[.5 -.06 0]);
    set(zlab,'Visible','on','Position',[-.09 .45 0]);


    % Convert the figure to a video frame.
    % The built-in function for this is GETFRAME, which has a variety of annoying features.
    % fig2frame is a drop-in replacement for getframe that avoids most (all?) the annoyance.
    
    F = fig2frame(hfig,framepar);
    
    % Add the frame to the video object
    writeVideo(hvid,F);
   toc 
end

% Close the figure
close(hfig);

% Close the video object. This is important! The file may not play properly if you don't close it.
close(hvid);

%This last line moves the now completed avi file to wherever save_path is.
movefile(h,save_path);
