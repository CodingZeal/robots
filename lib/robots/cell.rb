require "set"

module Robots
  class Cell
    attr_reader :row, :column
    attr_writer :target

    def initialize(board, row, column)
      @board = board
      @row = row
      @column = column
      @blocked = Set.new
    end

    def block(directions)
      blocked.merge(Array(directions))
    end

    def next_cell(direction)
      each_moving(direction).each_cons(2) do |from, to|
        return from if to.nil? || to.blocked?(direction)
      end
    end

    def goal?(goal)
      target == goal
    end

    def inspect
      "#<#{self.class.name}:#{object_id} row=#{row} column=#{column}"
    end

    protected

    def neighbor(direction)
      send(direction)
    end

    def blocked?(direction)
      blocked.include?(direction)
    end

    private

    attr_reader :board, :blocked, :target

    def each_moving(direction)
      Enumerator.new do |yielder|
        cell = self
        loop do
          cell = cell.neighbor(direction) if cell
          yielder << cell
        end
      end
    end

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
end
