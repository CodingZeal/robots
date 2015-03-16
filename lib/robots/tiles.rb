require_relative "tile"

module Robots
  module Tiles
    def self.groups
      [[A1, A2, A3, A4], [B1, B2, B3, B4], [C1, C2, C3, C4], [D1, D2, D3, D4]]
    end

    def self.random_layout(random)
      groups.shuffle(random: random).map { |group| group.sample(random: random) }
    end

    # Green in new game
    A1 = Tile.new("A1",
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
       [5, 0],
       [6, 3]
     ]
    )

    A2 = Tile.new("A2",
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

    A3 = Tile.new("A3",
      targets: [
        [1, 3, :green, :triangle],
        [3, 6, :yellow, :hex],
        [4, 2, :red, :circle],
        [6, 4, :blue, :square]
      ],
      vertical_walls: [
        [0, 1],
        [1, 2],
        [3, 6],
        [4, 0],
        [6, 4]
      ],
      horizontal_walls: [
        [0, 3],
        [3, 6],
        [4, 1],
        [5, 4],
        [6, 0]
      ]
    )

    A4 = Tile.new("A4",
      targets: [
        [3, 1, :red, :circle],
        [4, 6, :yellow, :hex],
        [6, 2, :green, :triangle],
        [6, 3, :blue, :square]
      ],
      vertical_walls: [
        [0, 5],
        [3, 0],
        [4, 6],
        [6, 2]
      ],
      horizontal_walls: [
        [2, 1],
        [4, 6],
        [5, 0],
        [5, 2],
        [6, 3]
      ],
      diagonal_walls: [
        [1, 4, :green],
        [7, 5, :yellow]
      ]
    )

    # Blue in new game
    B1 = Tile.new("B1",
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

    B2 = Tile.new("B2",
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

    B3 = Tile.new("B3",
      targets: [
        [2, 3, :yellow, :circle],
        [3, 5, :blue, :triangle],
        [4, 2, :red, :square],
        [5, 4, :green, :hex]
      ],
      vertical_walls: [
        [0, 5],
        [2, 2],
        [3, 4],
        [4, 2],
        [5, 4]
      ],
      horizontal_walls: [
        [1, 3],
        [3, 0],
        [3, 2],
        [3, 5],
        [5, 4]
      ]
    )

    B4 = Tile.new("B4",
      targets: [
        [2, 5, :green, :hex],
        [2, 6, :yellow, :circle],
        [5, 1, :red, :square],
        [7, 4, :blue, :triangle]
      ],
      vertical_walls: [
        [0, 2],
        [2, 5],
        [5, 1],
        [7, 4]
      ],
      horizontal_walls: [
        [1, 6],
        [2, 5],
        [5, 1],
        [6, 0],
        [6, 4]
      ],
      diagonal_walls: [
        [1, 2, :blue],
        [4, 7, :red]
      ]
    )

    # Yellow in new game
    C1 = Tile.new("C1",
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

    C2 = Tile.new("C2",
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

    C3 = Tile.new("C3",
      targets: [
        [1, 5, :blue, :circle],
        [2, 7, :vortex],
        [4, 3, :red, :hex],
        [5, 6, :green, :square],
        [6, 1, :yellow, :triangle]
      ],
      vertical_walls: [
        [0, 2],
        [1, 4],
        [2, 7],
        [4, 3],
        [5, 6],
        [6, 1]
      ],
      horizontal_walls: [
        [1, 5],
        [2, 7],
        [3, 0],
        [4, 3],
        [4, 6],
        [5, 1]
      ]
    )

    C4 = Tile.new("C4",
      targets: [
        [2, 6, :yellow, :triangle],
        [3, 2, :blue, :circle],
        [3, 3, :green, :square],
        [5, 1, :red, :hex],
        [7, 5, :vortex]
      ],
      vertical_walls: [
        [0, 4],
        [2, 5],
        [3, 2],
        [5, 1],
        [7, 5]
      ],
      horizontal_walls: [
        [1, 6],
        [2, 2],
        [3, 3],
        [5, 1],
        [6, 0],
        [7, 5]
      ],
      diagonal_walls: [
        [1, 2, :red],
        [6, 3, :green]
      ]
    )

    # Red in new game
    D1 = Tile.new("D1",
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

    D2 = Tile.new("D2",
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

    D3 = Tile.new("D3",
      targets: [
        [1, 4, :green, :circle],
        [3, 1, :red, :triangle],
        [5, 5, :yellow, :square],
        [6, 3, :blue, :hex]
      ],
      vertical_walls: [
        [0, 1],
        [1, 4],
        [3, 0],
        [5, 4],
        [6, 3]
      ],
      horizontal_walls: [
        [0, 4],
        [3, 1],
        [4, 5],
        [5, 0],
        [6, 3]
      ]
    )

    D4 = Tile.new("D4",
      targets: [
        [2, 6, :blue, :hex],
        [4, 2, :green, :circle],
        [4, 3, :red, :triangle],
        [6, 5, :yellow, :square]
      ],
      vertical_walls: [
        [0, 4],
        [2, 6],
        [4, 2],
        [6, 4]
      ],
      horizontal_walls: [
        [2, 0],
        [2, 6],
        [3, 2],
        [4, 3],
        [5, 5]
      ],
      diagonal_walls: [
        [1, 4, :blue],
        [3, 6, :yellow]
      ]
    )
  end
end
