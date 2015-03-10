# Robots

This repo contains a solver for the
[Ricochet Robots](http://boardgamegeek.com/boardgame/51/ricochet-robots)
game.

It is the basis for my talk at
[Mountain West Ruby Conference 2015](http://mtnwestrubyconf.org/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'robots'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install robots

## Usage

The `robots` executable will solve Ricochet Robots using the
command-line options provided.  Currently, only a single fixed board
layout has been implemented.

There are three modes:

* `-g/--goal COLOR,SHAPE`: Solve for a single goal target.

* `-p/--play`: Play a simulated game of Ricochet Robots.  All 17 goal targets
  are solved in a random order.  Each goal will be solved starting
  from the ending positions after solving the previous goal.

* `-a/--all`: Solve all 17 goal targets in a random order, always starting
  from the same starting state.  Before each goal, all of the robots
  will be moved back to their initial positions.

Unless otherwise specified, all five robots will be placed at random
starting positions on the board.  This can be changed with the
following options:

* `-c/--count COUNT`: Use `COUNT` robots instead of the default five.
The program does not support more than five robots.

* `-r/--robot COLOR,ROW,COLUMN`: Place the `COLOR` robot at position
  (`ROW`, `COLUMN`).  Positions are 0-based starting from the upper
  right corner of the board.  This option can be used up to five
  times, for five robots.  If fewer `-r` options are specified than
  `COUNT` above, the remaining robots will be randomly placed on the
  board.

There are a couple of other options that are more useful for testing:

* `--algorithm ALGORITHM`: Specify the solving algorithm to be used.
  The default is the current best algorithm, `goal_first`, but you can
  also specify `bfs` to run the standard breadth-first solver.

* `--s/--seed SEED`: Use the specified value as the seed for the
  random-number generator.  This is most useful for repeating a
  previous game, which allows somewhat repeatable performance testing.

* `--v/--verbose`: Prints additional information about in-progress
  solutions while solving boards.

## Examples

### Play a Simulated Game

```ruby
bundle exec robots -p -c 5
```

### Re-play a Previous Game

When running `robots`, it prints out a seed value.  If you re-run the
game with the same options and provide the seed, it will re-play the
exact same game.

```ruby
bundle exec robots -p -c 5 --seed 4347
```

## Contributing

1. Fork it ( https://github.com/CodingZeal/robots/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
