require_relative "tile"

module Robots
  module Tiles
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
  end
end
