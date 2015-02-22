require "spec_helper"
require_relative "../shared_examples/solver_shared_examples"

module Robots
  describe Solvers::GoalRobotFirst do
    it_should_behave_like "a solver"
  end
end
