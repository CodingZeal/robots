require_relative "move"
require_relative "outcome"

module Robots
  class Path
    attr_reader :state, :moves

    def self.initial(state)
      new(state)
    end

    private_class_method :new

    def initialize(state, moves = [])
      @state = state
      @moves = moves
    end

    def allowable_successors
      allowable_moves.map { |move| successor(move) }.compact
    end

    def successor(move)
      next_state = state.with_robot_moved(move.robot, move.direction)
      next_state.equal?(state) ? nil : self.class.successor(next_state, moves + [move])
    end

    def length
      moves.size
    end

    def last_moved_robot
      moves.last && moves.last.robot
    end

    def solved?
      game_over?(state) && ricocheted?(state.home_robot)
    end

    def to_outcome
      solved? ? Outcome.solved(moves, state) : Outcome.no_solution(state)
    end

    def to_s
      (moves.map { |move| [move.robot.color, move.direction] }).to_s
    end

    # private
    def self.successor(state, moves)
      new(state, moves)
    end

    private

    def allowable_moves
      state.robots.flat_map do |robot|
        (moves.last || Move.null).successors(robot)
      end
    end

    def game_over?(state)
      state && state.game_over?
    end

    def ricocheted?(robot)
      directions = moves.select { |move| move.for_robot?(robot) }.map(&:direction)
      (directions.include?(:up) || directions.include?(:down)) &&
        (directions.include?(:left) || directions.include?(:right))
    end
  end
end
