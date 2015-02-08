require_relative "cell"

module Robots
  class Robot
    attr_reader :cell

    def initialize(cell)
      @cell = cell
    end

    def move(direction)
      @cell = cell.next_cell(direction)
    end
  end
end
