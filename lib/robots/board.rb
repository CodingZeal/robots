require_relative "position"

module Robots
  class Board
    attr_reader :top, :bottom, :left, :right

    def initialize
      @top = @left = 0
      @bottom = @right = BOARD_SIZE - 1
    end

    def position_above(position)
      position.each_above.each_cons(2) do |below, above|
        return below if blocked?(above)
      end
    end

    def position_below(position)
      position.each_below.each_cons(2) do |above, below|
        return above if blocked?(below)
      end
    end

    def position_left_of(position)
      position.with_column(left)
    end

    def position_right_of(position)
      position.with_column(right)
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
      Position.new(row: 7, column: 7),
      Position.new(row: 7, column: 8),
      Position.new(row: 8, column: 7),
      Position.new(row: 8, column: 8)
    ]
    private_constant :BOARD_SIZE, :ISLAND
  end
end
