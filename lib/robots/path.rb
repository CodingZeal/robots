module Robots
  class Path
    attr_reader :state, :moves

    def self.initial(state, goal)
      new(state, goal)
    end

    private_class_method :new

    def initialize(state, goal, moves = [])
      @state = state
      @goal = goal
      @moves = moves
    end

    def allowable_successors
      allowable_moves.map { |move| successor(move) }.compact
    end

    def successor(move)
      next_state = state.with_robot_moved(move.robot, move.direction)
      next_state == state ? nil : self.class.successor(next_state, goal, moves + [move])
    end

    def solved?
      game_over?(state) && ricocheted?(state.home_robot(goal))
    end

    def to_outcome
      solved? ? Outcome.solved(moves, state) : Outcome.no_solution(state)
    end

    # private
    def self.successor(state, goal, moves)
      new(state, goal, moves)
    end

    private

    attr_reader :goal

    def allowable_moves
      state.robots.flat_map do |robot|
        (moves.last || Move.null).successors(robot)
      end
    end

    def game_over?(state)
      state && state.game_over?(goal)
    end

    def ricocheted?(robot)
      directions = moves.select { |move| move.for_robot?(robot) }.map(&:direction)
      (directions.include?(:up) || directions.include?(:down)) &&
        (directions.include?(:left) || directions.include?(:right))
    end

    def cycle_detection_start
      @cycle_detection_start ||= begin
        return 1 if game_over?(visited.first)
        return 2 if game_over?(visited[1])
        0
      end
    end
  end
end
