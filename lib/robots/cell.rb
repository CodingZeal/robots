require "set"

module Robots
  class Cell
    attr_reader :row, :column
    attr_writer :target

    def initialize(board, row, column)
      @board = board
      @row = row
      @column = column
    end

    def block(directions)
    end

    def next_cell(direction, board_state = nil)
      stop = board.stopping_cell(self, direction)
      board_state.stopping_cell(self, stop)
    end

    def each_moving(direction)
      Enumerator.new do |yielder|
        cell = self
        loop do
          break if cell.nil?
          yielder << cell
          cell = cell.neighbor(direction)
        end
      end
    end

    def goal?(goal)
      target == goal
    end

    def between?(first, second)
      row_between?(first, second) || column_between?(first, second)
    end

    def neighbor_nearest(other_cell)
      if row == other_cell.row
        if column < other_cell.column
          right
        elsif column > other_cell.column
          left
        else
          nil
        end
      elsif column == other_cell.column
        if row < other_cell.row
          down
        elsif row > other_cell.row
          up
        else
          nil
        end
      else
        nil
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

    def target_into(array)
      array << target if target
    end

    def inspect
      "#<#{self.class.name}:#{object_id} row=#{row} column=#{column}>"
    end

    def to_s
      "row: #{row}, column: #{column}"
    end

    protected

    def neighbor(direction)
      send(direction)
    end

    private

    attr_reader :board, :target

    def column_between?(first, second)
      row == first.row && row == second.row &&
        (column.between?(first.column, second.column) || column.between?(second.column, first.column))
    end

    def row_between?(first, second)
      column == first.column && column == second.column &&
        (row.between?(first.row, second.row) || row.between?(second.row, first.row))
    end
  end
end
