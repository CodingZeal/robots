require "spec_helper"
require_relative "../../shared_examples/solver_shared_examples"

module Robots
  describe "Best-first A*" do
    it_should_behave_like "a solver" do
      let(:solver) { Solvers::BestFirst.new(state, scorer: Solvers::Scorers::AStar.new(board, state)) }
    end
  end
end
