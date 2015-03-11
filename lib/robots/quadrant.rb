module Quadrant
  class UpperLeft
    def add_target(board, row, column, target)
      board.add_target(row, column, target)
    end

    def add_vertical_wall(board, row, column)
      board.add_wall_after_column(row, column)
    end

    def add_horizontal_wall(board, row, column)
      board.add_wall_after_row(row, column)
    end
  end

  class UpperRight
    def add_target(board, row, column, target)
      board.add_target(column, board.size - row - 1, target)
    end

    def add_vertical_wall(board, row, column)
      board.add_wall_after_row(column, board.size - row - 1)
    end

    def add_horizontal_wall(board, row, column)
      board.add_wall_after_column(column, board.size - row - 2)
    end
  end

  class LowerRight
    def add_target(board, row, column, target)
      board.add_target(board.size - row - 1, board.size - column - 1, target)
    end

    def add_vertical_wall(board, row, column)
      board.add_wall_after_column(board.size - row - 1, board.size - column - 2)
    end

    def add_horizontal_wall(board, row, column)
      board.add_wall_after_row(board.size - row - 2, board.size - column - 1)
    end
  end

  class LowerLeft
    def add_target(board, row, column, target)
      board.add_target(board.size - column - 1, row, target)
    end

    def add_vertical_wall(board, row, column)
      board.add_wall_after_row(board.size - column - 2, row)
    end

    def add_horizontal_wall(board, row, column)
      board.add_wall_after_column(board.size - column - 1, row)
    end
  end
end
