module Robots
  module Solvers
    class RecursiveDfs < Solver
      def initialize(*args)
        super
        @candidates = []
      end

      private

      attr_reader :candidates

      def solve
        solve_recursively(robot, [], [])
        @candidates.min_by(&:size) || []
      end

      def solve_recursively(robot, path, visited)
        return if visited.include?(robot)
        return @candidates << path if path.size > 1 && robot.home?(target)

        allowable_moves(path).each do |direction|
          solve_recursively(robot.moved(direction), path + [direction], visited + [robot])
        end
      end

      def allowable_moves(path)
        last_move = path.last
        case last_move
          when :up, :down
            [:left, :right]
          when :left, :right
            [:up, :down]
          else
            [:up, :down, :left, :right]
        end
      end
    end
  end
end
