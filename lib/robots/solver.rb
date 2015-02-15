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
      @outcome ||= record_time { solve }
    end

    protected

    attr_reader :robot, :goal

    private

    def solve
      fail "Subclasses must implement this"
    end

    def record_time
      start_time = Time.now
      yield
    ensure
      elapsed = Time.now - start_time
      stats.solving_time = (elapsed * 1000).round(3)
    end
  end
end
