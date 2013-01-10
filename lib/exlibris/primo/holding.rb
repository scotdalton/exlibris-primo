module Exlibris
  module Primo

    #
    # Primo Holding.
    #
    # Object representing a holding in Primo.
    # 
    # Primo holdings can be extended to create Primo source holdings.
    # create a local class representing the source in the
    # module Exlibris::Primo::Source which extends Exlibris::Primo::Holding.
    # Two methods are then available for overriding:
    #     :expand -   expand holdings based on information from the source
    #                 default: [self]
    #     :dedup? -   if this data source contain duplicate holdings that need to be deduped, set to true
    #                 default: false
    #
    # ==Examples
    # An examples of a customized source is:
    # * Exlibris::Primo::Source::Aleph
    class Holding
      include Config::Attributes
      include WriteAttributes

      # Default values for the class.
      def self.defaults
        @defaults ||= { :coverage => [], :source_data => {} }
      end

      attr_accessor :availlibrary, :record_id, :original_id,
        :title, :author, :display_type, :source_id, :original_source_id,
        :source_record_id, :ils_api_id, :institution_code,
        :library_code, :availability_status_code,
        :collection, :call_number, :coverage, :notes,
        :subfields, :source_class, :source_data

      alias :status_code :availability_status_code

      # Initialize with a set of attributes and/or another :holding.
      def initialize(attributes={})
        # Get holding
        holding = attributes.delete(:holding)
        # Instantiate new holding from input holding
        # if it exists.
        unless holding.nil?
          super holding.to_h.merge(attributes)
        else
          super self.class.defaults.merge(attributes)
        end
      end

      # Get the source config from the Primo config, based on source_id, if not already set.
      def source_config
        @source_config ||= sources[source_id]
      end

      # Get the class name from the Primo source config, if not already set.
      def source_class
        @source_class ||= source_config["class_name"] unless source_config.nil?
      end

      # Get the institution from the Primo config based on institution code, if not already set.
      def institution
        @institution ||= (institutions[institution_code] || institution_code)
      end

      # Get the library from the Primo config based on library code, if not already set.
      def library
        @library ||= (libraries[library_code] || library_code)
      end

      # Get the availability status from the Primo config based on availability status code, if not already set.
      def availability_status
        @availability_status ||= (availability_statuses[availability_status_code] || availability_status_code)
      end
      alias :availability :availability_status
      alias :status :availability_status

      # Returns an array of self.
      # Should be overridden by source subclasses if appropriate.
      def expand
        return [self]
      end

      # Determine if we're de-duplicating.
      # Should be overridden by source subclasses if appropriate.
      def dedup?
        return false
      end

      # Return this holding as a new holdings subclass instance based on source
      def to_source
        return self if source_class.nil?
        # Get source class in Primo::Source module
        return Exlibris::Primo::Source.const_get(source_class).new(:holding => self)
      end

      # Return the attribute accessible instance variables as a hash.
      def to_h
        { :availlibrary => availlibrary, :record_id => record_id, :original_id => original_id, 
          :title => title, :author => author, :display_type => display_type, :source_id => source_id,
          :original_source_id => original_source_id, :source_record_id => source_record_id,
          :ils_api_id => ils_api_id, :institution_code => institution_code, :library_code => library_code,
          :availability_status_code => availability_status_code, :collection => collection,
          :call_number => call_number, :coverage => coverage, :notes => notes, :subfields => subfields,
          :source_id => source_id, :source_class => source_class, :source_data => source_data }
      end
    end
  end
end