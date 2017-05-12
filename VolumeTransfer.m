%clear all
%2D Volume Transfer calculator
%This is the real version. Last modified on May 8th, 2017
%close all
clear
close all

%==============
%Cases
%==============

L5 = '/scratch/kglamb/a2grace/L5';
M5 = '/scratch/kglamb/a2grace/M5';
S5 = '/scratch/kglamb/a2grace/S5';

L25 = '/scratch/kglamb/a2grace/L25';
M25 = '/scratch/kglamb/a2grace/M25';
S25 = '/scratch/kglamb/a2grace/S25';

L10 = '/scratch/kglamb/a2grace/L10';
L50 = '/scratch/kglamb/a2grace/L50';

Ln2 = '/scratch/kglamb/a2grace/Ln2';
Ln4 = '/scratch/kglamb/a2grace/Ln4';
Ln5 = '/scratch/kglamb/a2grace/Ln5';

Sn2 = '/scratch/kglamb/a2grace/Sn2';
Sn4 = '/scratch/kglamb/a2grace/Sn4';
Sn5 = '/scratch/kglamb/a2grace/Sn5';

%L5 = strcat('/Volumes/','Ext. Drive','/seiche2D/L5');

savepath = '/work/a2grace/Data';

mypaths = {L5 M5 S5 L25 M25 S25 L10 L50 ...
    Ln2 Sn4 Ln5 Sn2 Sn4 Sn5};
mycases = {'L5' 'M5' 'S5' 'L25' 'M25' 'S25' 'L10' 'L50' ...
    'Ln2' 'Ln4' 'Ln5' 'Sn2' 'Sn4' 'Sn5'};

for jj = 1:length(mypaths)
    cd((mypaths{jj}))
    disp(['Current directory: ' (mypaths{jj})]) 
    
    gdpar = spins_gridparams('vector',false); split_gdpar; par2var(params);
    myeps = 0;
    rholow = -0.5*delta_rho*tanh(1)*(1+myeps);
    rhohigh = -rholow;
    
    x = xgrid_reader();
    z = zgrid_reader();
    
    imax = final_time/plot_interval;
    rhoinitial = spins_reader_new('rho',0);
    rhoinitial = (rhoinitial<rhohigh)&(rhoinitial>rholow);
    numboxesinitial = sum(rhoinitial(:));
    area = zeros(1,imax+1);
    
    for ii = 0:imax
        disp(['Output: ' num2str(ii)])
        rho = spins_reader_new('rho',ii);
        rhoind = (rho<rhohigh)&(rho>rholow);
        numboxes = sum(rhoind(:));
        area(ii+1) = numboxes - numboxesinitial;
    end
    
    h = plot_interval;
    D = circshift(-eye(imax+1),1);
    D = D-D';
    
    d_area = (1/(2*h))*(D*area')';
    d_area(1) = d_area(2);
    d_area(end) = d_area(end-1);
    
    
    myarea.(mycases{jj}) = area;
    myarea_rate.(mycases{jj}) = d_area;    
end
myarea.t1 = linspace(0,90,451);
myarea.t2 = linspace(0,180,901);
myarea_rate.t1 = linspace(0,90,451);
myarea_rate.t2 = linspace(0,180,901);

cd(savepath)
save('myarea.mat','-struct','myarea')
save('myarea_rate.mat','-struct','myarea_rate')
