require_relative "board"
require_relative "quadrant"
require_relative "tiles"

module Robots
  class BoardMaker
    def initialize(board)
      @board = board
    end

    def populate_example
      populate_with_tiles(Tiles.groups.map(&:first))
    end

    def populate_with_tiles(tiles)
      tiles.zip(Quadrant.all) do |tile, quadrant|
        tile.populate(board, quadrant: quadrant)
      end
    end

    private

    attr_reader :board
  end
end
