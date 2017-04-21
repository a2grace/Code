%%%%%%%%%%% MOST RECENT UPLOAD TO SHARCNET: APRIL 6th, 2017
%%%%%%%%%%% %%%%%%%%%%%%%%%
clear
close all

save_path = '/work/a2grace/hov';


% field1 = 'L5'; value1 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp0825/h005';
% field2 = 'M5'; value2 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp065/h005';
% field3 = 'S5'; value3 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp05/h005';
% 
% field4 = 'L25'; value4 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp0825/h025';
% field5 = 'M25'; value5 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp065/h025';
% field6 = 'S25'; value6 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp05/h025';

field1 = 'control'; %
%value1 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp0825/h005';
value1 = 'e:/seiche2D/2048x1024/Amp0825/h025';
%field2 = 'n2'; value2 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/perturb/n2';
%field3 = 'n4'; value3 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/perturb/n4';
%field4 = 'n5'; value4 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/perturb/n5';


myeps = 0;
myfields = {field1};% field2 field3 field4};
mypaths = {value1};% value2 value3 value4};



for jj = 1:length(myfields)
    cd((mypaths{jj}))
    disp(['Current directory: ' (mypaths{jj})]) 
    filename = (myfields{jj});
    
    gdpar = spins_gridparams('vector',false); split_gdpar;
    par2var(params);
    
    rholow = -0.5*delta_rho*tanh(1)*(1+myeps);
    rhohigh = -rholow;
    
    conts = [rholow rhohigh];
    numouts = final_time/plot_interval;
    
    myeps = 0;
    rhosum = zeros(Nx,numouts+1);
    KEsum = zeros(Nx,numouts+1);
    mixsum = zeros(Nx,numouts+1);

    for ii = 0:numouts
        disp(['Output: ' num2str(ii)])
        
        %%%pycnocline widening%%%
        dummy = spins_reader('rho',ii);
        rhoind = (dummy<rhohigh)&(dummy>rholow);
        numboxes = sum(rhoind,2);
        rhosum(:,ii+1) = numboxes;
        disp('stuff 1')
        %%%Kinetic energy%%%
        dummy = spins_reader('u',ii);
        KEsum(:,ii+1) = sum(dummy.^2,2);
        dummy = spins_reader('w',ii);
        KEsum(:,ii+1) = KEsum(:,ii+1) + sum(dummy.^2,2);
        disp('stuff 2')
        %%%Mixing%%%
        rho = spins_reader('rho',ii);
        rhox = even_x_deriv(rho,Lx,[],[]);
        rhoz = even_y_deriv(rho,[],Lz,[]);
        rhoxx = odd_x_deriv(rhox,Lx,[],[]);
        rhozz = odd_y_deriv(rhoz,[],Lz,[]); 
        mixsum(:,ii+1) = sum((rhoxx + rhozz).^2,2);
        disp('stuff 3')
        %%%Variability%%%
        varsum = sum(rhox.^2 + rhoz.^2,2);
        
    end
    rhosum = rhosum/Nz;
    KEsum = 0.5*rho_0*KEsum;
    mixsum = -kappa_rho*mixsum;
    varsum = 0.5*varsum;
    hov = struct('rhosum',rhosum,'KEsum',KEsum,'mixsum',mixsum,...
        'varsum',varsum);

    newdata = fieldnames(params);
        for index = 1:length(newdata)
            hov.(newdata{index}) = params.(newdata{index});
        end
save(filename,'-struct','hov')

filename = strcat(filename,'.mat');
movefile(filename,save_path) 
    
end

