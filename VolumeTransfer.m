%clear all
%2D Volume Transfer calculator
%This is the real version. Last modified on February 6th, 2017
%close all
clear
close all
savepath = strcat('/Volumes/','Ext. Drive','/seiche2D/Notes/')
field1 = 'L5'; value1 = strcat('/Volumes/','Ext. Drive','/seiche2D/2048x1024/Amp0825/h005/');
field2 = 'M5'; value2 = strcat('/Volumes/','Ext. Drive','/seiche2D/2048x1024/Amp065/h005/');
field3 = 'S5'; value3 = strcat('/Volumes/','Ext. Drive','/seiche2D/2048x1024/Amp05/h005/');

field4 = 'L25'; value4 = strcat('/Volumes/','Ext. Drive','/seiche2D/2048x1024/Amp0825/h025/');
field5 = 'M25'; value5 = strcat('/Volumes/','Ext. Drive','/seiche2D/2048x1024/Amp065/h025/');
field6 = 'S25'; value6 = strcat('/Volumes/','Ext. Drive','/seiche2D/2048x1024/Amp05/h025/');

s = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6);
fields = fieldnames(s);
structv = struct;
structdv = struct;
for jj = 1:numel(fields)
    cd(s.(fields{jj}))
    disp(['Current directory: ' s.(fields{jj})]) 
    
    gdpar = spins_gridparams('vector',false); split_gdpar;
    myeps = 0;
    rholow = -0.5*params.delta_rho*tanh(1)*(1+myeps);
    rhohigh = -rholow;
    
    x = xgrid_reader();
    z = zgrid_reader();
    
    conts = [rholow rhohigh];
    plot_interval = params.plot_interval;
    final_time = params.final_time;
    imax = final_time/plot_interval;
    kappa = params.kappa_rho;
    Lx = params.Lx;
    Ly = params.Ly;
    Lz = params.Lz;
    dx = params.dx;
    dz = params.dz;
    rhoinitial = rho_reader(0);
    rho0 = (rhoinitial<rhohigh)&(rhoinitial>rholow);
    numboxesinitial = sum(rho0(:));
    v = zeros(1,imax+1);
    
    for ii = 0:imax
        disp(['Output: ' num2str(ii)])
        rho = rho_reader(ii);
        rhoind = (rho<rhohigh)&(rho>rholow);
        numboxes = sum(rhoind(:));
        %v(ii+1) = numboxes/numboxesinitial;
        v(ii+1) = numboxes - numboxesinitial;
    end
    
    h = plot_interval;
    D = circshift(-eye(imax+1),1);
    D = D-D';
    
    dv = (1/(2*h))*(D*v')';
    dv(1) = dv(2);
    dv(end) = dv(end-1);
    
    structv.(fields{jj}) = v;
    structv.t1 = linspace(0,90,451);
    structv.t2 = linspace(0,180,901);
    
    structdv.(fields{jj}) = dv;
    structdv.t1 = linspace(0,90,451);
    structdv.t2 = linspace(0,180,901);
    
end
cd(savepath)
save('structv2.mat','-struct','structv')
save('structdv2.mat','-struct','structdv')
