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

field1 = 'control_S5'; value1 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp05/h005';
field2 = 'control_M5'; value2 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/Amp065/h005'
%field2 = 'n2'; value2 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/perturb/himode/n2';
%field3 = 'n4'; value3 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/perturb/himode/n4';
%field4 = 'n5'; value4 = '/scratch/kglamb/a2grace/seichefiles/seiche2D/2048x1024/FilterD/perturb/himode/n5';



myfields = {field1 field2};

mypaths = {value1 value2};




for jj = 1:length(myfields)
    cd((mypaths{jj}))
    disp(['Current directory: ' (mypaths{jj})]) 
    filename = (myfields{jj});
    myeps = 0;          
    gdpar = spins_gridparams('vector',false); split_gdpar;
    par2var(params);
    numouts = final_time/plot_interval; 
    rhosum = zeros(Nx,numouts+1);
    KEsum = rhosum; 
    mixsum = rhosum;
    uz = rhosum;
    varsum = rhosum;    

    rholow = -0.5*delta_rho*tanh(1)*(1+myeps);
    rhohigh = -rholow;
    period = 20;
    conts = [rholow rhohigh];
    numouts = final_time/plot_interval;


    for ii = 0:numouts
        disp(['Output: ' num2str(ii)])
        
        %%%pycnocline widening%%%
        dummy = spins_reader('rho',ii);
        rhoind = (dummy<rhohigh)&(dummy>rholow);
        numboxes = sum(rhoind,2);
        rhosum(:,ii+1) = numboxes; %vertically integrated pycnocline width
        
        %%%Kinetic energy%%%
        dummy = spins_reader('u',ii);
        KEsum(:,ii+1) = sum(dummy.^2,2);
        dummy = spins_reader('w',ii);
        KEsum(:,ii+1) = KEsum(:,ii+1) + sum(dummy.^2,2);%vertically integrated kinetic energy
        
        %%%Mixing%%%
        rho = spins_reader('rho',ii);
        rhox = even_x_deriv(rho,Lx,[],[]);
        rhoz = even_y_deriv(rho,[],Lz,[]);
        rhoxx = odd_x_deriv(rhox,Lx,[],[]);
        rhozz = odd_y_deriv(rhoz,[],Lz,[]);
	dummy = -kappa_rho*(rhoxx + rhozz).^2;
	mixind = (dummy<-kappa_rho*(delta_rho)^2/(2*h_halfwidth)^4); 
        mixsum(:,ii+1) = sum(mixind,2);
        
        %%%Variability%%%i
        dummy = rhox.^2 + rhoz.^2;
        varsum(:,ii+1) = sum(dummy>0.9*(delta_rho/(2*h_halfwidth))^2,2);%find the order of magnitude of the variability

	%%%Vertical Shear%%%
	coeff = 4*eta_0/(period*Lz*2*h_halfwidth);
	dummy = spins_reader('u',ii);
	dummy = even_y_deriv(dummy,[],Lz,[]);
	uz(:,ii+1) = sum(abs(dummy)>coeff,2); %4*eta_0/(HT2*h_halfwidth)
    end
    rhosum = rhosum/Nz;
    KEsum = 0.5*rho_0*KEsum;
    hov = struct('rhosum',rhosum,'KEsum',KEsum,'mixsum',mixsum,...
        'varsum',varsum,'uz',uz);

    newdata = fieldnames(params);
        for index = 1:length(newdata)
            hov.(newdata{index}) = params.(newdata{index});
        end
save(filename,'-struct','hov')

filename = strcat(filename,'.mat');
movefile(filename,save_path) 
    
end

