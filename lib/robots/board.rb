module Robots
  class Board
    attr_reader :top, :bottom, :left, :right

    def initialize
      @top = @left = 0
      @bottom = @right = BOARD_SIZE - 1
    end

    def position_above(position)
      if [7, 8].include?(position.column) && position.row > 8
        position.with_row(9)
      else
        position.with_row(top)
      end
    end

    def position_below(position)
      if [7, 8].include?(position.column) && position.row < 7
        position.with_row(6)
      else
        position.with_row(bottom)
      end
    end

    def position_left_of(position)
      position.with_column(left)
    end

    def position_right_of(position)
      position.with_column(right)
    end

    private

    BOARD_SIZE = 16
    private_constant :BOARD_SIZE
  end
end
