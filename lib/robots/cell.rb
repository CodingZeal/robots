require "set"

module Robots
  class Cell
    attr_reader :row, :column

    def self.open(board, row, column)
      Cell.new(board, row, column)
    end

    def self.closed(board, row, column)
      ClosedCell.new(board, row, column)
    end

    def initialize(board, row, column)
      @board = board
      @row = row
      @column = column
      @blocked = Set.new
    end

    def block(direction)
      blocked << direction
    end

    def blocked?(direction)
      blocked.include?(direction)
    end

    def next_cell(direction)
      board.next_cell(self, direction)
    end

    def each_moving(direction)
      Enumerator.new do |yielder|
        cell = self
        loop do
          cell = cell.neighbor(direction) if cell
          yielder << cell
        end
      end
    end

    def inspect
      "#<#{self.class.name}:#{object_id} row=#{row} column=#{column}"
    end

    protected

    def neighbor(direction)
      send(direction)
    end

    private

    attr_reader :board, :blocked

    def up
      board.cell(row - 1, column)
    end

    def down
      board.cell(row + 1, column)
    end

    def left
      board.cell(row, column - 1)
    end

    def right
      board.cell(row, column + 1)
    end
  end

  class ClosedCell < Cell
    def blocked?(_direction)
      true
    end
  end
end
