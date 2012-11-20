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

class Test::Unit::TestCase
  def assert_request(expected_root, *expected_args, request)
    document = Nokogiri::XML(request.to_xml)
    assert_kind_of Nokogiri::XML::Document, document
    children = document.root.children
    assert_equal 1, children.size
    assert_equal "request", document.root.name
    children.each do |child|
      assert child.cdata?
      request_document = Nokogiri::XML(child.inner_text)
      assert_equal "http://www.exlibris.com/primo/xsd/wsRequest", request_document.namespaces["xmlns"]
      assert_equal "http://www.exlibris.com/primo/xsd/primoview/uicomponents", request_document.namespaces["xmlns:uic"]
      assert_equal expected_root, request_document.root.name
      assert_equal expected_args.size, request_document.root.children.size
      request_document.root.children.each do |child|
        child_xml = child.to_xml(
          :encoding => 'UTF-8',
          :indent => 0,
          :save_with => Nokogiri::XML::Node::SaveOptions::AS_XML | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION).strip
        assert_equal expected_args.shift, child_xml
      end
    end
  end
  protected :assert_request
end

