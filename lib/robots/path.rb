module Robots
  class Path
    attr_reader :state, :moves, :visited

    def self.initial(state, goal)
      new(state, goal)
    end

    private_class_method :new

    def initialize(state, goal, moves = [], visited = [])
      @state = state
      @goal = goal
      @moves = moves
      @visited = visited
    end

    def successor(direction)
      next_state = state.with_robot_moved(primary_robot, direction)
      next_state == state ? nil : self.class.successor(next_state, goal, moves + [direction], visited + [state])
    end

    def allowable_successors
      allowable_moves.map { |direction| successor(direction) }.compact.reject(&:cycle?)
    end

    def solved?
      game_over?(state) && moves.size > 1
    end

    def cycle?
      index = visited.find_index(state)
      index && index >= cycle_detection_start
    end

    def to_outcome
      solved? ? Outcome.solved(moves, state) : Outcome.no_solution(state)
    end

    # private
    def self.successor(state, goal, moves, visited)
      new(state, goal, moves, visited)
    end

    private

    attr_reader :goal

    def primary_robot
      state.robots.first
    end

    def allowable_moves
      case moves.last
        when :up, :down
          %i(left right)
        when :left, :right
          %i(up down)
        else
          %i(up down left right)
      end
    end

    def game_over?(state)
      state && state.game_over?(goal)
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
