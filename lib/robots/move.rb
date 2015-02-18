module Robots
  class Move
    attr_reader :robot, :direction

    def initialize(robot, direction)
      @robot = robot
      @direction = direction
    end

    def to_s
      "#{robot.color.to_s.capitalize} #{direction.to_s}"
    end
  end
end
