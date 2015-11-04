classdef MAV < handle
  properties
    position
  end

  methods
    function self = MAV(position)
      self.position = position;
    end

    function step(self)
      global speed;
      global minute;
      global last_visited;
      global visit_interval;
      for t = 1:speed
        neighbors = [ -1 0; 0 1; 1 0; 0 -1 ];
        neighbors(:, 1) = neighbors(:,1) + self.position(1);
        neighbors(:, 2) = neighbors(:, 2) + self.position(2);
        urgency = zeros(1,4);
        for n = 1:4
          urgency(n) = visit_interval(neighbors(n, 1), neighbors(n, 2)) - (minute - last_visited(neighbors(n, 1), neighbors(n, 2)));
        end
        [m, m_index] = min(urgency);
        if numel(find(urgency == m)) > 1
          direction = datasample(find(urgency == m), 1);
          self.position = neighbors(direction, :);
          last_visited(self.position(1), self.position(2)) = minute;
        else
          self.position = neighbors(m_index, :);
          last_visited(self.position(1), self.position(2)) = minute;
        end
      end
    end
  end
end