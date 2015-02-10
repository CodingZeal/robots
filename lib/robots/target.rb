require "equalizer"

module Robots
  class Target
    include Equalizer.new(:color, :shape)

    def self.vortex
      new(:any, :vortex)
    end

    def initialize(color, shape)
      @color = color
      @shape = shape
    end

    def matches_color?(other)
      color == :any || color == other
    end

    private

    attr_reader :color, :shape
  end
end
