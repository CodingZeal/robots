module Robots
  class Grid
    attr_reader :top, :left, :bottom, :right

    def initialize(size)
      @grid_size = size
      @top = 0
      @left = 0
      @bottom = @grid_size - 1
      @right = @grid_size - 1
      @elements = Array.new(size) do |row|
        Array.new(size) do |column|
          yield(row, column) if block_given?
        end
      end
    end

    def at(row, column)
      return nil unless on_grid?(row, column)

      elements[row][column]
    end

    def put(row, column, element)
      return unless on_grid?(row, column)

      elements[row][column] = element
    end

    def random_element(random)
      row = random.rand(grid_size)
      column = random.rand(grid_size)
      at(row, column)
    end

    def each_element
      return to_enum(:each_element) unless block_given?

      elements.each { |row| row.each { |element| yield element } }
    end

    def to_s
      elements.map { |row| row.map { |cell| cell ? cell.to_s : "X" }.join(" ") }.join("\n")
    end

    private

    attr_reader :grid_size, :elements

    def on_grid?(row, column)
      row.between?(top, bottom) && column.between?(left, right)
    end
  end
end
