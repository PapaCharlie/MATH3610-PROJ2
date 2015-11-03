global ticks_per_minute;
global speed;
global fuel_range;
global refuel_time;
global xdim;
global ydim;
global visit_interval;
global A;
global B;
global center_x;
global center_y;
global p;
global manhattan_area;

ticks_per_minute = 5;

speed = 10/ticks_per_minute; % in blocks per tick

fuel_range = ticks_per_minute * 60 * 5 * speed; % in blocks

refuel_time = ticks_per_minute * 60 * 5; % hours

xdim = 30;
ydim = 250;

visit_interval = ones(xdim,ydim);
visit_interval(:,:) = 15;
% Set Central Park
visit_interval(10:19, 59:110) = 20;
% Set Gotham University
visit_interval(1:6, 110:122) = 5;
% Set Financial District
visit_interval(:, 1:20) = 5;
visit_interval = visit_interval * ticks_per_minute;

A = repmat((1:xdim)',1,ydim);
B = repmat(1:ydim,xdim,1);
center_x = floor(mean(mean(visit_interval.*B))); % compute center of mass
center_y = floor(mean(mean(visit_interval.*A)));
p = 0.3;
manhattan_area = xdim * ydim;