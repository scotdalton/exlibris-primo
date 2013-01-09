require 'test_helper'
class XmlUtilTest < Test::Unit::TestCase
  def test_to_xml
    assert_nothing_raised {
      record = Exlibris::Primo::Record.new(:raw_xml => "<record><control><recordid>123456</recordid></control></record>\n")
      assert_equal "<record><control><recordid>123456</recordid></control></record>", record.to_xml
    }
  end

  def test_to_hash
    assert_nothing_raised {
      record = Exlibris::Primo::Record.new(:raw_xml => "<record><control><recordid>123456</recordid></control></record>\n")
      assert_equal({"record"=> { "control" => { "recordid"=> "123456" } } }, record.to_hash)
    }
  end

  def test_to_json
    assert_nothing_raised {
      record = Exlibris::Primo::Record.new(:raw_xml => "<record><control><recordid>123456</recordid></control></record>\n")
      assert_equal "{\"record\":{\"control\":{\"recordid\":\"123456\"}}}", record.to_json
    }
  end
end