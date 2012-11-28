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
  def assert_request_children(request, expected_root, &block)
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
      request_document.root.children.each do |sub_child|
        yield sub_child
      end
    end
  end
  protected :assert_request_children

  # Reversed expectation and actual because of ruby 1.8
  def assert_request(request, expected_root, *expected_args)
    document = Nokogiri::XML(request.to_xml)
    request_document = Nokogiri::XML(document.root.children.first.inner_text)
    assert_equal(request_document.root.children.size, expected_args.size)
    assert_request_children(request, expected_root) do |child|
      child_xml = xmlize(child)
      assert_equal expected_args.shift, child_xml
    end
  end
  protected :assert_request
  
  def xmlize(element)
    element.to_xml(
      :encoding => 'UTF-8',
      :indent => 0,
      :save_with => Nokogiri::XML::Node::SaveOptions::AS_XML | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION).strip
  end
end

