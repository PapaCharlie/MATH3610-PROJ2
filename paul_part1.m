clear
num_mavs = 40;

parameters;

manhattan = xdim * ydim;

visit_interval = 15 * ticks_per_minute;

% Given that all points need to be seen every 15 minutes
% Basically as far as it can go before it needs to revisit the intial point
ideal_quadrant_size = speed * visit_interval;
ideal_quadrant_size = ideal_quadrant_size - mod(ideal_quadrant_size, 1);

% num_mavs over 2 such that when a MAV goes down, it can immediately be replaced
num_quadrants = min(ceil(manhattan/ideal_quadrant_size), floor(num_mavs/2))

true_quadrant_size = ceil(manhattan/num_quadrants)
% Stretch out the true size when quadrant has no odd divisor
divs = divisors(true_quadrant_size);
true_quadrant_size = true_quadrant_size + (length(divs(mod(divs+1,2) == 0)) == 1)
divs = divisors(true_quadrant_size);
divs = divs(2:end-1);

length_divs = length(divs);

% Now that we have the number of quadrants and their size, try to
% distribute them as best as possible across Manhattan
% If a nice, whole numbered solution exists, this will find the size of the
% quadrants
for n = floor(length_divs/2):-1:1
  if mod(divs(n),2)== 0 || mod(divs(length_divs + 1 - n),2) == 0
    if mod(xdim/divs(n),1) == 0 && mod(num_quadrants/(xdim/divs(n)), 1) == 0 && ydim/(num_quadrants/(xdim/divs(n))) == divs(length_divs + 1 - n)
      quad_width = divs(n)
      quad_height = divs(length_divs + 1 - n)
    end
    if mod(ydim/divs(n),1) == 0 && mod(num_quadrants/(ydim/divs(n)), 1) == 0 && xdim/(num_quadrants/(ydim/divs(n))) == divs(length_divs + 1 - n)
      quad_width = divs(length_divs + 1 - n)
      quad_height = divs(n)
    end
  end
end

if ~exist('quad_width') && ~exist('quad_height')
  disp('No whole numbered solution was found!')
  return
end

for y = 0:(ydim/quad_height)-1
  for x = 0:(xdim/quad_width)-1
    quadrants{y*(xdim/quad_width) + x + 1} = [ x*quad_width y*quad_height (x+1)*quad_width-1 (y+1)*quad_height-1 ];
  end
end

for n = 1:num_quadrants
  mavs{n} = MAV(quadrants{n});
end

% Assume everything is unvisited at first, but MAVs start at the corner of their quadrant
global last_visited;
last_visited = ones(xdim, ydim).*visit_interval;

total_ticks = ticks_per_minute * 60 * 20; % ~ one day
global tick;
tick = 0;

unwatched_zones_per_tick = zeros(1,total_ticks);

while tick ~= total_ticks
  tick = tick + 1;
  for n = 1:num_quadrants
    mavs{n}.step();
  end
  (tick - last_visited)'
  waitforbuttonpress
  unwatched_zones_per_tick(tick) = numel(last_visited((tick - last_visited) > visit_interval));
end

close all
figure
plot(unwatched_zones_per_tick)
