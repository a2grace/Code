clear

H = 0.25; %tank height
L = 1; %tank length
%z0 = 0.125;
%eta0 = 0.0825;
%initial_amplitude = eta0;
thickness = 0.005;
%gprime = 9.81*0.01;


starttime = 0;
maxtime = 90;
numouts = 900;
t = linspace(starttime,maxtime,numouts);
dt = maxtime/numouts;

z = zeros(1,numouts);
z(1) = 2*thickness;

myk = 0;
myeps = 1/11;
mymu = 1/0.25; 

for ii = 1:numouts-1
    
    f = myeps*z(ii).*(1-mymu*L*z(ii)) + myk;
    z(ii+1) = z(ii) + dt*f;
    
end
plot(t,z)%,axis([0 90 1 3])
%hold on
%plot(t,0.1*t + z(1))