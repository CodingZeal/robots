require_relative "cell"
require "equalizer"

module Robots
  class Robot
    include Equalizer.new(:color, :cell)

    attr_reader :color, :cell

    def initialize(color, cell)
      @color = color.downcase.to_sym
      @cell = cell
    end

    def moved(direction, board_state)
      self.class.new(color, cell.next_cell(direction, board_state))
    end

    def with_color(new_color)
      self.class.new(new_color, cell)
    end

    def home?(goal)
      goal.matches_color?(color) && cell.goal?(goal)
    end

    def to_s
      "The #{color} robot is at #{cell}."
    end
  end
end
