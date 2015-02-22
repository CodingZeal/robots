require_relative "cell"

module Robots
  class Board
    def self.example
      new.tap { |board| BoardMaker.new(board).populate_example }
    end

    def initialize
      @cells = Array.new(BOARD_SIZE) do |row|
        Array.new(BOARD_SIZE) do |column|
          Cell.new(self, row, column)
        end
      end
      add_center_island
    end

    def cell(row, column)
      return nil if off_board?(row, column)

      cells[row][column]
    end

    def targets
      each_cell.each_with_object([]) do |cell, result|
        cell.target_into(result)
        result
      end
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

    def random_cell(random)
      loop do
        row = random.rand(BOARD_SIZE)
        column = random.rand(BOARD_SIZE)
        cell = cell(row, column)
        return cell unless island_cells.include?(cell)
      end
    end

    def add_wall_after_column(row, column)
      cell(row, column).block(:left)
      cell(row, column + 1).block(:right)
    end

    def add_wall_after_row(row, column)
      cell(row, column).block(:up)
      cell(row + 1, column).block(:down)
    end

    def add_target(row, column, target)
      cell(row, column).target = target
    end

    private

    BOARD_SIZE = 16
    private_constant :BOARD_SIZE

    attr_reader :cells

    def each_cell
      return to_enum(:each_cell) unless block_given?

      cells.each { |row| row.each { |cell| yield cell } }
    end

    def add_center_island
      [6, 8].each do |i|
        [7, 8].each do |j|
          add_wall_after_row(i, j)
          add_wall_after_column(j, i)
        end
      end
    end

    def island_cells
      @island_cells ||= [cell(7, 7), cell(7, 8), cell(8, 7), cell(8, 8)]
    end

    def off_board?(row, column)
      !on_board?(row, column)
    end

    def on_board?(row, column)
      row.between?(top, bottom) && column.between?(left, right)
    end
  end
end
