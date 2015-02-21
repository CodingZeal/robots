require "set"

module Robots
  module Solvers
    class Bfs < Solver
      def initialize(*args)
        super
        @visited = Set.new
      end

      private

      attr_reader :visited

      def solve
        paths = [Path.initial(initial_state, goal)]

        until paths.empty?
          path = paths.shift
          return path.to_outcome if path.solved?

          visit(path) || next

          paths.concat(path.allowable_successors)
        end

        Outcome.no_solution(initial_state)
      end

      def visit(path)
        return false if visited.include?(path.state)

        note_state_considered

        if short_win?(path)
          visited.clear
        else
          visited << path.state
        end

        true
      end

      def short_win?(path)
        path.state.game_over?(goal) && path.moves.size < 2
      end
    end
  end
end
