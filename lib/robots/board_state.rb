module Robots
  class BoardState
    attr_reader :robots

    def initialize(robots)
      @robots = Array(robots)
    end

    def to_s
      "Initial state:\n  " + robots.map(&:to_s).join("\n  ")
    end
  end
end
