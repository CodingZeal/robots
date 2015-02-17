require_relative "cell"
require "equalizer"

module Robots
  class Robot
    include Equalizer.new(:color, :cell)

    attr_reader :cell

    def initialize(color, cell)
      @color = color
      @cell = cell
    end

    def moved(direction, board_state)
      Robot.new(color, cell.next_cell(direction, board_state))
    end

    def home?(goal)
      # goal.matches_color?(color) && cell.goal?(goal)
      cell.goal?(goal)
    end

    def to_s
      "The #{color} robot is at #{cell}."
    end

    private

    attr_reader :color
  end
end
