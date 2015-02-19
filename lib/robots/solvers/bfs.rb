module Robots
  module Solvers
    class Bfs < Solver
      private

      def solve
        paths = [Path.initial(state, goal)]

        until paths.empty?
          note_state_considered

          path = paths.shift
          return path.to_outcome if path.solved?

          paths += path.allowable_successors
        end

        Outcome.no_solution(state)
      end
    end
  end
end
