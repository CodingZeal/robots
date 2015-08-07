module Robots
  module Solvers
    module Scorers
      class ShortestThenMRUFirst
        def score(path)
          (path.length * 100) + moves_since_last_move(path)
        end

        private

        def moves_since_last_move(path)
          last_robot = path.last_moved_robot
          moves = path.moves[0..-2]
          last_moved_index = moves.rindex { |move| move.for_robot?(last_robot) }
          last_moved_index ? moves.size - last_moved_index - 1 : 99
        end
      end
    end
  end
end
