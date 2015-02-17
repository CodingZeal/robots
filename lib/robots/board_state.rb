require "equalizer"
require "set"

module Robots
  class BoardState
    include Equalizer.new(:robots)

    attr_reader :robots

    def initialize(robots)
      @robots = Array(robots).to_set
    end

    def with_robot_moved(robot, direction)
      self.class.new(robots.map { |each_robot| robot == each_robot ? each_robot.moved(direction) : each_robot} )
    end

    def game_over?(goal)
      robots.any? { |robot| robot.home?(goal) }
    end

    def to_s
      "Initial state:\n  " + robots.map(&:to_s).join("\n  ")
    end
  end
end
