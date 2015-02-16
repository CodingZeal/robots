require "ostruct"

module Robots
  class Solver
    attr_reader :stats

    def initialize(robot, goal)
      @robot = robot
      @goal = goal
      @stats = OpenStruct.new
      stats.states_considered = 0
    end

    def outcome
      @outcome ||= record_time { solve }
    end

    protected

    attr_reader :robot, :goal

    def note_state_considered
      stats.states_considered += 1
    end

    def allowable_moves(path)
      last_move = path.last
      case last_move
        when :up, :down
          [:left, :right]
        when :left, :right
          [:up, :down]
        else
          [:up, :down, :left, :right]
      end
    end

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
