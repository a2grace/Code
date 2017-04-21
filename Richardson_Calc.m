clear 
close all
clc 

gdpar = spins_gridparams('vector',false); split_gdpar;


g = params.g;
rho0 = params.rho_0; %background density of water

x = xgrid_reader();
z = zgrid_reader();

Lx = params.Lx;
Ly = params.Ly;
Lz = params.Lz;

Nx = params.Nx;
Ny = params.Ny;
Nz = params.Nz;

plot_interval = params.plot_interval;
final_time = params.final_time;

imax = final_time/plot_interval;
figure(1)

myvec = 0:1:imax;
maxN2 = zeros(imax+1,1);
plot_step = 5;
for ii = 0:plot_step:imax
    u = spins_reader_new('u',ii);
    w = spins_reader_new('w',ii);
    rho = spins_reader_new('rho',(ii));
    
    N2 = -g*even_y_deriv(rho,[],Lz,[]);
    uz = even_y_deriv(u,[],Lz,[]);
    uz2 = uz.^2;
    maxN2(ii+1) = max(max(N2));
    Ri = N2./uz2;
    
    Rifilt = Ri.*(N2>10) + 100*Ri.*(N2<10);
    
    subplot(2,1,1)
    imagesc(flipud(rho')), shading flat
    colormap temperature
    caxis([-.01 .01])
    colorbar
    subplot(2,1,2)
    imagesc(flipud(Ri')), shading interp
    colormap temperature
    caxis([0 .25])
    colorbar

 drawnow
end
figure(2)
plot(myvec(1:45:imax+1),maxN2(1:45:imax+1))



