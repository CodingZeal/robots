require_relative "tile"

module Robots
  module Tiles
    def self.groups
      [[A1, A2], [B1, B2], [C1, C2], [D1, D2]]
    end

    def self.random_layout(random)
      groups.shuffle(random).map { |group| group.sample(random) }
    end

    A1 = Tile.new(
     targets: [
       [1, 4, :red, :circle],
       [2, 1, :green, :triangle],
       [3, 6, :yellow, :hex],
       [6, 3, :blue, :square]
     ],
     vertical_walls: [
       [0, 1],
       [1, 3],
       [2, 1],
       [3, 6],
       [6, 2]
     ],
     horizontal_walls: [
       [0, 4],
       [1, 1],
       [3, 6],
       [6, 3]
     ]
    )

    A2 = Tile.new(
      targets: [
        [1, 6, :yellow, :hex],
        [2, 1, :green, :triangle],
        [5, 6, :blue, :square],
        [6, 3, :red, :circle]
      ],
      vertical_walls: [
        [0, 4],
        [1, 6],
        [2, 0],
        [5, 6],
        [6, 2]
      ],
      horizontal_walls: [
        [1, 1],
        [1, 6],
        [4, 6],
        [5, 0],
        [6, 3]
      ]
    )

    B1 = Tile.new(
      targets: [
        [1, 2, :yellow, :circle],
        [3, 6, :blue, :triangle],
        [5, 4, :red, :square],
        [6, 1, :green, :hex]
      ],
      vertical_walls: [
        [0, 4],
        [1, 1],
        [3, 5],
        [5, 4],
        [6, 1]
      ],
      horizontal_walls: [
        [0, 2],
        [3, 6],
        [4, 0],
        [4, 4],
        [6, 1]
      ]
    )

    B2 = Tile.new(
      targets: [
        [1, 5, :green, :hex],
        [2, 1, :red, :square],
        [4, 6, :yellow, :circle],
        [6, 2, :blue, :triangle]
      ],
      vertical_walls: [
        [0, 3],
        [1, 5],
        [2, 0],
        [4, 5],
        [6, 2]
      ],
      horizontal_walls: [
        [1, 5],
        [2, 1],
        [3, 0],
        [3, 6],
        [5, 2]
      ]
    )

    C1 = Tile.new(
      targets: [
        [1, 6, :blue, :circle],
        [3, 1, :yellow, :triangle],
        [4, 5, :green, :square],
        [5, 2, :red, :hex],
        [5, 7, :vortex]
      ],
      vertical_walls: [
        [0, 3],
        [1, 5],
        [3, 1],
        [4, 4],
        [5, 2],
        [5, 7]
      ],
      horizontal_walls: [
        [1, 6],
        [2, 1],
        [3, 5],
        [5, 2],
        [5, 7],
        [6, 0]
      ]
    )

    C2 = Tile.new(
      targets: [
        [1, 2, :red, :hex],
        [3, 1, :green, :square],
        [4, 6, :yellow, :triangle],
        [6, 5, :blue, :circle],
        [7, 3, :vortex]
      ],
      vertical_walls: [
        [0, 4],
        [1, 2],
        [3, 0],
        [4, 5],
        [6, 5],
        [7, 3]
      ],
      horizontal_walls: [
        [1, 2],
        [3, 1],
        [3, 6],
        [4, 0],
        [5, 5],
        [7, 3]
      ]
    )

    D1 = Tile.new(
      targets: [
        [1, 1, :red, :triangle],
        [2, 6, :green, :circle],
        [4, 2, :blue, :hex],
        [5, 7, :yellow, :square]
      ],
      vertical_walls: [
        [0, 3],
        [1, 0],
        [2, 6],
        [4, 2],
        [5, 6]
      ],
      horizontal_walls: [
        [1, 1],
        [1, 6],
        [4, 2],
        [4, 7],
        [5, 0]
      ]
    )

    D2 = Tile.new(
      targets: [
        [2, 5, :blue, :hex],
        [4, 2, :green, :circle],
        [5, 7, :red, :triangle],
        [6, 1, :yellow, :square]
      ],
      vertical_walls: [
        [0, 3],
        [2, 5],
        [4, 2],
        [5, 6],
        [6, 0]
      ],
      horizontal_walls: [
        [2, 5],
        [3, 2],
        [4, 0],
        [5, 1],
        [5, 7]
      ]
    )
  end
end
