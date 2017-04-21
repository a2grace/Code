%%%%%
%mixing.m produces Hovmoller plots for stirring and
%mixing events. It does not output the numerical values of each mechanism,
%but only the number of events

%%%%%%%%%
%updated February 12,2017, located on ext drive
%derivative functions changed to compute appropriate derivatives
%%%%%%

%%%%%%%%%%%
% February 13th 2017 Found mixing and stirring scales. Made some pictures
%%%%%%%%%%%

%%%%%%%%%%%
% February 14th, 2017 Mixing and stirring scales vary by several orders of
% magnitude. This makes sense because as the flow progrsses in time, the
% density gradients become very sharp as the fluid overturns. See for
% instance ../Amp0825/h025/ at about 12 seconds
%%%%%%%%%%%

%%%%%%%%%%%%
% March 16th, 2017, Recalculated mixing and strring scales. Re-wrote the 
% code so it will go to each directory and do all the work without me
% having to change directories

%%%%%%%% LAST UPLOAD TO SHARCNET: MARCH 16th 2017 %%%%%%%%%%%%%%

clear
close all
savepath = '/work/a2grace';
field1 = 'L5'; value1 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp0825/h005/';
field2 = 'M5'; value2 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp065/h005/';
field3 = 'S5'; value3 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp05/h005/';

field4 = 'L25'; value4 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp0825/h025/';
field5 = 'M25'; value5 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp065/h025/';
field6 = 'S25'; value6 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp05/h025/';

s = struct(field1,value1,field2,value2,field3,value3,...
    field4,value4,field5,value5,field6,value6);

fields = fieldnames(s);
structmixing = struct;
structstirring = struct;


%%
for jj = 1:numel(fields)
    cd(s.(fields{jj}))
    disp(['Current directory: ' s.(fields{jj})]) 
    gdpar = spins_gridparams('vector',false); split_gdpar;

    x = xgrid_reader();
    z = zgrid_reader();

    plot_interval = params.plot_interval;
    final_time = params.final_time;
    imax = final_time/plot_interval;
    kappa = params.kappa_rho;
    delta = 2*params.h_halfwidth;
    eta_0 = params.eta_0;
    delta_rho = params.delta_rho;
    g = params.g;
    Lx = params.Lx;
    Ly = params.Ly;
    Lz = params.Lz;
    Nx = params.Nx;
    Ny = params.Ny;
    Nz = params.Nz;
    dx = params.dx;
    dz = params.dz;
    mixchar = zeros(Nx,imax+1);
    stirchar = zeros(Nx,imax+1);

    mixsum = zeros(Nx,imax+1);
    stirsum = zeros(Nx,imax+1);

    mixscale = kappa*delta_rho^2/delta^4;
    mixscale = 10^(floor(log10(mixscale)));

    N = g*delta_rho/Lz;
    sigma = N/Lx * 1/(sqrt(1/Lx^2 + 1/Lz^2));
    stirscale = eta_0*delta_rho^2/delta^3*sigma/2*pi;
    stirscale = 10^(floor(log10(stirscale)));
    plot_step = 1;
    for ii = 0:plot_step:imax
        rho = rho_reader(ii);
        rhox = even_x_deriv(rho,Lx,[],[]);
        rhoz = even_y_deriv(rho,[],Lz,[]);
        rhoxx = odd_x_deriv(rhox,Lx,[],[]);
        rhozz = odd_y_deriv(rhoz,[],Lz,[]);

        laplacian = rhoxx + rhozz;
        u = u_reader(ii);
        w = w_reader(ii);

        mix = -kappa * laplacian.^2;
        stir = (u.*rhox + w.*rhoz).*laplacian;

        % Integrate in the z direction
        for kk = 1:Nx
            mixsum(kk,ii+1) = sqrt(sum(mix(kk,:).^2))/Nz;
            mixind = (mix(kk,:)<-mixscale);
            numboxes = sum(mixind(:));
            mixchar(kk,ii+1) = numboxes;

            stirsum(kk,ii+1) = sqrt(sum(stir(kk,:).^2))/Nz;
            stirind = abs((stir(kk,:)) > mixscale);
            numboxes = sum(stirind(:));
            stirchar(kk,ii+1) = numboxes;
        end

    end 
    m = struct('Strength',mixsum,'Number',mixchar);
    st = struct('Strength',stirsum,'Number',stirchar);
    structmixing.(fields{jj}) = m;
    structstirring.(fields{jj}) = st;
    
    disp(['Successfully exited ' s.(fields{jj})])
end
structmixing.t1 = linspace(0,90,451);
structmixing.t2 = linspace(0,180,901);
structstirring.t1 = linspace(0,90,451);
structstirring.t2 = linspace(0,180,901);
cd(savepath)
save('structmixing.mat','-struct','structmixing')
save('structstirring.mat','-struct','structstirring')
