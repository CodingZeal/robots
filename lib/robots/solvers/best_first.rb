require_relative "tree_solver"
require "fc"

module Robots
  module Solvers
    class BestFirst < TreeSolver
      private

      def make_paths(path)
        FastContainers::PriorityQueue.new(:min).tap do |paths|
          add_path(paths, path)
        end
      end

      def next_path(paths)
        paths.top
      ensure
        paths.pop
      end

      def add_paths(paths, successors)
        successors.each { |path| add_path(paths, path) }
      end

      def add_path(paths, path)
        paths.push(path, score(path))
      end

      def score(path)
        path.length
      end
    end
  end
end
