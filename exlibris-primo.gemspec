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

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rake", "~> 0.9.2.2"
  s.add_dependency "require_all", "~> 1.2.1"
  # Leverage ActiveSupport core extensions.
  s.add_dependency "activesupport", "~> 3.2.0"
  s.add_dependency "nokogiri", "~> 1.5.5"
  s.add_dependency "json", "~> 1.7.5"
  s.add_dependency "savon", "~> 1.2.0"
  s.add_dependency "iso-639", "~> 0.1.0"
  s.add_development_dependency "rdoc"
  s.add_development_dependency "vcr", "~> 2.3.0"
  s.add_development_dependency "webmock", "~> 1.8.0"
end
