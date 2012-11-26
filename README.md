# Exlibris::Primo
[![Build Status](https://secure.travis-ci.org/scotdalton/exlibris-primo.png)](http://secure.travis-ci.org/scotdalton/exlibris-primo)
[![Dependency Status](https://gemnasium.com/scotdalton/exlibris-primo.png)](https://gemnasium.com/scotdalton/exlibris-primo)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/scotdalton/exlibris-primo)

Exlibris::Primo offers a set of classes for interacting with the ExLibris Primo APIs.

## Exlibris::Primo::Searcher
The Exlibris::Primo::Searcher class performs a search against Primo for given parameters
and exposes the set of holdings, fulltext links, table of contents links, and related links for each record retrieved.

### Example of Exlibris::Primo::Searcher in action
Searcher can search by a query

    searcher = Exlibris::Primo::Searcher.new(:base_url => "http://primo.institution.edu", 
      :vid => "VID", :institution => "INSTITUTION")
    searcher.add_query_term "0143039008", "isbn", "exact"
    count searcher.count
    facets = searcher.facets
    records = searcher.search.records
    records.each do |record|
      holdings = record.holdings
      fulltexts = record.fulltexts
      table_of_contents = record.table_of_contents
      related_links = record.related_links
    end

Or by a given record id

    searcher = Exlibris::Primo::Searcher.new(:base_url => "http://primo.institution.edu", 
      :vid => "VID", :institution => "INSTITUTION")
    searcher.record_id= "aleph0123456789"
    count = searcher.count
    facets = searcher.facets
    records = searcher.search.records
    records.each do |record|
      holdings = record.holdings
      fulltexts = record.fulltexts
      table_of_contents = record.table_of_contents
      related_links = record.related_links
    end

Searcher has some convenience methods for setting search params

    searcher = Exlibris::Primo::Searcher.new(:base_url => "http://primo.institution.edu", 
      :vid => "VID", :institution => "INSTITUTION")
    searcher.isbn = "0143039008" # Equivalent to searcher.add_query_term "0143039008", "isbn", "exact"
    searcher.title = "Travels with My Aunt" # Equivalent to searcher.add_query_term "Travels with My Aunt", "title", "exact"
    searcher.author = "Graham Greene" # Equivalent to searcher.add_query_term "Graham Greene", "creator", "exact"
    
Searcher also takes search elements in the initial hash

    searcher = Exlibris::Primo::Searcher.new(:base_url => "http://primo.institution.edu", 
      :vid => "VID", :institution => "INSTITUTION", :isbn = "0143039008")
Or  

    searcher = Exlibris::Primo::Searcher.new(:base_url => "http://primo.institution.edu", 
      :vid => "VID", :institution => "INSTITUTION", :record_id = "aleph0123456789")

    
## Exlibris::Primo::Record
Exlibris::Primo::Record is an object representation of a Primo record.

### Example of Exlibris::Primo::Record in action

    searcher = Exlibris::Primo::Searcher.new(:base_url => "http://primo.institution.edu", 
      :vid => "VID", :institution => "INSTITUTION")
    searcher.record_id= "aleph0123456789"
    count = searcher.count
    facets = searcher.facets
    records = searcher.search.records
    records.each do |record|
      holdings = record.holdings
      fulltexts = record.fulltexts
      table_of_contents = record.table_of_contents
      related_links = record.related_links
    end

## Exlibris::Primo::RemoteRecord
Exlibris::Primo::RemoteRecord is an object representation of a Primo record for the given record_id.

### Example of Exlibris::Primo::RemoteRecord in action

    remote_record = Exlibris::Primo::RemoteRecord.new "aleph0123456789", :base_url => @base_url, :institution => @institution
    holdings = remote_record.holdings
    fulltexts = remote_record.fulltexts
    table_of_contents = remote_record.table_of_contents
    related_links = remote_record.related_links

## Exlibris::Primo::Config
Exlibris::Primo::Config allows you to specify global configuration parameter for Exlibris::Primo

    Exlibris::Primo.configure do |config|
      config.base_url = "http://primo.institution.edu"
      config.vid = "VID"
      config.institution = "INSTITUTION"
      config.libraries = { "LIB_CODE1" => "Library Decoded 1", "LIB_CODE2" => "Library Decoded 2",
        "LIB_CODE3" => "Library Decoded 3" }
    end

Exlibris::Primo::Config can also read in from a YAML file that specifies the various config elements

    Exlibris::Primo.configure do |config|
      config.load_yaml "./config/primo.yml"
    end

## Exlibris::Primo::EShelf
The Exlibris::Primo::EShelf class provides methods for reading a given user's Primo eshelf and eshelf structure as well as adding and removing records.

## Example of Exlibris::Primo::EShelf in action
  eshelf = Exlibris::Primo::EShelf.new("USER_ID", :base_url => "http://primo.institution.edu", :vid => "VID", :insitution => "INSTITUTION")
  records = eshelf.records
  count = eshelf.count
  basket_id = eshelf.basket_id
  eshelf.add_records(["PrimoRecordId","PrimoRecordId2"], basket_id)
