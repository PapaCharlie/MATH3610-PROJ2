parameters;


total_ticks = 500;
iterations = 5;
max_mavs = 75;

global tick;
global last_visited;
global visit_interval;

visit_interval = ones(xdim,ydim) * 15 * ticks_per_minute;
visit_interval = padarray(visit_interval, [1 1], NaN);

mean_per_drone = zeros(1, max_mavs);
for num_mavs = 1:max_mavs
  unwatched_zones_per_tick = zeros(iterations,total_ticks);
  num_mavs = num_mavs

  for iteration = 1:iterations
    tick = 0;
    last_visited = padarray(zeros(xdim, ydim), [1 1], NaN);

    for n = 1:num_mavs
      x = ceil(rand * (xdim - 1) + 1);
      y = ceil(rand * (ydim - 1) + 1);
      mavs{n} = MAV_random([x y]);
    end

    while tick ~= total_ticks
      tick = tick + 1;
      for n = 1:num_mavs
        mavs{n}.step();
      end
      unwatched_zones_per_tick(iteration, tick) = numel(last_visited((tick - last_visited) > visit_interval))/manhattan_area;
    end
  end

  mean_per_drone(num_mavs) = mean(unwatched_zones_per_tick(unwatched_zones_per_tick > 0));
end
save 'mean_per_drone_part1.mat' mean_per_drone

visit_interval = ones(xdim,ydim);
visit_interval(:,:) = 15;
% Set Central Park
visit_interval(6:12, 60:110) = 20;
% Set Gotham University
visit_interval(1:4, 110:120) = 5;
% Set Financial District
visit_interval(:, 1:20) = 5;
visit_interval = visit_interval * ticks_per_minute;
visit_interval = padarray(visit_interval, [1 1], NaN);

mean_per_drone = zeros(1, max_mavs);
for num_mavs = 1:max_mavs
  unwatched_zones_per_tick = zeros(iterations,total_ticks);
  num_mavs = num_mavs

  for iteration = 1:iterations
    tick = 0;
    last_visited = padarray(zeros(xdim, ydim), [1 1], NaN);

    for n = 1:num_mavs
      x = ceil(rand * (xdim - 1) + 1);
      y = ceil(rand * (ydim - 1) + 1);
      mavs{n} = MAV_random([x y]);
    end

    while tick ~= total_ticks
      tick = tick + 1;
      for n = 1:num_mavs
        mavs{n}.step();
      end
      unwatched_zones_per_tick(iteration, tick) = numel(last_visited((tick - last_visited) > visit_interval))/manhattan_area;
    end
  end

  mean_per_drone(num_mavs) = mean(unwatched_zones_per_tick(unwatched_zones_per_tick > 0));
end
save 'mean_per_drone_part3.mat' mean_per_drone
