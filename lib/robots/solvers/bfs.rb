require "set"

module Robots
  module Solvers
    class Bfs < Solver
      private

      def solve
        visited = Set.new
        paths = [Path.initial(initial_state, goal)]

        until paths.empty?
          path = paths.shift
          state = path.state

          return path.to_outcome if path.solved?
          next if visited.include?(state)

          note_state_considered

          if state.game_over?(goal) && path.moves.size < 2
            visited.clear
          else
            visited << state
          end

          paths += path.allowable_successors
        end

        Outcome.no_solution(initial_state)
      end
    end
  end
end
