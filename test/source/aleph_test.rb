module Source
  require 'test_helper'
  class AlephTest < Test::Unit::TestCase
    def setup
      @record_id = "aleph002895625"
      @source_id = "aleph"
      @original_source_id = "USM01"
      @source_record_id = "002895625"
      @ils_api_id = "USM01002895625"
      @library_code = "LIB_CODE2"
      @collection = "Collection"
      @call_number = "(0123456789)"
    end

    def test_aleph_source
      reset_primo_configuration
      yaml_primo_configuration
      assert_nothing_raised {
        holding = Exlibris::Primo::Holding.new :record_id => @record_id, :original_id => @record_id,
          :source_id => @source_id, :original_source_id => @original_source_id, :source_record_id => @source_record_id,
          :ils_api_id => @ils_api_id, :library_code => @library_code, :collection => @collection, :call_number => @call_number,
          :availability_status_code => "available", :title => "Aleph Title", :author => "Aleph Author",
          :display_type => "Book"
        assert_not_nil holding.source_config
        assert_equal "LOCAL01", holding.source_config["local_base"]
        assert_equal "Aleph", holding.source_config["class_name"]
        assert_equal "Aleph", holding.source_class
        aleph = holding.to_source
        assert_kind_of Exlibris::Primo::Source::Aleph, aleph
        assert_equal "http://aleph.library.edu", aleph.aleph_url
        assert_equal "http://aleph.library.edu:1891/rest-dlf", aleph.aleph_rest_url
        assert_equal "AlephSubLibrary1", aleph.sub_library_code
        assert_equal "Library Decoded 2", aleph.sub_library
        assert_equal "LIB_CODE2", aleph.library_code
        assert_equal "Library Decoded 2", aleph.library
        assert_equal "LOCAL01", aleph.local_base
        assert_equal([aleph], aleph.expand)
        assert((not aleph.eql?(Exlibris::Primo::Source::Aleph.new)))
        assert_equal "http://aleph.library.edu/F?func=item-global"+
          "&doc_library=USM01&local_base=LOCAL01&doc_number=002895625"+
            "&sub_library=AlephSubLibrary1", aleph.url
        assert_equal "http://aleph.library.edu/F?func=item-global"+
          "&doc_library=USM01&local_base=LOCAL01&doc_number=002895625"+
            "&sub_library=AlephSubLibrary1", aleph.request_url
        assert_equal "http://aleph.library.edu:1891/rest-dlf/record/USM01002895625", aleph.rest_url
        holding.availability_status_code = "unavailable"
        aleph = holding.to_source
        assert_nil aleph.request_url
      }
    end
  end
end