module Robots
  class CLI
    def initialize(options)
      @options = options
      @board = Board.example
      @random = Random.new(seed)
    end

    def run(io = $stdout)
      io.puts "robots --seed #{seed}"

      state = BoardState.new(robots)

      if options.all
        run_all(state, io)
      elsif options.simulated_game
        play_simulated_game(state, io)
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

    def play_simulated_game(state, io)
      target_disks.inject(state) do |next_state, goal|
        next_state.ensure_goal_robot_present(goal)
        outcome = solve(next_state, goal, io)
        outcome.final_state
      end
    end

    def solve(state, goal, io)
      preamble(state, goal, io)

      solver = solver_class.new(state, goal)
      outcome = solver.outcome

      outcome.write(io)
      write_stats(solver.stats, io)

      outcome
    end

    def preamble(state, goal, io)
      io.puts "*" * 50
      io.puts "Initial state:"
      io.puts "#{state}"
      io.puts "Attempting to solve for #{goal}"
    end

    def write_stats(stats, io)
      io.puts "Statistics:"
      stats.each_pair do |key, value|
        io.puts "  #{key}: #{value}"
      end
    end

    def target_disks
      board.targets.shuffle(random: random)
    end

    def robots
      @robots ||= initialize_robots
    end

    def initialize_robots
      remaining_colors = %i(green silver red blue yellow)

      result = options.robots.map do |color, (row, column)|
        remaining_colors.delete(color)
        Robot.new(color, board.cell(row, column))
      end

      remaining_count = [0, options.robot_count - result.size].max
      remaining_colors.first(remaining_count).each do |color|
        result << Robot.new(color, board.random_cell(random))
      end
      result
    end

    def solver_class
      Solvers::Bfs
    end

    def start_cell
      if options.start
        board.cell(*options.start)
      else
        board.random_cell(random)
      end
    end

    def seed
      options.seed ||= Random.new_seed.to_i % 0xFFFF
    end

    attr_reader :options, :board, :random
  end
end
