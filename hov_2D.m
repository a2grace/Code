%%%%%%%%%% MOST RECENT UPLOAD TO SHARCNET: APRIL 24th, 2017
%%%%%%%%%%% %%%%%%%%%%%%%%%
clear
close all

save_path = '/work/a2grace/Data';

field1 = 'S5_spacetime'; value1 = '/scratch/kglamb/a2grace/S5';
field2 = 'M5_spacetime'; value2 = '/scratch/kglamb/a2grace/M5';
field3 = 'L5_spacetime'; value3 = '/scratch/kglamb/a2grace/L5';
field4 = 'Sn2_spacetime'; value4 = '/scratch/kglamb/a2grace/Sn2';
field5 = 'Sn4_spacetime'; value5 = '/scratch/kglamb/a2grace/Sn4';
field6 = 'Sn5_spacetime'; value6 = '/scratch/kglamb/a2grace/Sn5';



myfields = {field1 field2 field3 field4 field5 field6};

mypaths = {value1 value2 value3 value4 value5 value6};




for jj = 1:length(myfields)
    cd((mypaths{jj}))
    disp(['Current directory: ' (mypaths{jj})]) 
    filename = (myfields{jj});
    myeps = 0;          
    gdpar = spins_gridparams('vector',false); split_gdpar;
    par2var(params);
    numouts = final_time/plot_interval; 
    
    %Event Fields
    rhosum = zeros(Nx,numouts+1);
    KEsum = rhosum; 
    mixsum = rhosum;
    uz = rhosum;
    varsum = rhosum;   
    
    %Magnitude Fields
    mixing = rhosum;
    vertical_shear = rhosum;
    variability = rhosum;
    
    
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
        
        %%%Variability--Events%%%
        dummy = rhox.^2 + rhoz.^2;
        varsum(:,ii+1) = sum(dummy>0.9*(delta_rho/(2*h_halfwidth))^2,2);%find the order of magnitude of the variability

        %%%Vertical Shear--Events%%%
        coeff = 4*eta_0/(period*Lz*2*h_halfwidth);
        dummy = spins_reader('u',ii);
        dummy = even_y_deriv(dummy,[],Lz,[]);
        uz(:,ii+1) = sum(abs(dummy)>coeff,2); %4*eta_0/(HT2*h_halfwidth)
        
        %%%Variability--Magnitude%%%
        dummy = rhox.^2 + rhoz.^2;
        variability(:,ii+1) = sum(dummy,2);

        %%%Vertical Shear--Magnitude%%%
        dummy = spins_reader('u',ii);
        dummy = even_y_deriv(dummy,[],Lz,[]);
        vertical_shear(:,ii+1) = sum(abs(dummy),2); %4*eta_0/(HT2*h_halfwidth)
    end
    KEsum = 0.5*rho_0*KEsum;
    
    hov = struct('rhosum',rhosum,'KEsum',KEsum,'mixsum',mixsum,...
        'varsum',varsum,'uz',uz,'variability',variability,...
        'vertical_shear',vertical_shear);

    newdata = fieldnames(params);
        for index = 1:length(newdata)
            hov.(newdata{index}) = params.(newdata{index});
        end
save(filename,'-struct','hov')

filename = strcat(filename,'.mat');
movefile(filename,save_path) 
    
end

