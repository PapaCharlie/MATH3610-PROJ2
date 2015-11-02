parameters;

visit_interval = padarray(visit_interval, [1 1], NaN);

num_mavs = 80;
total_ticks = 500;
iterations = 5;

global tick;
global last_visited;

mean_unwatched = zeros(1, 100);

for num_mavs = 1:100
  unwatched_zones_per_tick = zeros(iterations,total_ticks);
  num_mavs = num_mavs

  for iteration = 1:iterations
    tick = 0;
    last_visited = padarray(zeros(xdim, ydim), [1 1], NaN);

    for n = 1:(num_mavs/2)
      x = ceil(rand * (xdim - 1) + 1);
      y = ceil(rand * (ydim - 1) + 1);
      mavs{n} = MAV_random([x y]);
    end

    while tick ~= total_ticks
      tick = tick + 1;
      for n = 1:(num_mavs/2)
        mavs{n}.step();
      end
      unwatched_zones_per_tick(iteration, tick) = numel(last_visited((tick - last_visited) > visit_interval))/manhattan_area;
    end
  end
  % close all;
  % figure;
  % plot(unwatched_zones_per_tick');

  mean_unwatched(num_mavs) = mean(unwatched_zones_per_tick(unwatched_zones_per_tick > 0));
end