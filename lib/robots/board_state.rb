require "equalizer"
require "set"

module Robots
  class BoardState
    include Equalizer.new(:robots)

    attr_reader :robots

    def initialize(robots)
      @robots = Array(robots)
    end

    def with_robot_moved(robot, direction)
      self.class.new(robots.map { |each_robot| each_robot == robot ? each_robot.moved(direction, self) : each_robot })
    end

    def ensure_goal_robot_first(goal)
      goal_index = robots.index { |robot| goal.matches_color?(robot.color) }
      robots.rotate!(goal_index)
    end

    def ensure_goal_robot_present(goal)
      new_color = (goal.color == :any) ? :silver : goal.color
      robots.unshift(robots.shift.with_color(new_color)) unless robots.any? { |r| r.color == new_color }
    end

    def stopping_cell(cell, stop)
      robots.inject(stop) do |result, robot|
        robot.cell != cell && robot.between?(cell, result) ? robot.neighbor_nearest(cell) : result
      end
    end

    def home_robot(goal)
      robots.find { |robot| robot.home?(goal) }
    end

    def game_over?(goal)
      !home_robot(goal).nil?
    end

    def to_s
      "  " + robots.map(&:to_s).join("\n  ")
    end
  end
end
