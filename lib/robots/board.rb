require_relative "cell"
require_relative "grid"

module Robots
  class Board
    def self.example
      new.tap { |board| BoardMaker.new(board).populate_example }
    end

    def initialize
      @cells = new_grid { |row, column| Cell.new(self, row, column) }
      precompute_stopping_cells
      add_center_island
    end

    def cell(row, column)
      cells.at(row, column)
    end

    def stopping_cell(cell, direction)
      stopping_cells[direction].at(cell.row, cell.column)
    end

    def targets
      each_cell.each_with_object([]) do |cell, result|
        cell.target_into(result)
        result
      end
    end

    def top
      cells.top
    end

    def left
      cells.left
    end

    def bottom
      cells.bottom
    end

    def right
      cells.right
    end

    def random_cell(random)
      loop do
        cell = cells.random_element(random)
        return cell unless island_cells.include?(cell)
      end
    end

    def add_wall_after_column(row, column)
      left_of_wall = cell(row, column)
      right_of_wall = cell(row, column + 1)
      left_of_wall.each_moving(:left).each do |cell|
        break if stopping_cell(cell, :right).column < left_of_wall.column
        stopping_cells[:right].put(cell.row, cell.column, left_of_wall)
      end
      right_of_wall.each_moving(:right).each do |cell|
        break if stopping_cell(cell, :left).column > right_of_wall.column
        stopping_cells[:left].put(cell.row, cell.column, right_of_wall)
      end
    end

    def add_wall_after_row(row, column)
      above_wall = cell(row, column)
      below_wall = cell(row + 1, column)

      above_wall.each_moving(:up).each do |cell|
        break if stopping_cell(cell, :down).row < above_wall.row
        stopping_cells[:down].put(cell.row, cell.column, above_wall)
      end

      below_wall.each_moving(:down).each do |cell|
        break if stopping_cell(cell, :up).row > below_wall.row
        stopping_cells[:up].put(cell.row, cell.column, below_wall)
      end
    end

    def add_target(row, column, target)
      cell(row, column).target = target
    end

    private

    BOARD_SIZE = 16
    private_constant :BOARD_SIZE

    attr_reader :cells, :stopping_cells

    def precompute_stopping_cells
      @stopping_cells = {
        up: new_grid { |_, column| cell(top, column) },
        down: new_grid { |_, column| cell(bottom, column) },
        left: new_grid { |row, _| cell(row, left) },
        right: new_grid { |row, _| cell(row, right) }
      }
    end

    def new_grid(&block)
      Grid.new(BOARD_SIZE, &block)
    end

    def add_center_island
      [6, 8].each do |i|
        [7, 8].each do |j|
          add_wall_after_row(i, j)
          add_wall_after_column(j, i)
        end
      end
    end

    def each_cell(&block)
      cells.each_element(&block)
    end

    def island_cells
      @island_cells ||= [cell(7, 7), cell(7, 8), cell(8, 7), cell(8, 8)]
    end
  end
end
