require_relative "board"
require_relative "quadrant"
require_relative "tiles"

module Robots
  class BoardMaker
    def initialize(board)
      @board = board
    end

    def populate_example
      tiles = [Tiles::A1, Tiles::B1, Tiles::C1, Tiles::D1]
      tiles.zip(Quadrant.all) do |tile, quadrant|
        tile.populate(board, quadrant: quadrant)
      end
    end

    private

    attr_reader :board
  end
end
