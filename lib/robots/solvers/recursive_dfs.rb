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
        solve_recursively(Path.initial(robot, goal))
        record_stats
        candidates.min_by(&:length) || Outcome.no_solution(robot)
      end

      def solve_recursively(path)
        note_state_considered

        return candidates << path.to_outcome if path.solved?

        path.allowable_successors.each do |successor|
          solve_recursively(successor)
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
