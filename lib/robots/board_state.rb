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

    def adjust_robots_for_goal(goal)
      new_color = (goal.color == :any) ? :silver : goal.color
      robots.unshift(robots.shift.with_color(new_color)) unless robots.any? { |r| r.color == new_color }
    end

    def blocked?(cell)
      robots.any? { |robot| robot.cell == cell }
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
