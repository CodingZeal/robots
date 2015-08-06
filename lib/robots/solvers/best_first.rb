require_relative "tree_solver"
require "fc"

module Robots
  module Solvers
    class BestFirst < TreeSolver
      def initialize(state, scorer:, verbose: false)
        super(state, verbose: verbose)
        @scorer = scorer
      end

      private

      attr_reader :scorer

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
        scorer.score(path)
      end
    end
  end
end
