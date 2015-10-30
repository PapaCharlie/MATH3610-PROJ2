ticks_per_minute = 5;

sight_radius = 1;
xdim = ceil(20 / sight_radius);
ydim = ceil(150 / sight_radius);
visit_interval = ones(xdim,ydim) * 15 * ticks_per_minute;
A = repmat((1:xdim)',1,ydim);
B = repmat(1:ydim,xdim,1);
center_x = floor(mean(mean(visit_interval.*B))); % compute center of mass
center_y = floor(mean(mean(visit_interval.*A)));
p = 0.3;