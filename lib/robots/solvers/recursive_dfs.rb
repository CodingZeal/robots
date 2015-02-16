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
        solve_recursively(Path.new(robot, []), [])
        record_stats
        candidates.min_by(&:length) || Outcome.no_solution(robot)
      end

      def solve_recursively(path, visited)
        return if path.nil? || visited.include?(path.robot)

        note_state_considered
        return candidates << path.to_outcome(goal) if path.solved?(goal)

        allowable_moves(path.moves).each do |direction|
          solve_recursively(path.successor(direction), visited + [path.robot])
        end
      end

      def record_stats
        stats.solutions_found = candidates.size
        longest_solution = candidates.max_by(&:length)
        stats.longest_solution = longest_solution ? longest_solution.length : 0
      end
    end
  end
end
