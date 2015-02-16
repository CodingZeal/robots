module Robots
  module Solvers
    class Bfs < Solver
      private

      def solve
        paths = [Path.initial(robot, goal)]

        until paths.empty? do
          note_state_considered
          path = paths.shift

          return path.to_outcome if path.solved?

          paths += path.allowable_successors
        end

        Outcome.no_solution(robot)
      end
    end
  end
end
