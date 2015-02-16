module Robots
  class Path
    def initialize(robot, moves)
      @robot = robot
      @moves = moves
    end

    def solved?(goal)
      robot.home?(goal) && moves.size > 1
    end

    # private

    attr_reader :robot, :moves
  end
end
