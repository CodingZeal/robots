module Robots
  class CLI
    def initialize(options)
      @options = options
      @board = Board.new
      BoardMaker.new(board).populate_example
    end

    def run(io = $stdout)
      if options.all
        run_all(io)
      else
        solve(options.goal, io)
      end
    end

    private

    def run_all(io)
      board.targets.shuffle.each do |target|
        solve(target, io)
      end
    end

    def solve(goal, io)
      robot = robot_for_goal(goal)
      solver = Solvers::RecursiveDfs.new(robot, goal)

      io.puts "Attempting to solve for #{goal}"

      solver.outcome.write(io)
    end

    def solver
      @solver ||= Solvers::RecursiveDfs.new(robot, goal)
    end

    def robot_for_goal(goal)
      color = (goal.color == :any) ? :silver : goal.color
      Robot.new(color, board.cell(6, 14))
    end

    attr_reader :options, :board
  end
end
