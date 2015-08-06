module Robots
  module Solvers
    module Scorers
      class ShortestFirst
        def score(path)
          path.length
        end
      end
    end
  end
end
