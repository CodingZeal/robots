require_relative "position"

module Robots
  class Robot
    attr_reader :position

    def initialize(at:, on:)
      @position = at
      @board = on
    end

    def north
      @position = position.with_row(board.top)
    end

    def south
      @position = position.with_row(board.bottom)
    end

    def west
      @position = position.with_column(board.left)
    end

    def east
      @position = position.with_column(board.right)
    end

    private

    attr_reader :board
  end
end
