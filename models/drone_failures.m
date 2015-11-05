% our dimensions for the city in blocks 
xdim = 30;
ydim = 250;

path_length = xdim*ydim;
num_mavs = 50; % changed until max unobserved time was 
blocks_per_minute = 10;
num_ticks; %ticks before run out of fuel
p = [];
t = [];
for frac = 1:30
    num_mavs = 50*(1-(frac-1)/100);
    t = [t, path_length/(num_mavs*blocks_per_minute)];
    p = [p, frac];
end
plot(p,t)
xlabel('Percent of Drones Failed');
ylabel('Maximum Interval Unobserved (min)');

    
    
    
    
    