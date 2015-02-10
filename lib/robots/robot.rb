require_relative "cell"

module Robots
  class Robot
    attr_reader :cell

    def initialize(color, cell)
      @color = color
      @cell = cell
    end

    def move(direction)
      @cell = cell.next_cell(direction)
    end

    def home?(goal)
      goal.matches_color?(color) && cell.goal?(goal)
    end

    private

    attr_reader :color
  end
end
