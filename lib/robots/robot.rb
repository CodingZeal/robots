require_relative "position"

module Robots
  class Robot
    attr_reader :position

    def initialize(at:, on:)
      @position = at
      @board = on
    end

    def move(direction)
      @position = board.next_position(position, direction)
    end

    private

    attr_reader :board
  end
end
