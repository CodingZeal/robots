require "spec_helper"
require_relative "../../shared_examples/solver_shared_examples"

module Robots
  describe "Best-first shortest-then-most-recently-used-first" do
    let(:solver) { Solvers::BestFirst.new(state, scorer: Solvers::Scorers::ShortestThenMRUFirst.new) }

    it_should_behave_like "a solver"
  end
end
