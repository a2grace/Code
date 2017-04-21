gdpar = spins_gridparams('vector',false); split_gdpar;

myeps = 0;
x = xgrid_reader();
z = zgrid_reader();
Nx = params.Nx;
Nz = params.Nz;

filtx = 1000;
filtz = 500;

rholow = -0.5*params.delta_rho*tanh(1)*(1+myeps);
rhohigh = -rholow;
conts = [rhohigh rholow];

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


plot_start = 0;
plot_spacing = 1;
plot_end = imax;
v = zeros(1,imax+1);
vfilter = zeros(1,imax+1);

for ii = 0:plot_spacing:plot_end
    
    rho = rho_reader(ii);
    rho2 = [rho fliplr(rho)];
    rho2 = [rho2;flipud(rho2)];
    
    rhof = fft2(rho2);
    rhof(Nx/2 - filtx:Nx/2 + filtx,:)=0;
    rhof(:,Nz/2 - filtz:Nz/2 + filtz)=0;
    rhofilter = real(ifft2(rhof));
    rhofilter = rhofilter(1:Nx,1:Nz);
    
    rhoind = (rho<rhohigh)&(rho>rholow);
    numboxes = sum(rhoind(:));
    
    rhofilterind = (rhofilter<rhohigh)&(rhofilter>rholow);
    numboxesfilter = sum(rhofilterind(:));
   
    v(ii+1) = numboxes/(Nx*Nz);
    vfilter(ii+1) = numboxesfilter/(Nx*Nz);

    drawnow
   
    ii
    
end
t = (1:imax+1).*plot_interval;
t = t(1:plot_spacing:plot_end);
v = v(1:plot_spacing:plot_end);
vfilter = vfilter(1:plot_spacing:plot_end);
error = abs((v-v(1)) - (vfilter-vfilter(1)));
figure(2), title(pwd)
subplot(2,1,1)
plot(t,v-v(1),t,vfilter-vfilter(1)),...
    grid on, xlabel('time'), ylabel('Area subracting initial area'),...
    legend('Unfiltered','Filtered','Location','northwest')
subplot(2,1,2)
plot(t,error), grid on, xlabel('time'), ylabel('% error')

%%%%%%%% FIND A WAY TO MEASURE OVERTURNING EVENTS. HOVMOELLER PLOTS OF THE
%%%%%%%% CONTOURS??????? %%%%%%%%%%%%%




