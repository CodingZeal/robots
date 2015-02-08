require "equalizer"

module Robots
  class Position
    include Equalizer.new(:row, :column)

    attr_reader :row, :column

    def initialize(row:, column:)
      @row = row
      @column = column
    end

    def each_above
      Enumerator.new do |yielder|
        position = self
        loop do
          position = position.up
          yielder << position
        end
      end
    end

    def each_below
      Enumerator.new do |yielder|
        position = self
        loop do
          position = position.down
          yielder << position
        end
      end
    end

    def with_row(new_row)
      self.class.new(row: new_row, column: column)
    end

    def with_column(new_column)
      self.class.new(row: row, column: new_column)
    end

    def up
      with_row(row - 1)
    end

    def down
      with_row(row + 1)
    end
  end
end
