require_relative "cell"

module Robots
  class Board
    def self.example
      self.new.tap { |board| BoardMaker.new(board).populate_example }
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

    private

    BOARD_SIZE = 16
    private_constant :BOARD_SIZE

    attr_reader :cells

    def each_cell
      return to_enum(:each_cell) unless block_given?

      cells.each { |row| row.each { |cell| yield cell } }
    end

    def add_center_island
      island_cells.each do |cell|
        cell.block(%i(up down left right))
      end
    end

    def island_cells
      @island_cells ||= begin
        (7..8).each_with_object([]) do |row, island|
          (7..8).each do |column|
            island << cell(row, column)
          end
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
