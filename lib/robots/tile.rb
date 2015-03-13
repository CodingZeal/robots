module Robots
  class Tile
    def initialize(name, targets:, vertical_walls:, horizontal_walls:)
      @name = name
      @targets = targets
      @vertical_walls = vertical_walls
      @horizontal_walls = horizontal_walls
    end

    def populate(board, quadrant:)
      add_targets(board, quadrant)
      add_vertical_walls(board, quadrant)
      add_horizontal_walls(board, quadrant)
    end

    def to_s
      name
    end

    private

    attr_reader :name, :targets, :vertical_walls, :horizontal_walls

    def add_targets(board, quadrant)
      targets.each do |row, column, color, shape|
        quadrant.add_target(board, row, column, Target.new(color, shape))
      end
    end

    def add_vertical_walls(board, quadrant)
      vertical_walls.each do |row, column|
        quadrant.add_vertical_wall(board, row, column)
      end
    end

    def add_horizontal_walls(board, quadrant)
      horizontal_walls.each do |row, column|
        quadrant.add_horizontal_wall(board, row, column)
      end
    end
  end
end
