# Exlibris::Primo
[![Gem Version](https://badge.fury.io/rb/exlibris-primo.png)](http://badge.fury.io/rb/exlibris-primo)
[![Build Status](https://api.travis-ci.org/scotdalton/exlibris-primo.png?branch=master)](https://travis-ci.org/scotdalton/exlibris-primo)
[![Dependency Status](https://gemnasium.com/scotdalton/exlibris-primo.png)](https://gemnasium.com/scotdalton/exlibris-primo)
[![Code Climate](https://codeclimate.com/github/scotdalton/exlibris-primo.png)](https://codeclimate.com/github/scotdalton/exlibris-primo)
[![Coverage Status](https://coveralls.io/repos/scotdalton/exlibris-primo/badge.png?branch=master)](https://coveralls.io/r/scotdalton/exlibris-primo)

Exlibris::Primo offers a set of classes for interacting with the ExLibris Primo APIs.

## Exlibris::Primo::Search
The Exlibris::Primo::Search class performs a search against Primo for given parameters
and exposes the set of holdings, fulltext links, table of contents links, and related links for each record retrieved.

### Example of Exlibris::Primo::Search in action
Search can search by a query

    search = Exlibris::Primo::Search.new(:base_url => "http://primo.institution.edu",
      :institution => "INSTITUTION", :page_size => "20")
    search.add_query_term "0143039008", "isbn", "exact"
    count = search.size #=> 20+ (assuming there are 20+ records with this isbn)
    facets = search.facets #=> Array of Primo facets
    records = search.records #=> Array of Primo records
    records.size #=> 20 (assuming there are 20+ records with this isbn)
    records.each do |record_id, record|
      holdings = record.holdings #=> Array of Primo holdings
      fulltexts = record.fulltexts #=> Array of Primo full texts
      table_of_contents = record.table_of_contents #=> Array of Primo tables of contents
      related_links = record.related_links #=> Array of Primo related links
    end

Or by a given record id

    search = Exlibris::Primo::Search.new(:base_url => "http://primo.institution.edu",
      :institution => "INSTITUTION")
    search.record_id! "aleph0123456789"
    count = search.size #=> 1
    records = search.records #=> Array of Primo records
    records.size #=> 1
    record = records.first #=> Primo record
    holdings = record.holdings #=> Array of Primo holdings
    fulltexts = record.fulltexts #=> Array of Primo full texts
    table_of_contents = record.table_of_contents #=> Array of Primo tables of contents
    related_links = record.related_links #=> Array of Primo related links

Search has some methods for setting search params

    search = Exlibris::Primo::Search.new(:base_url => "http://primo.institution.edu",
      :institution => "INSTITUTION")
    search.isbn_is "0143039008" #=> Equivalent to search.add_query_term "0143039008", "isbn", "exact"
    search.title_begins_with "Travels" #=> Equivalent to search.add_query_term "Travels", "title", "begins_with"
    search.creator_contains "Greene" #=> Equivalent to search.add_query_term "Greene", "creator", "contains"

Search can take a record id the initial hash

    search = Exlibris::Primo::Search.new(:base_url => "http://primo.institution.edu",
      :institution => "INSTITUTION", :record_id => "aleph0123456789")

Search can also be chained using the ! version of the attribute writer

    search = Exlibris::Primo::Search.new.base_url!("http://primo.institution.edu").
      institution!("INSTITUTION").record_id!("aleph0123456789")

Or

    search = Exlibris::Primo::Search.new.base_url!("http://primo.institution.edu").
      institution!("INSTITUTION").title_begins_with("Travels").
        creator_contains("Greene").genre_is("Book")

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
The Exlibris::Primo::EShelf class provides methods for reading a given user's Primo eshelf 
and eshelf structure as well as adding and removing records.

## Example of Exlibris::Primo::EShelf in action
    eshelf = Exlibris::Primo::EShelf.new(:user_id => "USER_ID",
      :base_url => "http://primo.institution.edu", :insitution => "INSTITUTION")
    records = eshelf.records
    size = eshelf.size
    basket_id = eshelf.basket_id
    eshelf.add_records(["PrimoRecordId","PrimoRecordId2"], basket_id)

## Exlibris::Primo::Reviews
The Exlibris::Primo::Reviews class provides methods for reading a given user's Primo reviews 
features.

## Example of Exlibris::Primo::Reviews in action
    reviews = Exlibris::Primo::Reviews.new(:record_id => "aleph0123456789", :user_id => "USER_ID",
      :base_url => "http://primo.institution.edu", :insitution => "INSTITUTION")
    user_record_reviews = reviews.reviews #=> Array of Primo reviews

## Exlibris::Primo::Tags
The Exlibris::Primo::Tags class provides methods for reading a given user's Primo tags 
features.

## Example of Exlibris::Primo::Tags in action
    tags = Exlibris::Primo::Tags.new(:record_id => "aleph0123456789", :user_id => "USER_ID",
      :base_url => "http://primo.institution.edu", :insitution => "INSTITUTION")
    user_record_tags = tags.tags #=> Array of Primo tags
