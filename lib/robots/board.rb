require_relative "position"

module Robots
  class Board
    attr_reader :top, :bottom, :left, :right

    def initialize
      @top = @left = 0
      @bottom = @right = BOARD_SIZE - 1
    end

    def next_position(position, direction)
      position.each_moving(direction).each_cons(2) do |from, to|
        return from if blocked?(to)
      end
    end

    private

    def blocked?(position)
      ISLAND.include?(position) || off_board?(position)
    end

    def off_board?(position)
      !on_board?(position)
    end

    def on_board?(position)
      position.row.between?(top, bottom) && position.column.between?(left, right)
    end

    BOARD_SIZE = 16

    ISLAND = [
      Position[7, 7],
      Position[7, 8],
      Position[8, 7],
      Position[8, 8]
    ]

    private_constant :BOARD_SIZE, :ISLAND
  end
end
