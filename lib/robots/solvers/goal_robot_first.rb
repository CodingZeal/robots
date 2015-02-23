require_relative "bfs"

module Robots
  module Solvers
    class GoalRobotFirst < Bfs
      def initialize(*args)
        super
        initial_state.ensure_goal_robot_first
      end
    end
  end
end
