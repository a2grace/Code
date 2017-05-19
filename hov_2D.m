
clear
close all

save_path = '/work/a2grace/Data';

field1 = 'S5_spacetime'; value1 = '/scratch/kglamb/a2grace/S5';
field2 = 'M5_spacetime'; value2 = '/scratch/kglamb/a2grace/M5';
field3 = 'L5_spacetime'; value3 = '/scratch/kglamb/a2grace/L5';
field4 = 'Sn2_spacetime'; value4 = '/scratch/kglamb/a2grace/Sn2';
field5 = 'Sn4_spacetime'; value5 = '/scratch/kglamb/a2grace/Sn4';
field6 = 'Sn5_spacetime'; value6 = '/scratch/kglamb/a2grace/Sn5';
field7 = 'L10_spacetime'; value7 = '/scratch/kglamb/a2grace/L10';
field8 = 'L50_spacetime'; value8 = '/scratch/kglamb/a2grace/L50';


myfields = {field1 field2 field3 field4 field5 field6 field7 field8};

mypaths = {value1 value2 value3 value4 value5 value6 value7 value8};




for jj = 1:length(myfields)
    cd((mypaths{jj}))
    disp(['Current directory: ' (mypaths{jj})]) 
    filename = (myfields{jj});
    myeps = 0;          
    gdpar = spins_gridparams('vector',false); split_gdpar;
    par2var(params);
    numouts = final_time/plot_interval; 
    
    %Event Fields
    rho_num = zeros(Nx,numouts+1);
    mix_num = rho_num;
    vertical_shear_num = rho_num;
    variability_num = rho_num;   
    
    %Magnitude Fields
    KE_mag = rho_num; 
    mixing_mag = rho_num;
    vertical_shear_mag = rho_num;
    variability_mag = rho_num;
    
    
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
        rho_num(:,ii+1) = numboxes; %vertically integrated pycnocline width
        
        %%%Kinetic energy%%%
        dummy = spins_reader('u',ii);
        KE_mag(:,ii+1) = sum(dummy.^2,2);
        dummy = spins_reader('w',ii);
        KE_mag(:,ii+1) = KE_mag(:,ii+1) + sum(dummy.^2,2);%vertically integrated kinetic energy
        
        %%%Mixing%%%
        rho = spins_reader('rho',ii);
        rhox = even_x_deriv(rho,Lx,[],[]);
        rhoz = even_y_deriv(rho,[],Lz,[]);
        rhoxx = odd_x_deriv(rhox,Lx,[],[]);
        rhozz = odd_y_deriv(rhoz,[],Lz,[]);
        dummy = -kappa_rho*(rhoxx + rhozz).^2;
        
            %%%Magnitude
            mixing_mag(:,ii+1) = sum(dummy,2);

            %%%Events
            mixind = (dummy<-kappa_rho*(delta_rho)^2/(2*h_halfwidth)^4); 
            mix_num(:,ii+1) = sum(mixind,2);

        %%%Variability--Events%%%
        dummy = rhox.^2 + rhoz.^2;
        
            %%%Magnitudes
            variability_mag(:,ii+1) = sum(dummy,2);
            %%%Events
            variability_num(:,ii+1) = ...
                sum(dummy>0.9*(delta_rho/(2*h_halfwidth))^2,2);

        %%%Vertical Shear--Events%%%
        coeff = 4*eta_0/(period*Lz*2*h_halfwidth);
        dummy = spins_reader('u',ii);
        dummy = even_y_deriv(dummy,[],Lz,[]);
        
            %%%Magnitudes
            vertical_shear_mag(:,ii+1) = sum(dummy.^2,2); 
            %%%Events
            vertical_shear_num(:,ii+1) = sum(dummy.^2>coeff^2,2); 


    end
    KE_mag = 0.5*rho_0*KE_mag;
    
    hov = struct('rho_num',rho_num,...
        'KE_mag',KE_mag,...
        'mix_num',mix_num,...
        'mix_mag',mixing_mag,...
        'variability_num',variability_num,...
        'variability_mag',variability_mag,...
        'vertical_shear_num',vertical_shear_num,...
        'vertical_shear_mag',vertical_shear_mag);

    newdata = fieldnames(params);
        for index = 1:length(newdata)
            hov.(newdata{index}) = params.(newdata{index});
        end
save(filename,'-struct','hov')

filename = strcat(filename,'.mat');
movefile(filename,save_path) 
    
end

