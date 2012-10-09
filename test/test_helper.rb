require 'test/unit'
require File.expand_path("../../lib/exlibris-primo.rb",  __FILE__)

# VCR is used to 'record' HTTP interactions with
# third party services used in tests, and play em
# back. Useful for efficiency, also useful for
# testing code against API's that not everyone
# has access to -- the responses can be cached
# and re-used. 
require 'vcr'
require 'webmock'

# To allow us to do real HTTP requests in a VCR.turned_off, we
# have to tell webmock to let us. 
WebMock.allow_net_connect!(:net_http_connect_on_start => true)

without_ctx_tim = VCR.request_matchers.uri_without_param(:ctx_tim)
VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  # webmock needed for HTTPClient testing
  c.hook_into :webmock 
  c.register_request_matcher(:uri_without_ctx_tim, &without_ctx_tim)
  # c.debug_logger = $stderr
end

# Silly way to not have to rewrite all our tests if we
# temporarily disable VCR, make VCR.use_cassette a no-op
# instead of no-such-method. 
if ! defined? VCR
  module VCR
    def self.use_cassette(*args)
      yield
    end
  end
end

