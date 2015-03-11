module Robots
  class Tile
    def initialize(targets:, vertical_walls:, horizontal_walls:)
      @targets = targets
      @vertical_walls = vertical_walls
      @horizontal_walls = horizontal_walls
    end

    def populate(board, quadrant:)
      add_targets(board, quadrant)
      add_vertical_walls(board, quadrant)
      add_horizontal_walls(board, quadrant)
    end

    private

    attr_reader :targets, :vertical_walls, :horizontal_walls

    def add_targets(board, quadrant)
      targets.each do |row, column, color, shape|
        add_target(board, quadrant, row, column, Target.new(color, shape))
      end
    end

    def add_vertical_walls(board, quadrant)
      vertical_walls.each do |row, column|
        add_vertical_wall(board, quadrant, row, column)
      end
    end

    def add_horizontal_walls(board, quadrant)
      horizontal_walls.each do |row, column|
        add_horizontal_wall(board, quadrant, row, column)
      end
    end

    def add_target(board, quadrant, row, column, target)
      case quadrant
        when Quadrant::UpperLeft
          board.add_target(row, column, target)
        when Quadrant::UpperRight
          board.add_target(column, board.size - row - 1, target)
        when Quadrant::LowerRight
          board.add_target(board.size - row - 1, board.size - column - 1, target)
        when Quadrant::LowerLeft
          board.add_target(board.size - column - 1, row, target)
      end
    end

    def add_vertical_wall(board, quadrant, row, column)
      case quadrant
        when Quadrant::UpperLeft
          board.add_wall_after_column(row, column)
        when Quadrant::UpperRight
          board.add_wall_after_row(column, board.size - row - 1)
        when Quadrant::LowerRight
          board.add_wall_after_column(board.size - row - 1, board.size - column - 2)
        when Quadrant::LowerLeft
          board.add_wall_after_row(board.size - column - 2, row)
      end
    end

    def add_horizontal_wall(board, quadrant, row, column)
      case quadrant
        when Quadrant::UpperLeft
          board.add_wall_after_row(row, column)
        when Quadrant::UpperRight
          board.add_wall_after_column(column, board.size - row - 2)
        when Quadrant::LowerRight
          board.add_wall_after_row(board.size - row - 2, board.size - column - 1)
        when Quadrant::LowerLeft
          board.add_wall_after_column(board.size - column - 1, row)
      end
    end
  end
end
