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
  s.license     = 'MIT'

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "require_all", "~> 1.3.1"
  # Leverage ActiveSupport core extensions.
  s.add_dependency "activesupport", ">= 3.2.14"
  s.add_dependency "nokogiri", "~> 1.6.0"
  s.add_dependency "json", "~> 1.8.0"
  s.add_dependency "savon", "~> 2.8.0"
  s.add_dependency "iso-639", "~> 0.2.0"
  s.add_development_dependency "rake", "~> 10.1"
  s.add_development_dependency "vcr", "~> 2.9.0"
  s.add_development_dependency "webmock", "~> 1.20.0"
  s.add_development_dependency "pry", "~> 0.9.12.2"
  s.add_development_dependency 'minitest', '~> 4.7.5'
end
