module Robots
  module Solvers
    module Scorers
      class AStar
        def initialize(board, state)
          @board = board
          @active_robots = state.active_robots
          @estimates = Grid.new(board.size)
          populate_estimates(board.target_cell(state.goal))
        end

        def score(path)
          (path.length + best_estimate) * 10 + (last_robot_active?(path) ? 0 : 1)
        end

        private

        attr_reader :board, :active_robots, :estimates

        def best_estimate
          active_robots.map { |robot| estimate_at(robot.cell) }.min
        end

        def last_robot_active?(path)
          last_robot = path.last_moved_robot
          return false unless last_robot

          last_robot.active?(path.state.goal)
        end

        def populate_estimates(target_cell)
          fringe = [target_cell]
          estimate_put(target_cell, 0)
          while !fringe.empty?
            cell = fringe.shift
            estimate = estimate_at(cell) + 1
            # puts "Processing #{cell} with estimate #{estimate}"
            %i(up down left right).each do |direction|
              # puts "Moving #{direction}"
              stopping_cell = board.stopping_cell(cell, direction)
              # puts "Stopping cell is #{stopping_cell}"
              next if cell == stopping_cell

              cell.each_moving(direction).each do |neighbor|
                unless estimate_at(neighbor)
                  # puts "Setting #{neighbor} to #{estimate}"
                  estimate_put(neighbor, estimate)
                  fringe << neighbor
                end

                break if neighbor == stopping_cell
              end
            end
          end
        end

        def estimate_at(cell)
          estimates.at(cell.row, cell.column)
        end

        def estimate_put(cell, estimate)
          estimates.put(cell.row, cell.column, estimate)
        end
      end
    end
  end
end
