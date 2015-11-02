classdef MAV_deterministic < handle
  properties
    fuel_range
    quadrant
    position
  end

  methods
    function self = MAV_deterministic(quadrant)
      global fuel_range;
      self.fuel_range = fuel_range;
      self.quadrant = quadrant;
      self.position = [ quadrant(1) quadrant(2) ];
    end

    function step(self)
      global speed;
      global tick;
      global last_visited;
      self.fuel_range = self.fuel_range - speed;
      for n = 1:speed
        last_visited(self.position(1) + 1, self.position(2) + 1) = tick;
        if isequal(self.position, self.quadrant(1:2)) % at starting point
          self.position = self.position + [ 0 1 ];

        elseif self.position(2) == self.quadrant(2)
          self.position = self.position + [ -1 0 ];

        elseif self.position(1) == self.quadrant(3)
          self.position = self.position + [ 0 -1 ];

        elseif mod(self.position(1) - self.quadrant(1), 2) == 0
          if self.position(2) == self.quadrant(4)
            self.position = self.position + [ 1 0 ];
          else
            self.position = self.position + [ 0 1 ];
          end

        elseif mod(self.position(1) - self.quadrant(1), 2) == 1
          if self.position(2) == self.quadrant(2) + 1
            self.position = self.position + [ 1 0 ];
          else
            self.position = self.position + [ 0 -1 ];
          end
        end
      end
    end
  end
end