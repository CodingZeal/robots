module Robots
  class CLI
    def initialize(options)
      @options = options
      @board = Board.new
      BoardMaker.new(board).populate_example
    end

    def run(io = $stdout)
      if solver.solved?
        io.puts "Solved in #{solver.solution.size} moves:"
        solver.solution.each_with_index do |move, index|
          io.puts "  #{index + 1}) #{move.capitalize}"
        end
      else
        io.puts "No solution found."
      end
    end

    private

    def solver
      @solver ||= Solvers::RecursiveDfs.new(robot, goal)
    end

    def goal
      options.goal
    end

    def robot
      @robot ||= begin
        color = (goal.color == :any) ? :silver : goal.color
        Robot.new(color, board.cell(6, 14))
      end
    end

    attr_reader :options, :board
  end
end
