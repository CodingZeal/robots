require "ostruct"

module Robots
  class Solver
    attr_reader :stats

    def initialize(state, goal)
      @initial_state = state
      @goal = goal
      @stats = OpenStruct.new
      stats.states_considered = 0
    end

    def outcome
      @outcome ||= record_time { solve }
    end

    protected

    attr_reader :initial_state, :goal

    def note_state_considered
      stats.states_considered += 1
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
      stats.solving_time = "#{elapsed.round(3)}s"
      stats.states_per_second = (stats.states_considered / elapsed).round
    end
  end
end
