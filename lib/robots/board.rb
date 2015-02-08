require_relative "cell"

module Robots
  class Board
    def initialize
      @cells = Array.new(BOARD_SIZE) do |row|
        Array.new(BOARD_SIZE) do |column|
          Cell.open(self, row, column)
        end
      end
      add_special_cells
    end

    def next_cell(cell, direction)
      cell.each_moving(direction).each_cons(2) do |from, to|
        return from if blocked?(to, direction)
      end
    end

    def cell(row, column)
      return nil if off_board?(row, column)

      cells[row][column]
    end

    def top
      0
    end

    def left
      0
    end

    def bottom
      BOARD_SIZE - 1
    end

    def right
      BOARD_SIZE - 1
    end

    private

    attr_reader :cells

    def add_special_cells
      add_center_island
      add_edge_walls
    end

    def add_center_island
      add_cell(Cell.closed(self, 7, 7))
      add_cell(Cell.closed(self, 7, 8))
      add_cell(Cell.closed(self, 8, 7))
      add_cell(Cell.closed(self, 8, 8))
    end

    def add_edge_walls
      [1, 10].each { |column| add_wall_after_column(top, column) }
      [5, 11].each { |column| add_wall_after_column(bottom, column) }

      [5, 11].each { |row| add_wall_after_row(row, left) }
      [4, 8].each { |row| add_wall_after_row(row, right) }
    end

    def add_wall_after_column(row, column)
      cell(row, column).block(:left)
      cell(row, column + 1).block(:right)
    end

    def add_wall_after_row(row, column)
      cell(row, column).block(:up)
      cell(row + 1, column).block(:down)
    end

    def add_cell(cell)
      cells[cell.row][cell.column] = cell
    end

    def blocked?(cell, direction)
      cell.nil? || cell.blocked?(direction)
    end

    def off_board?(row, column)
      !on_board?(row, column)
    end

    def on_board?(row, column)
      row.between?(top, bottom) && column.between?(left, right)
    end

    BOARD_SIZE = 16
    private_constant :BOARD_SIZE
  end
end
