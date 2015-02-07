require_relative "position"

module Robots
  class Robot
    attr_reader :position

    def initialize(at:, on:)
      @position = at
      @board = on
    end

    def north
      @position = board.position_above(position)
    end

    def south
      @position = board.position_below(position)
    end

    def west
      @position = board.position_left_of(position)
    end

    def east
      @position = board.position_right_of(position)
    end

    private

    attr_reader :board
  end
end
