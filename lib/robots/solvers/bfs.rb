require "set"

module Robots
  module Solvers
    class Bfs < Solver
      def initialize(*args)
        super
        @visited = Set.new
        @last_path_length = 0
      end

      private

      attr_reader :visited, :last_path_length

      def solve
        paths = [Path.initial(initial_state)]

        until paths.empty?
          path = paths.shift

          report_progress(path) if verbose?

          visit(path) || next

          successors = path.allowable_successors
          solution = successors.find(&:solved?)

          return solution.to_outcome if solution

          paths.concat(successors)
        end

        Outcome.no_solution(initial_state)
      end

      def visit(path)
        equivalence_class = path.state.equivalence_class
        return false if visited.include?(equivalence_class)

        note_state_considered

        if short_win?(path)
          visited.clear
        else
          visited << equivalence_class
        end

        true
      end

      def short_win?(path)
        path.state.game_over? && path.moves.size < 2
      end

      def report_progress(path)
        return if path.length == last_path_length

        puts "Considering paths of length #{path.length} (#{stats.states_considered} states considered)"
        @last_path_length = path.length
      end
    end
  end
end
