module Robots
  class Path
    attr_reader :robot, :moves, :visited

    def self.initial(state, goal)
      new(state, goal)
    end

    private_class_method :new

    def initialize(state, goal, moves = [], visited = [])
      @state = state
      @robot = state.robots.first
      @goal = goal
      @moves = moves
      @visited = visited
    end

    def successor(direction)
      next_robot = robot.moved(direction)
      next_robot == robot ? nil : self.class.successor(BoardState.new(next_robot), goal, moves + [direction], visited + [robot])
    end

    def allowable_successors
      allowable_moves.map { |direction| successor(direction) }.compact.reject(&:cycle?)
    end

    def solved?
      home?(robot) && moves.size > 1
    end

    def cycle?
      index = visited.find_index(robot)
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

    attr_reader :state, :goal

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

    def home?(robot)
      robot && robot.home?(goal)
    end

    def cycle_detection_start
      @cycle_detection_start ||= begin
        return 1 if home?(visited.first)
        return 2 if home?(visited[1])
        0
      end
    end
  end
end
