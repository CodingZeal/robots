require "equalizer"

module Robots
  class Target
    include Equalizer.new(:color, :shape)

    attr_reader :color, :shape

    def self.vortex
      new(:vortex)
    end

    def initialize(color, shape = nil)
      color = color.downcase.to_sym
      @color = (color == :vortex) ? :any : color
      @shape = (shape || :vortex).downcase.to_sym
    end

    def matches_color?(other)
      color == :any || color == other
    end

    def to_s
      shape == :vortex ? "vortex" : "#{color} #{shape}"
    end
  end
end
