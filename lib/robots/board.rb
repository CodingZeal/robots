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

    def size
      BOARD_SIZE
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
      block(cell(row, column), :left)
      block(cell(row, column + 1), :right)
    end

    def add_wall_after_row(row, column)
      block(cell(row, column), :up)
      block(cell(row + 1, column), :down)
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
      Grid.new(size, &block)
    end

    def block(wall_cell, direction)
      opposite_direction = opposite(direction)
      wall_cell.each_moving(direction).each do |cell|
        break if stopping_cell(cell, opposite_direction).between?(cell, wall_cell)
        stopping_cells[opposite_direction].put(cell.row, cell.column, wall_cell)
      end
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

    def opposite(direction)
      case direction
        when :up
          :down
        when :down
          :up
        when :left
          :right
        when :right
          :left
      end
    end
  end
end
