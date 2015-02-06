module Robots
  class Board
    attr_reader :top, :bottom, :left, :right

    def initialize
      @top = @left = 0
      @bottom = @right = BOARD_SIZE - 1
    end

    private

    BOARD_SIZE = 16
    private_constant :BOARD_SIZE
  end
end

