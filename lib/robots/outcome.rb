module Robots
  class Outcome
    attr_reader :final_state

    def self.no_solution(final_state)
      new([], final_state)
    end

    def self.solved(moves, final_state)
      new(moves, final_state)
    end

    private_class_method :new

    def initialize(moves, final_state)
      @moves = moves
      @final_state = final_state
    end

    def length
      moves.size
    end

    def mission_accomplished?
      !moves.empty?
    end

    def write(io)
      if mission_accomplished?
        io.puts "Solved in #{length} moves:"
        moves.each_with_index do |move, index|
          io.puts "  #{index + 1}) #{move.capitalize}"
        end
      else
        io.puts "No solution found."
      end
    end

    private

    attr_reader :moves
  end
end
