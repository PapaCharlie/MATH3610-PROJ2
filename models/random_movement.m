global minute;
global last_visited;
global visit_interval;
global speed;

minutes = 5 * 60;
num_iterations = 10;
max_mavs = 100;

xdim = 30;
ydim = 250;
manhattan_area = xdim * ydim;
speed = 10;

visit_interval = ones(xdim,ydim) * 15;
visit_interval = padarray(visit_interval, [1 1], NaN);

mean_per_drone = zeros(1, max_mavs);
for num_mavs = 1:max_mavs
  unwatched_zones_per_minute = zeros(num_iterations, minutes);
  num_mavs = num_mavs

  for iteration = 1:num_iterations
    minute = 0;
    last_visited = padarray(zeros(xdim, ydim), [1 1], NaN);

    for n = 1:num_mavs
      x = ceil(rand * (xdim - 1) + 1);
      y = ceil(rand * (ydim - 1) + 1);
      mavs{n} = MAV([x y]);
    end

    while minute ~= minutes
      minute = minute + 1;
      for n = 1:num_mavs
        mavs{n}.step();
      end
      unwatched_zones_per_minute(iteration, minute) = numel(last_visited((minute - last_visited) > visit_interval))/manhattan_area;
    end
  end

  mean_per_drone(num_mavs) = mean(unwatched_zones_per_minute(unwatched_zones_per_minute > 0));
end
save 'mean_per_drone_part1.mat' mean_per_drone

figure
plot(mean_per_drone, 'LineWidth', 2)
ylim([0 1])
title({'Percent of Poorly Monitored Zones vs'; 'Number of MAVs (uniform urgency)'})
xlabel 'Number of MAVs'
ylabel 'Poorly Monitored Zones (%)'
saveas(gca, 'random_walk_part1.pdf')

visit_interval = ones(xdim,ydim);
visit_interval(:,:) = 15;
% Set Central Park
visit_interval(10:19, 59:110) = 20;
% Set Gotham University
visit_interval(1:9, 110:122) = 5;
% Set Financial District
visit_interval(:, 1:20) = 5;
visit_interval = visit_interval;
visit_interval = padarray(visit_interval, [1 1], NaN);

mean_per_drone = zeros(1, max_mavs);
for num_mavs = 1:max_mavs
  unwatched_zones_per_minute = zeros(num_iterations,minutes);
  num_mavs = num_mavs

  for iteration = 1:num_iterations
    minute = 0;
    last_visited = padarray(zeros(xdim, ydim), [1 1], NaN);

    for n = 1:num_mavs
      x = ceil(rand * (xdim - 1) + 1);
      y = ceil(rand * (ydim - 1) + 1);
      mavs{n} = MAV([x y]);
    end

    while minute ~= minutes
      minute = minute + 1;
      for n = 1:num_mavs
        mavs{n}.step();
      end
      unwatched_zones_per_minute(iteration, minute) = numel(last_visited((minute - last_visited) > visit_interval))/manhattan_area;
    end
  end

  mean_per_drone(num_mavs) = mean(unwatched_zones_per_minute(unwatched_zones_per_minute > 0));
end
save 'mean_per_drone_part3.mat' mean_per_drone

figure
plot(mean_per_drone, 'LineWidth', 2)
ylim([0 1])
title({'Percent of Poorly Monitored Zones vs'; 'Number of MAVs (non-uniform urgency)'})
xlabel 'Number of MAVs'
ylabel 'Poorly Monitored Zones (%)'
saveas(gca, 'random_walk_part3.pdf')