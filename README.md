# Robots

This repo contains a solver for the [Ricochet Robots](http://boardgamegeek.com/boardgame/51/ricochet-robots) game.

It is the basis for my talk at [Mountain West Ruby Conference 2015](http://mtnwestrubyconf.org/).

**This is under active development and is likely to change drastically as I prepare the talk.
I reserve the right to force push to this repo without notice, so clone at your own risk.**

Once everything has stabilized, I'll maintain this repo in a much friendlier manner.


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

TODO: Write usage instructions here

## Examples

These are currently here as notes for myself.

### Play a Simulated Game

```ruby
bundle exec robots -p -c 2
```

### Not Solvable in a Reasonable Time

```ruby
be robots -g blue,circle -r blue,14,1 -r silver,0,0
```

### Watch for Cheating

```ruby
be robots -g red,triangle -r red,2,1 -r silver,4,0
```

## Contributing

1. Fork it ( https://github.com/randycoulman/robots/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
