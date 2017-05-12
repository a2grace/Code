
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
%SHARCNET Paths
%============================================
 save_path = '/work/a2grace/MyMovies/';
 data_path = '/scratch/kglamb/a2grace/L5_salt/';
%============================================
% Create a new VideoWriter object (an empty video file). Use whatever format you want,
% but in my experience MP4 (with H.264 codec) is by far the best. Please stop using AVI.
cd(data_path);
hvid = VideoWriter('./L5_salt');
h = get(hvid,'Filename');
% Full quality, because why not?
set(hvid,'Quality',100);

% Set the frame rate
set(hvid,'FrameRate',10);

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
for ii=0:numouts
    disp(['Processing frame ' num2str(ii) '...'])
    figure(hfig)
    
    rho = spins_reader('rho',ii);
    imagesc(flipud(rho')), shading interp, axis image
    colormap(flipud(temperature)), caxis([-.01 .01]);
    %set(gcf,'NextPlot','replacechildren','Visible','off')
    % Convert the figure to a video frame.
    % The built-in function for this is GETFRAME, which has a variety of annoying features.
    % fig2frame is a drop-in replacement for getframe that avoids most (all?) the annoyance.
    
    F = fig2frame(hfig,framepar);
    
    % Add the frame to the video object
    writeVideo(hvid,F);
end

% Close the figure
close(hfig);

% Close the video object. This is important! The file may not play properly if you don't close it.
close(hvid);

movefile(h,save_path);
