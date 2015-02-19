require "equalizer"

module Robots
  class Move
    include Equalizer.new(:robot, :direction)

    attr_reader :robot, :direction

    def self.null
      new(nil, nil)
    end

    def initialize(robot, direction)
      @robot = robot
      @direction = direction
    end

    def successors(other_robot)
      allowable_directions(other_robot).map { |direction| self.class.new(other_robot, direction) }
    end

    def to_s
      "#{robot.color.to_s.capitalize} #{direction.to_s}"
    end

    private

    def allowable_directions(other_robot)
      return %i(up down left right) unless robot && robot.color == other_robot.color

      case direction
        when :up, :down
          %i(left right)
        when :left, :right
          %i(up down)
      end
    end
  end
end
