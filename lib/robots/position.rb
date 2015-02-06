require "equalizer"

module Robots
  class Position
    include Equalizer.new(:row, :column)

    attr_reader :row, :column

    def initialize(row:, column:)
      @row = row
      @column = column
    end

    def with_row(new_row)
      self.class.new(row: new_row, column: column)
    end

    def with_column(new_column)
      self.class.new(row: row, column: new_column)
    end
  end
end
