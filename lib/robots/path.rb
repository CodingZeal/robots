module Robots
  class Path
    attr_reader :robot, :moves

    def initialize(robot, moves)
      @robot = robot
      @moves = moves
    end

    def successor(direction)
      next_robot = robot.moved(direction)
      next_robot == robot ? nil : self.class.new(next_robot, moves + [direction])
    end

    def solved?(goal)
      robot.home?(goal) && moves.size > 1
    end

    def to_outcome(goal)
      solved?(goal) ? Outcome.solved(moves, robot) : Outcome.no_solution(robot)
    end
  end
end
