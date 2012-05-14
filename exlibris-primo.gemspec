$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "exlibris/primo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "exlibris-primo"
  s.version     = Exlibris::Primo::VERSION
  s.authors     = ["Scot Dalton"]
  s.email       = ["scotdalton@gmail.com"]
  s.homepage    = "https://github.com/scotdalton/exlibris-primo"
  s.summary     = "Library to work with Exlibris' Primo discovery system."
  s.description = "Library to work with Exlibris' Primo discovery system. Does not require Rails."

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # Leverage ActiveSupport's Hash#from_xml method to transform PNX to JSON.
  s.add_dependency "activesupport", "~> 3.2.0"
  s.add_dependency "nokogiri"
  s.add_dependency "json"
  s.add_dependency "soap4r-ruby1.9"
end
