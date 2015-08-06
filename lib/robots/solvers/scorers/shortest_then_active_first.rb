module Robots
  module Solvers
    module Scorers
      class ShortestThenActiveFirst
        def score(path)
          (path.length * 10) + (last_robot_active?(path) ? 0 : 1)
        end

        private

        def last_robot_active?(path)
          last_robot = path.last_moved_robot
          return false unless last_robot

          last_robot.active?(path.state.goal)
        end
      end
    end
  end
end
