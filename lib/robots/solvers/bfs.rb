require_relative "tree_solver"
require "set"

module Robots
  module Solvers
    class Bfs < TreeSolver
      def initialize(*args)
        super
        @last_path_length = 0
      end

      private

      def make_paths(path)
        [path]
      end

      def next_path(paths)
        paths.shift
      end

      def add_paths(paths, successors)
        paths.concat(successors)
      end

      attr_reader :last_path_length

      def report_progress(path)
        return if path.length == last_path_length

        puts "Considering paths of length #{path.length} (#{stats.states_considered} states considered)"
        @last_path_length = path.length
      end
    end
  end
end
