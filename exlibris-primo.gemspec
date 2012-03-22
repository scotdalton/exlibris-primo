$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "exlibris/primo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "exlibris-primo"
  s.version     = Exlibris::Primo::VERSION
  s.authors     = ["Scot Dalton"]
  s.email       = ["scotdalton@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "Library to work with Exlibris' Primo discovery system."
  s.description = "Library to work with Exlibris' Primo discovery system."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "nokogiri"
  s.add_dependency "soap4r-ruby1.9"

  s.add_development_dependency "sqlite3"
end
