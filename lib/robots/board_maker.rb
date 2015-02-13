require_relative "board"

module Robots
  class BoardMaker
    def initialize(board)
      @board = board
    end

    def populate_example
      add_interior_walls
      add_targets
    end

    private

    def add_interior_walls
      VERTICAL_WALLS.each_with_index do |walls, row|
        walls.each do |column|
          add_wall_after_column(row, column)
        end
      end

      HORIZONTAL_WALLS.each_with_index do |walls, column|
        walls.each do |row|
          add_wall_after_row(row, column)
        end
      end
    end

    def add_targets
      TARGETS.each do |row, column, color, shape|
        board.cell(row, column).target = Target.new(color, shape)
      end
    end

    def add_wall_after_column(row, column)
      board.cell(row, column).block(:left)
      board.cell(row, column + 1).block(:right)
    end

    def add_wall_after_row(row, column)
      board.cell(row, column).block(:up)
      board.cell(row + 1, column).block(:down)
    end

    attr_reader :board

    VERTICAL_WALLS = [
      [1, 10],
      [3, 8],
      [1, 14],
      [6],
      [10],
      [],
      [2, 11],
      [],
      [4],
      [1],
      [7, 12],
      [10],
      [13],
      [4],
      [1, 9],
      [5, 11]
    ]

    HORIZONTAL_WALLS = [
      [5, 11],
      [1, 14],
      [8],
      [6],
      [0, 12],
      [8],
      [3],
      [],
      [9],
      [1, 13],
      [4, 11],
      [],
      [5],
      [9],
      [1, 12],
      [4, 8]
    ]

    TARGETS = [
      [1, 4, :red, :circle],
      [1, 9, :green, :hex],
      [2, 1, :green, :triangle],
      [2, 14, :yellow, :circle],
      [3, 6, :yellow, :hex],
      [4, 10, :red, :square],
      [6, 3, :blue, :square],
      [6, 12, :blue, :triangle],
      [8, 5, :yellow, :square],
      [9, 2, :green, :circle],
      [10, 8, :vortex],
      [10, 13, :red, :hex],
      [11, 10, :green, :square],
      [12, 14, :yellow, :triangle],
      [13, 4, :blue, :hex],
      [14, 1, :red, :triangle],
      [14, 9, :blue, :circle]
    ]

    private_constant :VERTICAL_WALLS, :HORIZONTAL_WALLS, :TARGETS
  end
end
