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

    def allowable_successors
      allowable_moves.map { |direction| successor(direction) }.compact
    end

    def solved?(goal)
      robot.home?(goal) && moves.size > 1
    end

    def to_outcome(goal)
      solved?(goal) ? Outcome.solved(moves, robot) : Outcome.no_solution(robot)
    end

    private

    def allowable_moves
      case moves.last
        when :up, :down
          %i(left right)
        when :left, :right
          %i(up down)
        else
          %i(up down left right)
      end
    end
  end
end
