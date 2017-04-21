clear
close all

datapath = '/scratch/kglamb/a2grace/seichefiles/seiche3D/h025_3D/';
savepath = '/work/a2grace/';
filename = 'hov_3D'
%cd(datapath)
gdpar = spins_gridparams('vector',false); split_gdpar;
par2var(params);

numouts = final_time/plot_interval;

myeps = 0;
rholow = -0.5*delta_rho*tanh(1)*(1+myeps);
rhohigh = -rholow;
myconts = [rhohigh rholow];

rhosum = zeros(numouts+1,Nx,Ny);
KEsum = zeros(numouts+1,Nx,Ny);


for ii = 0:0 %ouputs
    tic
    rho = spins_reader('rho',ii);
    toc
    %u = spins_reader('u',ii);
    %v = spins_reader('v',ii);
    %w = spins_Reader('w',ii);
    
    %KEsum(ii+1,:,:) = KEsum(ii+1,:,:) + squeeze(sum(u,2)) + ...
    %    squeeze(sum(v,2)) + squeeze(sum(w,2));
    tic
    for jj = 1:1 %Number of x points
        for kk = 1:1 %Number of y points

        rhoind = (rho(jj,:,kk)<rhohigh)&(rho(jj,:,kk)>rholow);
        numboxes = sum(rhoind(:));  
        
        rhosum(ii+1,jj,kk) = numboxes;
        rhosum(ii+1,jj,kk) = numboxes./rhosum(1,jj,kk);
        
        %KEsum(ii+1,jj,kk) = 0.5*rho_0*sum(u(jj,:,kk).^2 + ...
         %   v(jj,:,kk).^2 + ...
          %  w(jj,:,kk).^2);
        
        end
    end
    toc
end 
%hov = struct('rho',rhosum,'ke',KEsum);
%newdata = fieldnames(params);
%    for index = 1:length(newdata)
%        hov.(newdata{index}) = params.(newdata{index});
%    end

%save(filename,'-struct','hov')

%movefile(filename,savepath)