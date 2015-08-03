require_relative "move"
require_relative "outcome"

module Robots
  class Path
    attr_reader :state, :moves

    def self.initial(state)
      new(state)
    end

    # private
    def self.successor(state, moves, prunable)
      new(state, moves, prunable)
    end

    # private - tests only
    def initialize(state, moves = [], prunable = true)
      @state = state
      @moves = moves
      @solved = state.game_over? && ricocheted?(state.home_robot)
      @prunable = prunable && (solved? || !state.game_over?)
    end

    def allowable_successors
      allowable_moves.map { |move| successor(move) }.compact
    end

    def successor(move)
      next_state = state.with_robot_moved(move.robot, move.direction)
      next_state.equal?(state) ? nil : self.class.successor(next_state, moves + [move], prunable?)
    end

    def length
      moves.size
    end

    def last_moved_robot
      moves.last && moves.last.robot
    end

    def be_unprunable
      @prunable = false
    end

    def solved?
      @solved
    end

    def prunable?
      @prunable
    end

    def to_outcome
      solved? ? Outcome.solved(moves, state) : Outcome.no_solution(state)
    end

    def to_s
      (moves.map { |move| [move.robot.color, move.direction] }).to_s
    end

    private

    def allowable_moves
      state.robots.flat_map do |robot|
        (moves.last || Move.null).successors(robot)
      end
    end

    def ricocheted?(robot)
      directions = moves.select { |move| move.for_robot?(robot) }.map(&:direction)
      (directions.include?(:up) || directions.include?(:down)) &&
        (directions.include?(:left) || directions.include?(:right))
    end
  end
end
