require "ostruct"

module Robots
  class Solver
    attr_reader :stats

    def initialize(robot, goal)
      @robot = robot
      @goal = goal
      @stats = OpenStruct.new
    end

    def outcome
      @outcome ||= solve
    end

    protected

    attr_reader :robot, :goal

    private

    def solve
      fail "Subclasses must implement this"
    end
  end
end
