clear
close all

datapath = '/scratch/kglamb/a2grace/seichefiles/seiche3D/h025_3D/';
savepath = '/work/a2grace/hov/';
filename = 'hov_KE';
cd(datapath)


gdpar = spins_gridparams('vector',false); split_gdpar;
par2var(params);


%numouts = final_time/plot_interval;
numouts = 29;
myeps = 0;
rholow = -0.5*delta_rho*tanh(1)*(1+myeps);
rhohigh = -rholow;
myconts = [rhohigh rholow];
scale = 1/4;

    dummy=zeros(Nx,scale*Ny,Nz);
    rhosum=zeros(Nx,Ny,numouts+1);
    KEsum=zeros(Nx,Ny,numouts+1);
    usum=zeros(Nx,Ny);
    vsum=usum;
    wsum=usum;
for ii = 0:numouts %ouputs

    dummy=spins_reader('rho',ii,1:Nx,1:128,1:Nz);
    rhosum(:,1:128,ii+1)=squeeze(sum((dummy>rholow).*(dummy<rhohigh),3));
    dummy=spins_reader('rho',ii,1:Nx,129:256,1:Nz);
    rhosum(:,129:256,ii+1)=squeeze(sum((dummy>rholow).*(dummy<rhohigh),3));
    dummy=spins_reader('rho',ii,1:Nx,257:384,1:Nz);
    rhosum(:,257:384,ii+1)=squeeze(sum((dummy>rholow).*(dummy<rhohigh),3));
    dummy=spins_reader('rho',ii,1:Nx,385:512,1:Nz);
    rhosum(:,385:512,ii+1)=squeeze(sum((dummy>rholow).*(dummy<rhohigh),3));

    dummy=spins_reader('u',ii,1:Nx,1:128,1:Nz);
    usum(:,1:128)=squeeze(sum(dummy.^2,3));
    dummy=spins_reader('u',ii,1:Nx,129:256,1:Nz);
    usum(:,129:256)=squeeze(sum(dummy.^2,3));
    dummy=spins_reader('u',ii,1:Nx,257:384,1:Nz);
    usum(:,257:384)=squeeze(sum(dummy.^2,3));
    dummy=spins_reader('u',ii,1:Nx,385:512,1:Nz);
    usum(:,385:512)=squeeze(sum(dummy.^2,3));
   
    dummy=spins_reader('v',ii,1:Nx,1:128,1:Nz);
    vsum(:,1:128)=squeeze(sum(dummy.^2,3));
    dummy=spins_reader('v',ii,1:Nx,129:256,1:Nz);
    vsum(:,129:256)=squeeze(sum(dummy.^2,3));
    dummy=spins_reader('v',ii,1:Nx,257:384,1:Nz);
    vsum(:,257:384)=squeeze(sum(dummy.^2,3));
    dummy=spins_reader('v',ii,1:Nx,385:512,1:Nz);
    vsum(:,385:512)=squeeze(sum(dummy.^2,3));

    dummy=spins_reader('w',ii,1:Nx,1:128,1:Nz);
    wsum(:,1:128)=squeeze(sum(dummy.^2,3));
    dummy=spins_reader('w',ii,1:Nx,129:256,1:Nz);
    wsum(:,129:256)=squeeze(sum(dummy.^2,3));
    dummy=spins_reader('w',ii,1:Nx,257:384,1:Nz);
    wsum(:,257:384)=squeeze(sum(dummy.^2,3));
    dummy=spins_reader('w',ii,1:Nx,385:512,1:Nz);
    wsum(:,385:512)=squeeze(sum(dummy.^2,3));

    KEsum(:,:,ii+1) = (usum+vsum+wsum);
end
rhosum = rhosum/Nz;
KEsum = 0.5*rho_0*KEsum;
hov = struct('rhosum',rhosum,'KEsum',KEsum);

newdata = fieldnames(params);
    for index = 1:length(newdata)
        hov.(newdata{index}) = params.(newdata{index});
    end
save(filename,'-struct','hov')

filename = strcat(filename,'.mat');
movefile(filename,savepath)
