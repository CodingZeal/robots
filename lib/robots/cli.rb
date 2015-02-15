module Robots
  class CLI
    def initialize(options)
      @options = options
      @board = Board.example
      @random = Random.new(seed)
    end

    def run(io = $stdout)
      io.puts "robots --seed #{seed}"

      if options.all
        run_all(robot, io)
      elsif options.chain
        run_chained(robot, io)
      else
        solve(robot, options.goal, io)
      end
    end

    private

    def run_all(robot, io)
      target_disks.each do |goal|
        solve(robot, goal, io)
      end
    end

    def run_chained(robot, io)
      target_disks.inject(robot) do |state, target|
        outcome = solve(state, target, io)
        outcome.final_state
      end
    end

    def solve(robot, goal, io)
      solver = Solvers::RecursiveDfs.new(robot, goal)

      io.puts "#{robot}"
      io.puts "Attempting to solve for #{goal}"

      solver.outcome.tap { |outcome| outcome.write(io) }
    end

    def target_disks
      board.targets.shuffle(random: random)
    end

    def robot
      @robot ||= Robot.new(:silver, start_cell)
    end

    def solver
      @solver ||= Solvers::RecursiveDfs.new(robot, goal)
    end

    def start_cell
      if options.start
        board.cell(*options.start)
      else
        board.random_cell(random)
      end
    end

    def robot_for_goal(goal)
      color = (goal.color == :any) ? :silver : goal.color
      Robot.new(color, board.cell(6, 14))
    end

    def seed
      options.seed ||= Random.new_seed.to_i % 0xFFFF
    end

    attr_reader :options, :board, :random
  end
end
