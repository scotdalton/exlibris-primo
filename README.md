# Exlibris::Primo
[![Build Status](https://secure.travis-ci.org/scotdalton/exlibris-primo.png)](http://secure.travis-ci.org/scotdalton/exlibris-primo)
[![Dependency Status](https://gemnasium.com/scotdalton/exlibris-primo.png)](https://gemnasium.com/scotdalton/exlibris-primo)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/scotdalton/exlibris-primo)

Exlibris::Primo offers a set of classes for interacting with the ExLibris Primo APIs.

## Exlibris::Primo::Search
The Exlibris::Primo::Search class performs a search against Primo for given parameters
and exposes the set of holdings, fulltext links, table of contents links, and related links for each record retrieved.

### Example of Exlibris::Primo::Search in action
Search can search by a query

    search = Exlibris::Primo::Search.new(:base_url => "http://primo.institution.edu", 
      :institution => "INSTITUTION")
    search.add_query_term "0143039008", "isbn", "exact"
    count search.count
    facets = search.facets
    records = search.search.records
    records.each do |record_id, record|
      holdings = record.holdings
      fulltexts = record.fulltexts
      table_of_contents = record.table_of_contents
      related_links = record.related_links
    end

Or by a given record id

    search = Exlibris::Primo::Search.new(:base_url => "http://primo.institution.edu", 
      :institution => "INSTITUTION")
    search.record_id= "aleph0123456789"
    count = search.count
    facets = search.facets
    records = search.search.records
    records.each do |record_id, record|
      holdings = record.holdings
      fulltexts = record.fulltexts
      table_of_contents = record.table_of_contents
      related_links = record.related_links
    end

Search has some convenience methods for setting search params

    search = Exlibris::Primo::Search.new(:base_url => "http://primo.institution.edu", 
      :institution => "INSTITUTION")
    search.isbn = "0143039008" # Equivalent to search.add_query_term "0143039008", "isbn", "exact"
    search.title = "Travels with My Aunt" # Equivalent to search.add_query_term "Travels with My Aunt", "title", "exact"
    search.author = "Graham Greene" # Equivalent to search.add_query_term "Graham Greene", "creator", "exact"
    
Search also takes search elements in the initial hash

    search = Exlibris::Primo::Search.new(:base_url => "http://primo.institution.edu", 
      :institution => "INSTITUTION", :isbn = "0143039008")
Or  

    search = Exlibris::Primo::Search.new(:base_url => "http://primo.institution.edu", 
      :institution => "INSTITUTION", :record_id = "aleph0123456789")

    
## Exlibris::Primo::Record
Exlibris::Primo::Record is an object representation of a Primo record.

### Example of Exlibris::Primo::Record in action
    search = Exlibris::Primo::Search.new(:base_url => "http://primo.institution.edu", 
      :institution => "INSTITUTION")
    search.record_id= "aleph0123456789"
    count = search.count
    facets = search.facets
    records = search.search.records
    records.each do |record_id, record|
      holdings = record.holdings
      fulltexts = record.fulltexts
      table_of_contents = record.table_of_contents
      related_links = record.related_links
    end

## Exlibris::Primo::RemoteRecord
Exlibris::Primo::RemoteRecord is an object representation of a Primo record for the given record_id.

### Example of Exlibris::Primo::RemoteRecord in action
    remote_record = Exlibris::Primo::RemoteRecord.new("aleph0123456789", 
      :base_url => @base_url, :institution => @institution)
    holdings = remote_record.holdings
    fulltexts = remote_record.fulltexts
    table_of_contents = remote_record.table_of_contents
    related_links = remote_record.related_links

## Exlibris::Primo::Config
Exlibris::Primo::Config allows you to specify global configuration parameter for Exlibris::Primo

    Exlibris::Primo.configure do |config|
      config.base_url = "http://primo.institution.edu"
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
    eshelf = Exlibris::Primo::EShelf.new(:user_id => "USER_ID", 
      :base_url => "http://primo.institution.edu", :insitution => "INSTITUTION")
    records = eshelf.records
    count = eshelf.count
    basket_id = eshelf.basket_id
    eshelf.add_records(["PrimoRecordId","PrimoRecordId2"], basket_id)
