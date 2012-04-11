require 'test_helper'
require 'nokogiri'
class RecordTest < ActiveSupport::TestCase
  
  SEAR_NS = {'sear' => 'http://www.exlibrisgroup.com/xsd/jaguar/search'}
  
  def setup
    @record_definition = YAML.load( %{
        base_url: http://bobcat.library.nyu.edu
        resolver_base_url: https://getit.library.nyu.edu/resolve
        vid: NYU
        institution: NYU
        record_id: nyu_aleph000062856
    })
      
    @base_url = @record_definition["base_url"]
    @resolver_base_url = @record_definition["resolver_base_url"]
    @vid = @record_definition["vid"]
    @institution = @record_definition["institution"]
    @valid_record_id = @record_definition["record_id"]
    @invalid_record_id = "INVALID_RECORD"
    @setup_args = { 
        :base_url => @base_url, 
        :resolver_base_url => @resolver_base_url, 
        :vid => @vid, 
        :institution => @institution, 
        :record_id => @valid_record_id 
      }
  end
  
  test "new" do
    record = nil
    assert_nothing_raised(){ record = Exlibris::Primo::Record.new(@setup_args) }
    assert_not_nil(record)
    assert_not_nil(record.instance_variable_get(:@record_id))
    assert_not_nil(record.instance_variable_get(:@type))
    assert_not_nil(record.instance_variable_get(:@title))
    assert_not_nil(record.instance_variable_get(:@url))
    assert_not_nil(record.instance_variable_get(:@openurl))
    assert_not_nil(record.instance_variable_get(:@creator))
    assert_not_nil(record.instance_variable_get(:@raw_xml))  
    assert_raise(ArgumentError){ Exlibris::Primo::Record.new(@setup_args.merge({:base_url => nil})) }
    assert_raise(ArgumentError){ Exlibris::Primo::Record.new(@setup_args.merge({:institution => nil})) }
    assert_raise(ArgumentError){ Exlibris::Primo::Record.new(@setup_args.merge({:vid => nil})) }
    assert_raise(ArgumentError){ Exlibris::Primo::Record.new(@setup_args.merge({:record_id => nil})) }
    assert_raise(RuntimeError){ Exlibris::Primo::Record.new(@setup_args.merge({:record_id => @invalid_record_id})) }
  end
  
  test "to_hash_function" do
    record = Exlibris::Primo::Record.new(@setup_args)
    assert((record.to_h.is_a? Hash), "#{record.class} was expected to be a Hash, was #{record.to_h.class}")
  end
  
  test "sub_class" do
    class SubRecord < Exlibris::Primo::Record
      def initialize(parameters={})
        super(parameters)
      end
    end
    record = nil
    assert_nothing_raised(){ record = SubRecord.new(@setup_args) }    
    assert_not_nil(record)
    assert_raise(ArgumentError){ record = SubRecord.new() }
  end
  
  test "raw_xml" do
    record = Exlibris::Primo::Record.new(@setup_args)
    raw_xml = record.instance_variable_get(:@raw_xml)
    assert_not_nil(raw_xml)  
    assert_instance_of(String, raw_xml)
    doc = nil
    assert_nothing_raised(){ doc = Nokogiri::XML.parse(raw_xml) }
    assert_not_nil(doc)
    assert_not_empty(doc.xpath("//record", doc.namespaces))
  end
  
end