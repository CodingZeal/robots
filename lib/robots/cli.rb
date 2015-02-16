module Robots
  class CLI
    def initialize(options)
      @options = options
      @board = Board.example
      @random = Random.new(seed)
    end

    def run(io = $stdout)
      io.puts "robots --seed #{seed}"

      state = BoardState.new(robot)

      if options.all
        run_all(state, io)
      elsif options.chain
        run_chained(state, io)
      else
        solve(state, options.goal, io)
      end
    end

    private

    def run_all(state, io)
      target_disks.each do |goal|
        solve(state, goal, io)
      end
    end

    def run_chained(state, io)
      target_disks.inject(state) do |next_state, goal|
        outcome = solve(next_state, goal, io)
        outcome.final_state
      end
    end

    def solve(state, goal, io)
      solver = solver_class.new(state, goal)

      io.puts "#{state}"
      io.puts "Attempting to solve for #{goal}"

      outcome = solver.outcome
      outcome.write(io)

      io.puts "Statistics:"
      solver.stats.each_pair do |key, value|
        io.puts "  #{key}: #{value}"
      end

      outcome
    end

    def target_disks
      board.targets.shuffle(random: random)
    end

    def robot
      @robot ||= Robot.new(:silver, start_cell)
    end

    def solver_class
      case options.algorithm
        when 'dfs'
          Solvers::Dfs
        else
          Solvers::Bfs
      end
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
