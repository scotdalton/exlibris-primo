module WebService
  module Client
    require 'test_helper'
    class EshelfTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @doc_id = "nyu_aleph000062856"
        @user_id = "N12162279"
        @institution = "NYU"
      end

      def test_eshelf
        VCR.use_cassette('web service get eshelf request') do
          eshelf = Exlibris::Primo::WebService::Client::Eshelf.new @base_url
          response = eshelf.get_eshelf "<request><![CDATA[<getEshelfRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\"><institution>NYU</institution><userId>N12162279</userId></getEshelfRequest>]]></request>"
        end
      end
    end
  end
end