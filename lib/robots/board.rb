require_relative "cell"

module Robots
  class Board
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

    private

    BOARD_SIZE = 16
    private_constant :BOARD_SIZE

    attr_reader :cells

    def each_cell
      return to_enum(:each_cell) unless block_given?

      cells.each { |row| row.each { |cell| yield cell } }
    end

    def add_center_island
      (7..8).each do |row|
        (7..8).each do |column|
          cell(row, column).block(%i(up down left right))
        end
      end
    end

    def off_board?(row, column)
      !on_board?(row, column)
    end

    def on_board?(row, column)
      row.between?(top, bottom) && column.between?(left, right)
    end
  end
end
