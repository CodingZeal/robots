module Robots
  module Solvers
    class Bfs < Solver
      private

      def solve
        paths = [Path.initial(robot, goal)]

        until paths.empty?
          note_state_considered
          path = paths.shift

          return path.to_outcome if path.solved?

          paths += path.allowable_successors
        end

        Outcome.no_solution(BoardState.new(robot))
      end
    end
  end
end
