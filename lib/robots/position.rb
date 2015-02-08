require "equalizer"

module Robots
  class Position
    include Equalizer.new(:row, :column)

    attr_reader :row, :column

    def self.[](row, column)
      new(row: row, column: column)
    end

    def initialize(row:, column:)
      @row = row
      @column = column
    end

    def each_moving(direction)
      Enumerator.new do |yielder|
        position = self
        loop do
          position = position.neighbor(direction)
          yielder << position
        end
      end
    end

    def with_row(new_row)
      self.class[new_row, column]
    end

    def with_column(new_column)
      self.class[row, new_column]
    end

    # Should be private, but can't be because of enumerator above
    def neighbor(direction)
      send(direction)
    end

    private

    def up
      with_row(row - 1)
    end

    def down
      with_row(row + 1)
    end

    def left
      with_column(column - 1)
    end

    def right
      with_column(column + 1)
    end
  end
end
