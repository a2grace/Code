clear all
close all

gdpar = spins_gridparams('vector',false); split_gdpar;

myeps = 0;
rhomax = params.delta_rho/2*(1+myeps);
rhomin = -rhomax;
dx = params.dx;
dy = params.dy;
dz = params.dz;
plot_interval = params.plot_interval;
final_time = params.final_time;
start = 10;
finish = 10;
volume = zeros(1,finish);
time = 0:plot_interval:finish;

Nx = params.Nx;
Ny = params.Ny;
Nz = params.Nz;
for ii = start:finish
    
    for jj = 1:Ny
        volumeslice = 0;
        rho = rho_reader(ii,:,jj,:);
        rhoind = (rho<rhomin)|(rho)>rhomax);
        numboxes = sum(rhoind(:));
        volumeslice = volumeslice + numboxes * dx * dz;
    end 
    volume(ii) = volumeslice;
    
end 
plot(t,volume), grid on