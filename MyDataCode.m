clear
close all
savepath = '/work/a2grace/Data/';
datapath = '/scratch/kglamb/a2grace/L10/';
filename = 'L10_tight.mat';
cd(datapath)
    %Read in parameters from spins.conf
    %This requires a buch of David's functions
    %It's just easiest to import the SPINSmatlab folder from Boogaloo
    %All the functions are there
    gdpar = spins_gridparams('vector',false); split_gdpar;
    par2var(params);
    
    numchains = 8; %The number of chains across the domain is actually numchains-1
    numdata = 16; %the number of sensors(?) on each chain +1
    chainlocations = Lx*[.1 .4 .45 .5 .55 .6 .9];
    %chainlocations = Lx/numchains*[1:1:(numchains-1)]; %Physical location of each chain
    datalocations = Lz/numdata*[1:1:(numdata-1)]; %Physical location of each sensor
    chainlocations = round(chainlocations/dx); %The grid point of each chain (typically not a whole number
    %so it must be rounded)
    datalocations = round(datalocations/dz); %The grid point of each sensor on each chain
    %(again typically not a whole number, so it must be rounded)
    %% 
    numouts = final_time/plot_interval;
    maxouts = numouts;
    data_array = zeros(numdata-1,maxouts+1); %Allocate the memory for each data array
    chains = {'chain1' 'chain2' 'chain3' 'chain4' 'chain5' 'chain6' 'chain7'}; %How many chains do we have?
    for index = 1:length(chains)
        data.(chains{index}).u_data = data_array;
        data.(chains{index}).w_data = data_array;
        data.(chains{index}).rho_data = data_array;   
    end   
    fields = fieldnames(data);
    for ii = 0:maxouts
        disp(['Current output: ' num2str(ii)])
        %Read in the velocity and rho data
        u = spins_reader('u',ii);
        w = spins_reader('w',ii);
        rho = spins_reader('rho',ii);
        %Evauluate each field at the chain and data locations
        u = u(chainlocations,datalocations);
        w = w(chainlocations,datalocations);
        rho = rho(chainlocations,datalocations);
        
        %save the data from each chain to the appropriate field in the data
        %structure
        for jj = 1:numchains-1
            disp(['Current chain: ' num2str(jj)])
            data.(fields{jj}).u_data(:,ii+1) = u(jj,:);
            data.(fields{jj}).w_data(:,ii+1) = w(jj,:);
            data.(fields{jj}).rho_data(:,ii+1) = rho(jj,:);
        end
        disp(['Exit output ' num2str(ii) ' successful'])
    end
    
    data.chain_locations = chainlocations;
    data.data_locations = datalocations;
    data.t = 0:plot_interval:final_time;
    
    %add useful parameters from the spins.conf to the data structure
    newdata = fieldnames(params);
    for index = 1:length(newdata)
        data.(newdata{index}) = params.(newdata{index});
    end
    disp('Exit successful')
    
    cd(savepath)
    save(filename,'-struct','data');
   

    

