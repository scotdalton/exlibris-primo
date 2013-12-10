source "http://rubygems.org"

# Declare your gem's dependencies in exlibris-primo.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'jruby-openssl', "~> 0.9.0", platform: :jruby

group :development do
  gem "ruby-debug", "~> 0.10.4", platform: :jruby
  gem "debugger", "~> 1.5.0", platform: :mri
end

group :test do
  gem "coveralls", "~> 0.7.0", :require => false
  gem "rake", "~> 10.1.0"
  gem "vcr", "~> 2.5.0"
  gem "webmock", "~> 1.13.0"
end

platforms :rbx do
  gem 'rubysl', '~> 2.0' # if using anything in the ruby standard library
  gem 'rubinius-coverage'
  gem 'rubysl-test-unit'
  gem "racc"
end
