require "equalizer"
require "set"

module Robots
  class BoardState
    include Equalizer.new(:robots)

    attr_reader :robots

    def initialize(robots)
      @robots = Array(robots).to_set
    end

    def to_s
      "Initial state:\n  " + robots.map(&:to_s).join("\n  ")
    end
  end
end
