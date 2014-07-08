require 'coveralls'
Coveralls.wear!
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

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  # webmock needed for HTTPClient testing
  c.hook_into :webmock
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

  def yaml_primo_configuration
    Exlibris::Primo.configure do |config|
      config.load_yaml File.expand_path("../support/config.yml",  __FILE__)
    end
  end

  def reset_primo_configuration
    Exlibris::Primo.configure do |config|
      config.base_url = nil
      config.institution = nil
      config.institutions = nil
      config.libraries = nil
      config.availability_statuses = nil
    end
  end
  protected :reset_primo_configuration

  def xmlize(element)
    element.to_xml(
      :encoding => 'UTF-8',
      :indent => 0,
      :save_with => Nokogiri::XML::Node::SaveOptions::AS_XML | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION).strip
  end

  def dedupmgr_record_xml
    "<record>"+
    "<control>"+
    "<sourcerecordid>$$V000932393$$Onyu_aleph000932393</sourcerecordid>"+
    "<sourcerecordid>$$V002959842$$Onyu_aleph002959842</sourcerecordid>"+
    "<sourceid>$$Vnyu_aleph$$Onyu_aleph000932393</sourceid>"+
    "<sourceid>$$Vnyu_aleph$$Onyu_aleph002959842</sourceid>"+
    "<recordid>dedupmrg17343091</recordid>"+
    "<originalsourceid>$$VNYU01$$Onyu_aleph000932393</originalsourceid>"+
    "<originalsourceid>$$VNYU01$$Onyu_aleph002959842</originalsourceid>"+
    "<sourceformat>$$VMARC21$$Onyu_aleph000932393</sourceformat>"+
    "<sourceformat>$$VMARC21$$Onyu_aleph002959842</sourceformat>"+
    "<sourcesystem>$$VAleph$$Onyu_aleph000932393</sourcesystem>"+
    "<sourcesystem>$$VAleph$$Onyu_aleph002959842</sourcesystem>"+
    "<ilsapiid>$$VNYU01000932393$$Onyu_aleph000932393</ilsapiid>"+
    "<ilsapiid>$$VNYU01002959842$$Onyu_aleph002959842</ilsapiid>"+
    "</control>"+
    "<display>"+
    "<type>journal</type>"+
    "<title>The New York times</title>"+
    "<publisher>New-York N.Y. : H.J. Raymond &amp; Co.</publisher>"+
    "<creationdate>1857-</creationdate>"+
    "<subject>New York (N.Y.) -- Newspapers; New York County (N.Y.) -- Newspapers; Electronic journals</subject>"+
    "<language>eng</language>"+
    "<relation>$$Cearlier_title $$VNew-York daily times</relation>"+
    "<rights>Access is restricted to users affiliated with licensed institutions.</rights>"+
    "<source>$$Vnyu_aleph$$Onyu_aleph000932393</source>"+
    "<source>$$Vnyu_aleph$$Onyu_aleph002959842</source>"+
    "<availlibrary>$$INYU$$LBWEB$$1Internet Resources$$2(Newspaper Electronic access )$$Scheck_holdings$$XNYU50$$YBWEB$$ZBNYUI$$Onyu_aleph000932393</availlibrary>"+
    "<availlibrary>$$INYU$$LBOBST$$1Microform$$2(Film/Per Non-circulating )$$Scheck_holdings$$5N$$XNYU50$$YBOBST$$ZMFORM$$Onyu_aleph002959842</availlibrary>"+
    "<availlibrary>$$ICU$$LCU$$1Microform Periodicals$$2(Non-circulating )$$Savailable$$31$$40$$5N$$60$$XNYU50$$YCU$$ZMICRP$$Onyu_aleph002959842</availlibrary>"+
    "<availlibrary>$$ICU$$LCU$$1Periodicals$$2(Non-circulating )$$Savailable$$31$$40$$5N$$60$$XNYU50$$YCU$$ZPERIO$$Onyu_aleph002959842</availlibrary>"+
    "<availlibrary>$$INYU$$LBWEB$$1Internet Resources$$2(Newspaper Electronic access )$$Scheck_holdings$$XNYU50$$YBWEB$$ZBNYUI$$Onyu_aleph002959842</availlibrary>"+
    "<availlibrary>$$INYU$$LREI$$1Reference$$2(Newspaper Non-circulating )$$Scheck_holdings$$XNYU50$$YNREI$$ZREF$$Onyu_aleph002959842</availlibrary>"+
    "<availlibrary>$$INS$$LNSSC$$1Periodicals$$2(Non-circulating )$$Scheck_holdings$$XNYU50$$YTNSSC$$ZPERIO$$Onyu_aleph002959842</availlibrary>"+
    "<availinstitution>$$ICU$$Savailable</availinstitution>"+
    "<availinstitution>$$INYU$$Scheck_holdings</availinstitution>"+
    "<availinstitution>$$INS$$Scheck_holdings</availinstitution>"+
    "<availpnx>available</availpnx>"+
    "<lds01>NYU</lds01>"+
    "<lds01>NYUAD</lds01>"+
    "<lds01>NYU</lds01>"+
    "<lds01>CU</lds01>"+
    "<lds01>NS</lds01>"+
    "<lds01>NYUAD</lds01>"+
    "<lds02>nyu_aleph000932393</lds02>"+
    "<lds02>nyu_aleph002959842</lds02>"+
    "</display>"+
    "<links>"+
    "<linktoholdings>$$V$$Taleph_holdings$$Onyu_aleph000932393</linktoholdings>"+
    "<linktoholdings>$$V$$Taleph_holdings$$Onyu_aleph002959842</linktoholdings>"+
    "<backlink>$$V$$Taleph_backlink$$DMore bibliographic information$$Onyu_aleph000932393</backlink>"+
    "<backlink>$$V$$Taleph_backlink$$DMore bibliographic information$$Onyu_aleph002959842</backlink>"+
    "<linktorsrc>$$V$$Uhttps://ezproxy.library.nyu.edu/login?url=http://proquest.umi.com/pqdweb?RQT=318&amp;VName=PQD&amp;clientid=9269&amp;pmid=7818$$D1995 - Current Access via Proquest$$INYU$$Onyu_aleph000932393</linktorsrc>"+
    "<linktorsrc>$$V$$Uhttps://ezproxy.library.nyu.edu/login?url=http://proquest.umi.com/pqdweb?RQT=318&amp;VName=PQD&amp;clientid=9269&amp;pmid=7818$$Elinktosrc_code$$INYUAD$$Onyu_aleph000932393</linktorsrc>"+
    "<linktorsrc>$$V$$Uhttps://ezproxy.library.nyu.edu/login?url=http://proquest.umi.com/pqdweb?RQT=318&amp;VName=PQD&amp;clientid=9269&amp;pmid=7818$$D1995 - Current Access via Proquest$$INYUAD$$Onyu_aleph000932393</linktorsrc>"+
    "<linktorsrc>$$V$$Uhttps://ezproxy.library.nyu.edu/login?url=http://www.nytimes.com/$$DOnline version:$$INYU$$Onyu_aleph002959842</linktorsrc>"+
    "<linktorsrc>$$V$$Uhttps://ezproxy.library.nyu.edu/login?url=http://www.nytimes.com/$$DOnline version:$$INYUAD$$Onyu_aleph002959842</linktorsrc>"+
    "<linktorsrc>$$V$$Uhttps://ezproxy.library.nyu.edu/login?url=http://web.lexis-nexis.com/universe$$DOnline access via Lexis-Nexis Academic Universe: Full-text available from 1980-$$INYU$$Onyu_aleph002959842</linktorsrc>"+
    "<linktorsrc>$$V$$Uhttps://ezproxy.library.nyu.edu/login?url=http://web.lexis-nexis.com/universe$$DOnline access via Lexis-Nexis Academic Universe: Full-text available from 1980-$$INYUAD$$Onyu_aleph002959842</linktorsrc>"+
    "<linktorsrc>$$V$$Uhttps://ezproxy.library.nyu.edu/login?url=http://www.umi.com/pqdauto$$DOnline access via ProQuest:$$INYU$$Onyu_aleph002959842</linktorsrc>"+
    "<linktorsrc>$$V$$Uhttps://ezproxy.library.nyu.edu/login?url=http://www.umi.com/pqdauto$$DOnline access via ProQuest:$$INYUAD$$Onyu_aleph002959842</linktorsrc>"+
    "<linktotoc>$$V$$Uhttps://ezproxy.library.nyu.edu/login?url=http://toc.example.com$$DExample TOC$$INYUAD$$Onyu_aleph002959842</linktotoc>"+
    "<addlink>$$V$$Uhttps://ezproxy.library.nyu.edu/login?url=http://addlink.example.com$$DExample Related Link$$INYUAD$$Onyu_aleph002959842</linktotoc>"+
    "<openurl>$$V$$Topenurl_journal$$Onyu_aleph000932393</openurl>"+
    "<openurl>$$V$$Topenurl_journal$$Onyu_aleph002959842</openurl>"+
    "<openurlfulltext>$$V$$Topenurlfull_journal$$Onyu_aleph000932393</openurlfulltext>"+
    "<openurlfulltext>$$V$$Topenurlfull_journal$$Onyu_aleph002959842</openurlfulltext>"+
    "<linktoreview>$$TpersistentUrl$$DCopy item link</linktoreview>"+
    "<linktouc>$$Tworldcat_oclc$$DCheck other libraries (WorldCat&#xAE;)</linktouc>"+
    "</links>"+
    "<search>"+
    "<creatorcontrib>Mellon Project.</creatorcontrib>"+
    "<creatorcontrib>ProQuest Information and Learning Company.</creatorcontrib>"+
    "<title>The New York times</title>"+
    "<subject>New York (N.Y.)  Newspapers</subject>"+
    "<subject>New York County (N.Y.)  Newspapers</subject>"+
    "<subject>Electronic journals</subject>"+
    "<subject>Niy&#x16B; Y&#x16B;rk (N.Y.)</subject>"+
    "<subject>Niu-y&#xFC;eh (N.Y.)</subject>"+
    "<subject>Nyuyok (N.Y.)</subject>"+
    "<subject>Nyu-Yor&#x1E33; (N.Y.)</subject>"+
    "<subject>New York City (N.Y.)</subject>"+
    "<subject>New Amsterdam (N.Y.)</subject>"+
    "<subject>Nu Yor&#x1E33; (N.Y.)</subject>"+
    "<subject>Nuyor&#x1E33; (N.Y.)</subject>"+
    "<subject>Novi Jork (N.Y.)</subject>"+
    "<subject>Nowy Jork (N.Y.)</subject>"+
    "<subject>Nova Iorque (N.Y.)</subject>"+
    "<subject>Ni&#x361;u &#x12C;ork (N.Y.)</subject>"+
    "<subject>Nueva York (N.Y.)</subject>"+
    "<general>H.J. Raymond &amp; Co.],</general>"+
    "<general>Latest issue consulted: Vol. 151, no. 52,028 (Feb. 13, 2002).</general>"+
    "<general>[electronic resource].</general>"+
    "<general>United States New York New York New York.</general>"+
    "<sourceid>nyu_aleph</sourceid>"+
    "<recordid>nyu_aleph000932393</recordid>"+
    "<isbn>0362-4331</isbn>"+
    "<rsrctype>journal</rsrctype>"+
    "<creationdate>1857</creationdate>"+
    "<creationdate>9999</creationdate>"+
    "<addtitle>New York times on the web.</addtitle>"+
    "<addtitle>New York times large type weekly</addtitle>"+
    "<addtitle>New-York semi-weekly times</addtitle>"+
    "<addtitle>New-York weekly times</addtitle>"+
    "<addtitle>Semi-weekly times (New York, N.Y.)</addtitle>"+
    "<addtitle>New York times on the Web</addtitle>"+
    "<addtitle>Little times</addtitle>"+
    "<addtitle>New-York daily times</addtitle>"+
    "<searchscope>BWEB</searchscope>"+
    "<searchscope>BWEB Internet Resources</searchscope>"+
    "<searchscope>nyu_aleph</searchscope>"+
    "<searchscope>NYU</searchscope>"+
    "<searchscope>NYUAD</searchscope>"+
    "<searchscope>BOBST</searchscope>"+
    "<searchscope>IFA</searchscope>"+
    "<searchscope>IFAC</searchscope>"+
    "<searchscope>ISAW</searchscope>"+
    "<searchscope>COUR</searchscope>"+
    "<searchscope>REI</searchscope>"+
    "<scope>BWEB</scope>"+
    "<scope>BWEB Internet Resources</scope>"+
    "<scope>nyu_aleph</scope>"+
    "<scope>NYU</scope>"+
    "<scope>NYUAD</scope>"+
    "<scope>BOBST</scope>"+
    "<scope>IFA</scope>"+
    "<scope>IFAC</scope>"+
    "<scope>ISAW</scope>"+
    "<scope>COUR</scope>"+
    "<scope>REI</scope>"+
    "<alttitle>Combined New York morning newspapers</alttitle>"+
    "<alttitle>Combined New York Sunday newspapers</alttitle>"+
    "<lsr01>Newspaper</lsr01>"+
    "<lsr02>H.J. Raymond &amp; Co.],</lsr02>"+
    "<title>The New York times.</title>"+
    "<subject>History</subject>"+
    "<subject>History  Africa</subject>"+
    "<subject>History  East Asia</subject>"+
    "<subject>History  Europe</subject>"+
    "<subject>History  Latin America and Caribbean</subject>"+
    "<subject>History  Middle East</subject>"+
    "<subject>History  North America</subject>"+
    "<subject>History  Slavic</subject>"+
    "<subject>Dance</subject>"+
    "<subject>Performing arts</subject>"+
    "<subject>Theater</subject>"+
    "<subject>Government information  New York State and City Recommended</subject>"+
    "<subject>Electronic indexes</subject>"+
    "<subject>Electronic newspapers</subject>"+
    "<subject>Dancing</subject>"+
    "<subject>Information, Government</subject>"+
    "<subject>Show business</subject>"+
    "<subject>Professional theater</subject>"+
    "<subject>Theatre</subject>"+
    "<subject>Dramatics</subject>"+
    "<recordid>nyu_aleph002959842</recordid>"+
    "<addtitle>New York semi-weekly times</addtitle>"+
    "<addtitle>New York times on the web</addtitle>"+
    "<searchscope>BOBST Microform</searchscope>"+
    "<searchscope>CU</searchscope>"+
    "<searchscope>CU Microform Periodicals</searchscope>"+
    "<searchscope>CU Periodicals</searchscope>"+
    "<searchscope>NREI</searchscope>"+
    "<searchscope>NREI Reference</searchscope>"+
    "<searchscope>TNSSC</searchscope>"+
    "<searchscope>TNSSC Periodicals</searchscope>"+
    "<searchscope>NS</searchscope>"+
    "<searchscope>NSSC</searchscope>"+
    "<searchscope>CPER</searchscope>"+
    "<scope>BOBST Microform</scope>"+
    "<scope>CU</scope>"+
    "<scope>CU Microform Periodicals</scope>"+
    "<scope>CU Periodicals</scope>"+
    "<scope>NREI</scope>"+
    "<scope>NREI Reference</scope>"+
    "<scope>TNSSC</scope>"+
    "<scope>TNSSC Periodicals</scope>"+
    "<scope>NS</scope>"+
    "<scope>NSSC</scope>"+
    "<scope>CPER</scope>"+
    "<alttitle>N.Y. times</alttitle>"+
    "<lsr01>Film/Per</lsr01>"+
    "</search>"+
    "<sort>"+
    "<title>New York times</title>"+
    "<creationdate>1857</creationdate>"+
    "<lso01>1857</lso01>"+
    "</sort>"+
    "<facets>"+
    "<language>eng</language>"+
    "<creationdate>1857</creationdate>"+
    "<topic>New York (N.Y.)&#x2013;Newspapers</topic>"+
    "<topic>New York County (N.Y.)&#x2013;Newspapers</topic>"+
    "<toplevel>available</toplevel>"+
    "<toplevel>online_resources</toplevel>"+
    "<prefilter>journals</prefilter>"+
    "<rsrctype>journals</rsrctype>"+
    "<genre>Newspapers</genre>"+
    "<genre>Electronic journals</genre>"+
    "<library>BOBST</library>"+
    "<library>IFA</library>"+
    "<library>IFAC</library>"+
    "<library>ISAW</library>"+
    "<library>COUR</library>"+
    "<library>REI</library>"+
    "<lfc01>Internet Resources</lfc01>"+
    "<lfc04>United States</lfc04>"+
    "<lfc04>New York</lfc04>"+
    "<lfc04>New York.</lfc04>"+
    "<topic>History</topic>"+
    "<topic>History&#x2013;Africa</topic>"+
    "<topic>History&#x2013;East Asia</topic>"+
    "<topic>History&#x2013;Europe</topic>"+
    "<topic>History&#x2013;Latin America and Caribbean</topic>"+
    "<topic>History&#x2013;Middle East</topic>"+
    "<topic>History&#x2013;North America</topic>"+
    "<topic>History&#x2013;Slavic</topic>"+
    "<topic>Dance</topic>"+
    "<topic>Performing arts</topic>"+
    "<topic>Theater</topic>"+
    "<topic>Government information&#x2013;New York State and City&#x2013;Recommended</topic>"+
    "<collection>BOBST</collection>"+
    "<collection>CU</collection>"+
    "<collection>NREI</collection>"+
    "<collection>NSSC</collection>"+
    "<genre>Electronic indexes</genre>"+
    "<genre>Electronic newspapers</genre>"+
    "<library>NSSC</library>"+
    "<library>CPER</library>"+
    "<lfc01>Microform</lfc01>"+
    "<lfc01>Microform Periodicals</lfc01>"+
    "<lfc01>Periodicals</lfc01>"+
    "<lfc01>Reference</lfc01>"+
    "<frbrgroupid>21490924</frbrgroupid>"+
    "<frbrtype>5</frbrtype>"+
    "</facets>"+
    "<dedup>"+
    "<t>2</t>"+
    "<c2>0362-4331</c2>"+
    "<c3>newyorktimes</c3>"+
    "<c4>new</c4>"+
    "<f4>0362-4331</f4>"+
    "<f6>1857</f6>"+
    "<f7>new york times</f7>"+
    "<f8>new york times</f8>"+
    "<f9>nyu</f9>"+
    "<f10>new</f10>"+
    "</dedup>"+
    "<frbr>"+
    "<t>1</t>"+
    "<k3>$$Knew york times$$AT</k3>"+
    "</frbr>"+
    "<delivery>"+
    "<institution>$$VNYU$$Onyu_aleph000932393</institution>"+
    "<institution>$$VNYUAD$$Onyu_aleph000932393</institution>"+
    "<delcategory>$$VOnline Resource$$Onyu_aleph000932393</delcategory>"+
    "<institution>$$VNYU$$Onyu_aleph002959842</institution>"+
    "<institution>$$VCU$$Onyu_aleph002959842</institution>"+
    "<institution>$$VNS$$Onyu_aleph002959842</institution>"+
    "<institution>$$VNYUAD$$Onyu_aleph002959842</institution>"+
    "<delcategory>$$VOnline Resource$$Onyu_aleph002959842</delcategory>"+
    "</delivery>"+
    "<enrichment>"+
    "<classificationlcc>Newspaper</classificationlcc>"+
    "</enrichment>"+
    "<ranking>"+
    "<booster1>1</booster1>"+
    "<booster2>1</booster2>"+
    "</ranking>"+
    "<addata>"+
    "<jtitle>The New York times</jtitle>"+
    "<addtitle>Combined New York morning newspapers</addtitle>"+
    "<date>1857</date>"+
    "<risdate>1857-</risdate>"+
    "<coden>NYTIAO</coden>"+
    "<format>journal</format>"+
    "<genre>journal</genre>"+
    "<ristype>JOUR</ristype>"+
    "<cop>New-York [N.Y.</cop>"+
    "<pub>H.J. Raymond &amp; Co.]</pub>"+
    "<lad01>BWEB</lad01>"+
    "<lad01>Online Resource</lad01>"+
    "<jtitle>The New York times.</jtitle>"+
    "<stitle>N.Y. times</stitle>"+
    "<issn>0362-4331</issn>"+
    "<oclcid>1645522</oclcid>"+
    "<lccn>sn 78004456</lccn>"+
    "<lad01>BOBSTBOBSTBWEBNREICUCUTNSSC</lad01>"+
    "</addata>"+
    "</record>"
  end

  def record_xml
    "<record>"+
    "<control>"+
    "<sourcerecordid>000062856</sourcerecordid>"+
    "<sourceid>nyu_aleph</sourceid>"+
    "<recordid>nyu_aleph000062856</recordid>"+
    "<originalsourceid>NYU01</originalsourceid>"+
    "<ilsapiid>NYU01000062856</ilsapiid>"+
    "<sourceformat>MARC21</sourceformat>"+
    "<sourcesystem>Aleph</sourcesystem>"+
    "</control>"+
    "<display>"+
    "<type>book</type>"+
    "<title>Travels with my aunt</title>"+
    "<creator>Graham  Greene  1904-1991.</creator>"+
    "<edition>Deluxe ed.</edition>"+
    "<publisher>New York : Penguin Books</publisher>"+
    "<creationdate>2004</creationdate>"+
    "<format>xvi, 254 p. ; 22 cm.</format>"+
    "<identifier>$$Cisbn$$V0143039008; $$Cisbn$$V9780143039006</identifier>"+
    "<subject>British -- Foreign countries -- Fiction; Women travelers -- Fiction; Older women -- Fiction; Travelers -- Fiction; Retirees -- Fiction; Aunts -- Fiction; Humorous stories</subject>"+
    "<language>eng</language>"+
    "<relation>$$Cseries $$VPenguin classics</relation>"+
    "<source>nyu_aleph</source>"+
    "<availlibrary>$$INYU$$LBOBST$$1Main Collection$$2(PR6013.R44 T7 2004 )$$Sunavailable$$31$$41$$5N$$61$$XNYU50$$YBOBST$$ZMAIN</availlibrary>"+
    "<lds02>nyu_aleph000062856</lds02>"+
    "<lds01>NYU</lds01>"+
    "<availinstitution>$$INYU$$Sunavailable</availinstitution>"+
    "<availpnx>unavailable</availpnx>"+
    "</display>"+
    "<links>"+
    "<openurl>$$Topenurl_journal</openurl>"+
    "<backlink>$$Taleph_backlink$$DMore bibliographic information</backlink>"+
    "<thumbnail>$$Tamazon_thumb</thumbnail>"+
    "<linktotoc>$$Tamazon_toc$$DCheck for Amazon Search Inside</linktotoc>"+
    "<openurlfulltext>$$Topenurlfull_journal</openurlfulltext>"+
    "<linktoholdings>$$Taleph_holdings</linktoholdings>"+
    "<linktoreview>$$TpersistentUrl$$DCopy item link</linktoreview>"+
    "<linktouc>$$Tamazon_uc$$DCheck Amazon</linktouc>"+
    "<linktouc>$$Tworldcat_isbn$$DCheck other libraries (WorldCat&#xAE;)</linktouc>"+
    "<linktoexcerpt>$$Tsyndetics_excerpt$$DExcerpt from item</linktoexcerpt>"+
    "</links>"+
    "<search>"+
    "<creatorcontrib>Graham,  Greene  1904-1991.</creatorcontrib>"+
    "<creatorcontrib>Greene, Graham, 1904-1991.</creatorcontrib>"+
    "<creatorcontrib>Greene, G</creatorcontrib>"+
    "<creatorcontrib>Graham Greene ; introduction by Gloria Emerson.</creatorcontrib>"+
    "<creatorcontrib>Greene, Henry Graham, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>G&#x16D;rin, G&#x16D;re&#x14F;m, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>Grin, Greham, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>Gr&#x12B;na, Gr&#x101;hama, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>Grin, Gr&#x117;m, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>&#x683C;&#x62C9;&#x59C6;&#x30FB;&#x845B;&#x6797;, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>Gr&#x12B;ns, Greiems, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>Gr&#x12B;ns, G. (Greiems), 1904-1991</creatorcontrib>"+
    "<title>Travels with my aunt /</title>"+
    "<subject>British  Foreign countries Fiction</subject>"+
    "<subject>Women travelers  Fiction</subject>"+
    "<subject>Older women  Fiction</subject>"+
    "<subject>Travelers  Fiction</subject>"+
    "<subject>Retirees  Fiction</subject>"+
    "<subject>Aunts  Fiction</subject>"+
    "<subject>Humorous stories</subject>"+
    "<subject>People, Retired</subject>"+
    "<subject>Retired persons</subject>"+
    "<subject>Retired people</subject>"+
    "<subject>Travelers, Women</subject>"+
    "<subject>Britishers</subject>"+
    "<subject>British people</subject>"+
    "<subject>Britons (British)</subject>"+
    "<subject>Brits</subject>"+
    "<subject>Aged women</subject>"+
    "<general>Penguin Books,</general>"+
    "<general>\"Graham Greene centennial, 1904-2004\"--Cover.</general>"+
    "<sourceid>nyu_aleph</sourceid>"+
    "<recordid>nyu_aleph000062856</recordid>"+
    "<isbn>0143039008</isbn>"+
    "<isbn>9780143039006</isbn>"+
    "<isbn>9780143&quot;0390069</isbn>"+
    "<rsrctype>book</rsrctype>"+
    "<creationdate>2004</creationdate>"+
    "<creationdate>1969</creationdate>"+
    "<addtitle>Penguin classics</addtitle>"+
    "<searchscope>BOBST</searchscope>"+
    "<searchscope>BOBST Main Collection</searchscope>"+
    "<searchscope>nyu_aleph</searchscope>"+
    "<searchscope>NYU</searchscope>"+
    "<scope>BOBST</scope>"+
    "<scope>BOBST Main Collection</scope>"+
    "<scope>nyu_aleph</scope>"+
    "<scope>NYU</scope>"+
    "<lsr01>PR6013.R44 T7 2004</lsr01>"+
    "<lsr01>PR6013 .R44 T7 2004</lsr01>"+
    "<lsr02>Penguin Books,</lsr02>"+
    "</search>"+
    "<sort>"+
    "<title>Travels with my aunt /</title>"+
    "<creationdate>2004</creationdate>"+
    "<author>Greene, Graham, 1904-1991.</author>"+
    "<lso01>2004</lso01>"+
    "</sort>"+
    "<facets>"+
    "<language>eng</language>"+
    "<creationdate>2004</creationdate>"+
    "<topic>British&#x2013;Foreign countries&#x2013;Fiction</topic>"+
    "<topic>Women travelers&#x2013;Fiction</topic>"+
    "<topic>Older women&#x2013;Fiction</topic>"+
    "<topic>Travelers&#x2013;Fiction</topic>"+
    "<topic>Retirees&#x2013;Fiction</topic>"+
    "<topic>Aunts&#x2013;Fiction</topic>"+
    "<collection>BOBST</collection>"+
    "<prefilter>books</prefilter>"+
    "<rsrctype>books</rsrctype>"+
    "<creatorcontrib>Greene, G</creatorcontrib>"+
    "<genre>Fiction</genre>"+
    "<genre>Humorous stories</genre>"+
    "<library>BOBST</library>"+
    "<lfc01>Main Collection</lfc01>"+
    "<classificationlcc>P - Language and literature.&#x2013;English literature</classificationlcc>"+
    "<frbrgroupid>49340863</frbrgroupid>"+
    "<frbrtype>5</frbrtype>"+
    "</facets>"+
    "<dedup>"+
    "<t>1</t>"+
    "<c1>2004559272</c1>"+
    "<c2>0143039008;9780143039006</c2>"+
    "<c3>travelswithmyaunt</c3>"+
    "<c4>2004</c4>"+
    "<f1>2004559272</f1>"+
    "<f3>0143039008;9780143039006</f3>"+
    "<f5>travelswithmyaunt</f5>"+
    "<f6>2004</f6>"+
    "<f7>travels with my aunt</f7>"+
    "<f8>nyu</f8>"+
    "<f9>xvi, 254 p. ;</f9>"+
    "<f10>penguin books</f10>"+
    "<f11>greene graham 1904 1991</f11>"+
    "</dedup>"+
    "<frbr>"+
    "<t>1</t>"+
    "<k1>$$Kgreene graham 1904 1991$$AA</k1>"+
    "<k3>$$Kbooktravels with my aunt$$AT</k3>"+
    "</frbr>"+
    "<delivery>"+
    "<institution>NYU</institution>"+
    "<delcategory>Physical Item</delcategory>"+
    "</delivery>"+
    "<enrichment>"+
    "<classificationlcc>PR6013.R44</classificationlcc>"+
    "</enrichment>"+
    "<ranking>"+
    "<booster1>1</booster1>"+
    "<booster2>1</booster2>"+
    "</ranking>"+
    "<addata>"+
    "<aulast>Greene</aulast>"+
    "<aufirst>Graham,</aufirst>"+
    "<au>Greene, Graham, 1904-1991</au>"+
    "<btitle>Travels with my aunt</btitle>"+
    "<seriestitle>Penguin classics</seriestitle>"+
    "<date>2004</date>"+
    "<risdate>2004.</risdate>"+
    "<isbn>0143039008</isbn>"+
    "<isbn>9780143039006</isbn>"+
    "<format>book</format>"+
    "<genre>book</genre>"+
    "<ristype>BOOK</ristype>"+
    "<notes>Includes bibliographical references (p. xv-xvi).</notes>"+
    "<cop>New York</cop>"+
    "<pub>Penguin Books</pub>"+
    "<oclcid>56781200</oclcid>"+
    "<lccn>2004559272</lccn>"+
    "<lad01>BOBST</lad01>"+
    "<lad01>Physical Item</lad01>"+
    "</addata>"+
    "</record>"
  end

  def record_other_source_xml
    File.read(File.expand_path("../xml/record_other_sourcesystem.xml",  __FILE__))
  end

  def record_invalid_frbr_xml
    "<record>"+
    "<control>"+
    "<sourcerecordid>000062856</sourcerecordid>"+
    "<sourceid>nyu_aleph</sourceid>"+
    "<recordid>nyu_aleph000062856</recordid>"+
    "<originalsourceid>NYU01</originalsourceid>"+
    "<ilsapiid>NYU01000062856</ilsapiid>"+
    "<sourceformat>MARC21</sourceformat>"+
    "<sourcesystem>Aleph</sourcesystem>"+
    "</control>"+
    "<display>"+
    "<type>book</type>"+
    "<title>Travels with my aunt</title>"+
    "<creator>Graham  Greene  1904-1991.</creator>"+
    "<edition>Deluxe ed.</edition>"+
    "<publisher>New York : Penguin Books</publisher>"+
    "<creationdate>2004</creationdate>"+
    "<format>xvi, 254 p. ; 22 cm.</format>"+
    "<identifier>$$Cisbn$$V0143039008; $$Cisbn$$V9780143039006</identifier>"+
    "<subject>British -- Foreign countries -- Fiction; Women travelers -- Fiction; Older women -- Fiction; Travelers -- Fiction; Retirees -- Fiction; Aunts -- Fiction; Humorous stories</subject>"+
    "<language>eng</language>"+
    "<relation>$$Cseries $$VPenguin classics</relation>"+
    "<source>nyu_aleph</source>"+
    "<availlibrary>$$INYU$$LBOBST$$1Main Collection$$2(PR6013.R44 T7 2004 )$$Sunavailable$$31$$41$$5N$$61$$XNYU50$$YBOBST$$ZMAIN</availlibrary>"+
    "<lds02>nyu_aleph000062856</lds02>"+
    "<lds01>NYU</lds01>"+
    "<availinstitution>$$INYU$$Sunavailable</availinstitution>"+
    "<availpnx>unavailable</availpnx>"+
    "</display>"+
    "<links>"+
    "<openurl>$$Topenurl_journal</openurl>"+
    "<backlink>$$Taleph_backlink$$DMore bibliographic information</backlink>"+
    "<thumbnail>$$Tamazon_thumb</thumbnail>"+
    "<linktotoc>$$Tamazon_toc$$DCheck for Amazon Search Inside</linktotoc>"+
    "<openurlfulltext>$$Topenurlfull_journal</openurlfulltext>"+
    "<linktoholdings>$$Taleph_holdings</linktoholdings>"+
    "<linktoreview>$$TpersistentUrl$$DCopy item link</linktoreview>"+
    "<linktouc>$$Tamazon_uc$$DCheck Amazon</linktouc>"+
    "<linktouc>$$Tworldcat_isbn$$DCheck other libraries (WorldCat&#xAE;)</linktouc>"+
    "<linktoexcerpt>$$Tsyndetics_excerpt$$DExcerpt from item</linktoexcerpt>"+
    "</links>"+
    "<search>"+
    "<creatorcontrib>Graham,  Greene  1904-1991.</creatorcontrib>"+
    "<creatorcontrib>Greene, Graham, 1904-1991.</creatorcontrib>"+
    "<creatorcontrib>Greene, G</creatorcontrib>"+
    "<creatorcontrib>Graham Greene ; introduction by Gloria Emerson.</creatorcontrib>"+
    "<creatorcontrib>Greene, Henry Graham, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>G&#x16D;rin, G&#x16D;re&#x14F;m, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>Grin, Greham, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>Gr&#x12B;na, Gr&#x101;hama, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>Grin, Gr&#x117;m, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>&#x683C;&#x62C9;&#x59C6;&#x30FB;&#x845B;&#x6797;, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>Gr&#x12B;ns, Greiems, 1904-1991</creatorcontrib>"+
    "<creatorcontrib>Gr&#x12B;ns, G. (Greiems), 1904-1991</creatorcontrib>"+
    "<title>Travels with my aunt /</title>"+
    "<subject>British  Foreign countries Fiction</subject>"+
    "<subject>Women travelers  Fiction</subject>"+
    "<subject>Older women  Fiction</subject>"+
    "<subject>Travelers  Fiction</subject>"+
    "<subject>Retirees  Fiction</subject>"+
    "<subject>Aunts  Fiction</subject>"+
    "<subject>Humorous stories</subject>"+
    "<subject>People, Retired</subject>"+
    "<subject>Retired persons</subject>"+
    "<subject>Retired people</subject>"+
    "<subject>Travelers, Women</subject>"+
    "<subject>Britishers</subject>"+
    "<subject>British people</subject>"+
    "<subject>Britons (British)</subject>"+
    "<subject>Brits</subject>"+
    "<subject>Aged women</subject>"+
    "<general>Penguin Books,</general>"+
    "<general>\"Graham Greene centennial, 1904-2004\"--Cover.</general>"+
    "<sourceid>nyu_aleph</sourceid>"+
    "<recordid>nyu_aleph000062856</recordid>"+
    "<isbn>0143039008</isbn>"+
    "<isbn>9780143039006</isbn>"+
    "<isbn>9780143&quot;0390069</isbn>"+
    "<rsrctype>book</rsrctype>"+
    "<creationdate>2004</creationdate>"+
    "<creationdate>1969</creationdate>"+
    "<addtitle>Penguin classics</addtitle>"+
    "<searchscope>BOBST</searchscope>"+
    "<searchscope>BOBST Main Collection</searchscope>"+
    "<searchscope>nyu_aleph</searchscope>"+
    "<searchscope>NYU</searchscope>"+
    "<scope>BOBST</scope>"+
    "<scope>BOBST Main Collection</scope>"+
    "<scope>nyu_aleph</scope>"+
    "<scope>NYU</scope>"+
    "<lsr01>PR6013.R44 T7 2004</lsr01>"+
    "<lsr01>PR6013 .R44 T7 2004</lsr01>"+
    "<lsr02>Penguin Books,</lsr02>"+
    "</search>"+
    "<sort>"+
    "<title>Travels with my aunt /</title>"+
    "<creationdate>2004</creationdate>"+
    "<author>Greene, Graham, 1904-1991.</author>"+
    "<lso01>2004</lso01>"+
    "</sort>"+
    "<facets>"+
    "<language>eng</language>"+
    "<creationdate>2004</creationdate>"+
    "<topic>British&#x2013;Foreign countries&#x2013;Fiction</topic>"+
    "<topic>Women travelers&#x2013;Fiction</topic>"+
    "<topic>Older women&#x2013;Fiction</topic>"+
    "<topic>Travelers&#x2013;Fiction</topic>"+
    "<topic>Retirees&#x2013;Fiction</topic>"+
    "<topic>Aunts&#x2013;Fiction</topic>"+
    "<collection>BOBST</collection>"+
    "<prefilter>books</prefilter>"+
    "<rsrctype>books</rsrctype>"+
    "<creatorcontrib>Greene, G</creatorcontrib>"+
    "<genre>Fiction</genre>"+
    "<genre>Humorous stories</genre>"+
    "<library>BOBST</library>"+
    "<lfc01>Main Collection</lfc01>"+
    "<classificationlcc>P - Language and literature.&#x2013;English literature</classificationlcc>"+
    "<frbrgroupid>49340863</frbrgroupid>"+
    "<frbrtype>6</frbrtype>"+
    "</facets>"+
    "<dedup>"+
    "<t>1</t>"+
    "<c1>2004559272</c1>"+
    "<c2>0143039008;9780143039006</c2>"+
    "<c3>travelswithmyaunt</c3>"+
    "<c4>2004</c4>"+
    "<f1>2004559272</f1>"+
    "<f3>0143039008;9780143039006</f3>"+
    "<f5>travelswithmyaunt</f5>"+
    "<f6>2004</f6>"+
    "<f7>travels with my aunt</f7>"+
    "<f8>nyu</f8>"+
    "<f9>xvi, 254 p. ;</f9>"+
    "<f10>penguin books</f10>"+
    "<f11>greene graham 1904 1991</f11>"+
    "</dedup>"+
    "<frbr>"+
    "<t>1</t>"+
    "<k1>$$Kgreene graham 1904 1991$$AA</k1>"+
    "<k3>$$Kbooktravels with my aunt$$AT</k3>"+
    "</frbr>"+
    "<delivery>"+
    "<institution>NYU</institution>"+
    "<delcategory>Physical Item</delcategory>"+
    "</delivery>"+
    "<enrichment>"+
    "<classificationlcc>PR6013.R44</classificationlcc>"+
    "</enrichment>"+
    "<ranking>"+
    "<booster1>1</booster1>"+
    "<booster2>1</booster2>"+
    "</ranking>"+
    "<addata>"+
    "<aulast>Greene</aulast>"+
    "<aufirst>Graham,</aufirst>"+
    "<au>Greene, Graham, 1904-1991</au>"+
    "<btitle>Travels with my aunt</btitle>"+
    "<seriestitle>Penguin classics</seriestitle>"+
    "<date>2004</date>"+
    "<risdate>2004.</risdate>"+
    "<isbn>0143039008</isbn>"+
    "<isbn>9780143039006</isbn>"+
    "<format>book</format>"+
    "<genre>book</genre>"+
    "<ristype>BOOK</ristype>"+
    "<notes>Includes bibliographical references (p. xv-xvi).</notes>"+
    "<cop>New York</cop>"+
    "<pub>Penguin Books</pub>"+
    "<oclcid>56781200</oclcid>"+
    "<lccn>2004559272</lccn>"+
    "<lad01>BOBST</lad01>"+
    "<lad01>Physical Item</lad01>"+
    "</addata>"+
    "</record>"
  end
end

