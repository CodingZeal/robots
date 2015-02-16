module Robots
  module Solvers
    class Bfs < Solver
      private

      def solve
        paths = [Path.initial(robot)]

        until paths.empty? do
          note_state_considered
          path = paths.shift

          return path.to_outcome(goal) if path.solved?(goal)

          paths += path.allowable_successors
        end

        Outcome.no_solution(robot)
      end
    end
  end
end
