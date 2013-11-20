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

      attr_accessor :institution, :record_id, :original_id,
        :url, :display, :notes, :subfields

      def initialize *args
        # URLs may have XML escaped ampersands
        # so we need to account for that.
        args.last[:url].gsub!("&amp;", "&") unless args.last.nil?
        super(*args)
      end
    end

    # 
    # Primo fulltext link.
    # 
    class Fulltext < Link; end

    # 
    # Primo table of contents link.
    # 
    class TableOfContents < Link; end

    # 
    # Primo related link.
    # 
    class RelatedLink < Link; end
  end
end