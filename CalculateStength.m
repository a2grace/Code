
clear
data_path = strcat('/Volumes/','Ext. Drive','/seiche2D/L5');
save_path = strcat('/Volumes/','Ext. Drive','/Data/');
cd(data_path)
gdpar = spins_gridparams('vector',false); split_gdpar; par2var(params);

numouts = final_time/plot_interval;
dataspacing = 2e-4;
numbins = delta_rho/dataspacing;
varmag = zeros(numouts+1,numbins);
%%

for ii = 0:1:numouts
    disp(['Output number: ' num2str(ii)])
    tic
    vari = spins_reader_new('rho',ii);
    rhox = even_x_deriv(vari,Lx,[],[]);
    rhoz = even_y_deriv(vari,[],Lz,[]);
    
    vari = 0.5*(rhox + rhoz).^2;
    
    h = histogram(vari,numbins);
    set(h,'Visible','off');
    
    varmag(ii+1,:) = h.Values; %Volume
    lims = h.BinLimits;
    toc
end  

varmag = varmag(any(varmag,2),:);
s = linspace(lims(1),lims(2),numbins);
t = linspace(0,final_time,length(0:1:numouts));

[ss,tt] = meshgrid(s,t);