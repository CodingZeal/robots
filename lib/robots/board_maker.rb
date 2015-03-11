require_relative "board"
require_relative "quadrant"
require_relative "tiles"

module Robots
  class BoardMaker
    def initialize(board)
      @board = board
    end

    def populate_random(random)
      populate_with_tiles(Tiles.random_layout(random))
    end

    def populate_example
      populate_with_tiles(Tiles.groups.map(&:first))
    end

    private

    attr_reader :board

    def populate_with_tiles(tiles)
      tiles.zip(Quadrant.all) do |tile, quadrant|
        tile.populate(board, quadrant: quadrant)
      end
    end
  end
end
