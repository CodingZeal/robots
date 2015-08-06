require "spec_helper"
require_relative "../../shared_examples/solver_shared_examples"

module Robots
  describe "Best-first shortest-first" do
    let(:solver) { Solvers::BestFirst.new(state, scorer: Solvers::Scorers::ShortestFirst.new) }

    it_should_behave_like "a solver"
  end
end
