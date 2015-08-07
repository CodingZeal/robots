require_relative "board"
require_relative "board_state"
require_relative "robot"
require_relative "solvers"

module Robots
  class CLI
    def initialize(options)
      @options = options
      @board = Board.new
      @random = Random.new(seed)
    end

    def run(io = $stdout)
      io.puts "robots --seed #{seed}"
      io.puts "Tiles: #{tiles.join(" ")}"
      populate_board
      state = BoardState.new(robots, goal)

      if options.all
        run_all(state, io)
      elsif options.simulated_game
        play_simulated_game(state, io)
      else
        solve(state, io)
      end
    end

    private

    def populate_board
      BoardMaker.new(board).populate_with_tiles(tiles)
    end

    def tiles
      @tiles ||= if options.tiles
                   options.tiles.map do |tile_name|
                     Tiles.const_get(tile_name.upcase)
                   end
                 else
                   Tiles.random_layout(random)
                 end
    end

    def run_all(state, io)
      target_disks.each do |goal|
        solve(state.with_goal(goal), io)
      end
    end

    def play_simulated_game(state, io)
      target_disks.inject(state) do |next_state, goal|
        outcome = solve(next_state.with_goal(goal), io)
        outcome.final_state
      end
    end

    def solve(state, io)
      preamble(state, io)

      solver = make_solver(state)
      outcome = solver.outcome

      outcome.write(io)
      write_stats(solver.stats, io)

      io.puts "robots #{outcome.to_command_line_args}"

      outcome
    end

    def preamble(state, io)
      io.puts "*" * 50
      io.puts "Initial state:"
      io.puts "#{state}"
    end

    def write_stats(stats, io)
      io.puts "Statistics:"
      stats.each_pair do |key, value|
        io.puts "  #{key}: #{value}"
      end
    end

    def target_disks
      @target_disks ||= board.targets.shuffle(random: random)
    end

    def robots
      @robots ||= initialize_robots
    end

    def goal
      options.goal || target_disks.first
    end

    def initialize_robots
      remaining_colors = %i(green silver red blue yellow)

      result = options.robots.map do |color, (row, column)|
        remaining_colors.delete(color)
        Robot.new(color, board.cell(row, column))
      end

      remaining_count = [0, options.robot_count - result.size].max
      remaining_colors.first(remaining_count).each do |color|
        begin
          cell = board.random_cell(random)
        end while result.any? { |robot| robot.cell == cell }

        result << Robot.new(color, cell)
      end
      result
    end

    def make_solver(state)
      case options.algorithm
        when /best-(.+)/
          scorer = make_scorer($1, state)
          Solvers::BestFirst.new(state, scorer: scorer, verbose: options.algorithm)
        when "bfs"
          Solvers::Bfs.new(state, verbose: options.verbose)
        when "goal"
          Solvers::GoalRobotFirst.new(state, verbose: options.verbose)
        else
          Solvers::GoalRobotFirst.new(state, verbose: options.verbose)
      end
    end

    def make_scorer(description, state)
      case description
        when "a-star"
          Solvers::Scorers::AStar.new(board, state)
        when "shortest"
          Solvers::Scorers::ShortestFirst.new
        when "shortest-active"
          Solvers::Scorers::ShortestThenActiveFirst.new
        when "shortest-mru"
          Solvers::Scorers::ShortestThenMRUFirst.new
        else
          fail "Unknown scoring strategy: #{description}"
      end
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
