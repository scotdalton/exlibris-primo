module Exlibris
  module Primo
    # 
    # Abstract class representing a link in Primo.
    # 
    class Link
      include Abstract
      include Config::Attributes
      include WriteAttributes

      self.abstract = true

      attr_accessor :record_id, :original_id,
        :url, :display, :notes, :subfields
    end

    # 
    # Primo fulltext link.
    # 
    class Fulltext < Link
    end

    # 
    # Primo table of contents link.
    # 
    class TableOfContents < Link
    end

    # 
    # Primo related link.
    # 
    class RelatedLink < Link
    end
  end
end