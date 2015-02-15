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
        stats.states_considered = 0
        solve_recursively(robot, [], [])
        stats.solutions_found = candidates.size
        longest_solution = candidates.max_by(&:length)
        stats.longest_solution = longest_solution ? longest_solution.length : 0
        candidates.min_by(&:length) || Outcome.no_solution(robot)
      end

      def solve_recursively(robot, path, visited)
        return if visited.include?(robot)

        stats.states_considered += 1

        return candidates << Outcome.solved(path, robot) if path.size > 1 && robot.home?(goal)

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
