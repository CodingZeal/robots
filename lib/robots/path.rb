module Robots
  class Path
    attr_reader :robot, :moves, :visited

    def initialize(robot, moves = [], visited = [])
      @robot = robot
      @moves = moves
      @visited = visited
    end

    def successor(direction)
      next_robot = robot.moved(direction)
      next_robot == robot ? nil : self.class.new(next_robot, moves + [direction], visited + [robot])
    end

    def allowable_successors
      allowable_moves.map { |direction| successor(direction) }.compact.reject(&:cycle?)
    end

    def solved?(goal)
      robot.home?(goal) && moves.size > 1
    end

    def cycle?
      visited.include?(robot)
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
