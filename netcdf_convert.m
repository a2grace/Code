close all
clear

save_path = '/scratch/kglamb/a2grace/seichefiles/seiche3D/h025_3D/netcdf_files/';
data_path = '/scratch/kglamb/a2grace/seichefiles/seiche3D/h025_3D/';
cd(data_path);

x = spins_reader('xgrid');
y = spins_reader('ygrid');
z = spins_reader('zgrid');

x1D=squeeze(x(:,1,1));
y1D=squeeze(y(1,:,1));
z1D=squeeze(z(1,1,:));

gdpar = spins_gridparams('vector',false); split_gdpar;
par2var(params);


numouts = 0;

myfields = {'rho' 'u' 'u_x' 'u_y' 'u_z' ...
    'v' 'v_x' 'v_y' 'v_z' ...
    'w' 'w_x' 'w_y' 'w_z'};
dt = plot_interval;

for ii=0:numouts
    filename=[num2str(ii) '.nc'];
    ncid = netcdf.create(filename,'netcdf4');
    
    x_dimID = netcdf.defDim(ncid,'x',Nx);
    y_dimID = netcdf.defDim(ncid,'y',Ny);
    z_dimID = netcdf.defDim(ncid,'z',Nz);
    t_dimID = netcdf.defDim(ncid,'time',1);
    
    for jj = 1:length(myfields)
        
        disp([(myfields{jj}) ' on output ' num2str(ii)]) 
        dummy = spins_reader((myfields{jj}),ii);
        mybutt = netcdf.defVar(ncid,(myfields{jj}),'NC_FLOAT',...
            [x_dimID y_dimID z_dimID]);
        netcdf.putVar(ncid,mybutt,dummy);

    end
    
    xID = netcdf.defVar(ncid,'x','NC_FLOAT',x_dimID);
    yID = netcdf.defVar(ncid,'y','NC_FLOAT',y_dimID);
    zID = netcdf.defVar(ncid,'z','NC_FLOAT',z_dimID);
    timeID = netcdf.defVar(ncid,'time','NC_FLOAT',t_dimID);
    
    netcdf.putVar(ncid,xID,x1D);
    netcdf.putVar(ncid,yID,y1D);
    netcdf.putVar(ncid,zID,z1D);
    netcdf.putVar(ncid,timeID,ii*dt);
    
    netcdf.close(ncid);
%    movefile(filename,save_path);
end
