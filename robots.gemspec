# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'robots/version'

Gem::Specification.new do |spec|
  spec.name          = "robots"
  spec.version       = Robots::VERSION
  spec.authors       = ["Randy Coulman"]
  spec.email         = ["rcoulman@gmail.com"]
  spec.summary       = %q{Solver for Ricochet Robots game.}
  spec.description   = <<EOS
This is a solver for the [Ricochet Robots](http://boardgamegeek.com/boardgame/51/ricochet-robots) game.

It is the basis for my talk at [Mountain West Ruby Conference 2015](http://mtnwestrubyconf.org/).
EOS
  spec.homepage      = "http://randycoulman.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "equalizer", "~> 0.0.9"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "rspec", "~> 3.2"
end
