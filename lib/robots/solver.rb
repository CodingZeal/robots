module Robots
  class Solver
    def initialize(robot, target)
      @robot = robot
      @target = target
    end

    def solved?
      !solution.empty?
    end

    def solution
      @solution ||= solve
    end

    protected

    attr_reader :robot, :target

    private

    def solve
      fail "Subclasses must implement this"
    end
  end
end
