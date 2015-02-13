module Robots
  class Solver
    def initialize(robot, goal)
      @robot = robot
      @goal = goal
    end

    def solved?
      !solution.empty?
    end

    def solution
      @solution ||= solve
    end

    protected

    attr_reader :robot, :goal

    private

    def solve
      fail "Subclasses must implement this"
    end
  end
end
