require "equalizer"
require "set"

module Robots
  class BoardState
    include Equalizer.new(:robots, :goal)

    attr_reader :robots, :goal

    def initialize(robots, goal)
      @robots = Array(robots)
      @goal = goal
      ensure_active_robot_present
    end

    def with_robot_moved(robot, direction)
      moved_robot = robot.moved(direction, self)
      return self if moved_robot.equal?(robot)

      moved_robots = robots.map { |each_robot| each_robot.equal?(robot) ? moved_robot : each_robot }
      self.class.new(moved_robots, goal)
    end

    def with_goal(new_goal)
      self.class.new(robots.dup, new_goal)
    end

    def ensure_active_robot_first
      goal_index = robots.index { |robot| robot.active?(goal) }
      robots.rotate!(goal_index)
    end

    def stopping_cell(cell, stop)
      robots.inject(stop) do |result, robot|
        robot.cell != cell && robot.between?(cell, result) ? robot.neighbor_nearest(cell) : result
      end
    end

    def home_robot
      robots.find { |robot| robot.home?(goal) }
    end

    def game_over?
      !home_robot.nil?
    end

    def equivalence_class
      @equivalence_class ||= begin
        robots.map { |robot| robot.position_hash + (robot.active?(goal) ? 1000 : 0) }.sort!
      end
    end

    def to_command_line_args
      "#{robots_args} #{goal_args}"
    end

    def robots_args
      robots.map(&:to_command_line_args).join(" ")
    end

    def goal_args
      goal.to_command_line_args
    end

    def to_s
      "  " + robots.map(&:to_s).join("\n  ") + "\nAttempting to solve for #{goal}"
    end

    private

    def ensure_active_robot_present
      robots.unshift(robots.shift.with_color(goal.color)) unless robots.any? { |robot| robot.active?(goal) }
    end
  end
end
