close all
clear all

%Plot potentials

gdpar = spins_gridparams('vector',false); split_gdpar; par2var(params);
numouts = final_time/plot_interval;

z = zgrid_reader();

pe = @(rho,z,dx,dz) 0.5*g*dx*rho_0*(1+rho).*((z+dz/2).^2 - (z-dz/2).^2);
t = linspace(0,final_time,numouts+1);
potential = zeros(1,numouts+1);
background_potential = potential;
for ii = 0:numouts
    tic
    dummy = spins_reader_new('rho',ii);
    potential(ii+1) = sum(sum(pe(dummy,z,dx,dz)));
    
    dummy = reshape(sort(dummy(:),'descend'), [Nx Nz]);
    background_potential(ii+1) = sum(sum(pe(dummy,z,dx,dz)));
    toc
end

available_potential = potential - background_potential;