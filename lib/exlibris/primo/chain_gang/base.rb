module Exlibris
  module Primo
    module ChainGang
      # = Primo ChainGang Base Attributes
      # These base attributes are included in 
      # Search, Eshelf, Tags and Reviews and allow 
      # for chaining methods together.
      # 
      # == Examples
      # 
      #     search = Search.new.base_url!("http://primo.library.edu").
      #       institution!("PRIMO").ip!("127.0.0.1") 
      #       #=> #<Exlibris::Primo::Search @base_url="http://primo.library.edu", 
      #             @institution="PRIMO", @request_attributes={:base_url => "http://primo.library.edu", 
      #               :institution => "PRIMO", :ip => "127.0.0.1"}>
      # 
      #     eshelf = Eshelf.new.base_url!("http://primo.library.edu").
      #       institution!("PRIMO").ip!("127.0.0.1")
      #       #=> #<Exlibris::Primo::Eshelf @base_url="http://primo.library.edu", 
      #             @institution="PRIMO", @request_attributes={:base_url => "http://primo.library.edu", 
      #               :institution => "PRIMO", :ip => "127.0.0.1"}>
      # 
      #     reviews = Reviews.new.base_url!("http://primo.library.edu").
      #       institution!("PRIMO").ip!("127.0.0.1")
      #       #=> #<Exlibris::Primo::Reviews @base_url="http://primo.library.edu", 
      #             @institution="PRIMO", @request_attributes={:base_url => "http://primo.library.edu", 
      #               :institution => "PRIMO", :ip => "127.0.0.1"}>
      # 
      #     tags = Tags.new.base_url!("http://primo.library.edu").
      #       institution!("PRIMO").ip!("127.0.0.1")
      #       #=> #<Exlibris::Primo::Tags @base_url="http://primo.library.edu", 
      #             @institution="PRIMO", @request_attributes={:base_url => "http://primo.library.edu", 
      #               :institution => "PRIMO", :ip => "127.0.0.1"}>
      # 
      
      module Base
        # 
        # Set base URL for the Primo request.
        # 
        def base_url!(base_url)
          @base_url = base_url
          request_attributes[:base_url] = "#{base_url}"
          self
        end
        alias :base_url= :base_url!

        # 
        # Set institution for the Primo request.
        # 
        def institution!(institution)
          @institution = institution
          request_attributes[:institution] = "#{institution}"
          self
        end
        alias :institution= :institution!

        # 
        # Set client IP for the Primo request.
        # 
        def ip!(ip)
          request_attributes[:ip] = "#{ip}"
          self
        end
        alias :ip= :ip!
        alias :client_ip! :ip!
        alias :client_ip= :ip!

        # 
        # Set the group for the Primo request.
        # 
        def group!(group)
          request_attributes[:group] = "#{group}"
          self
        end
        alias :group= :group!

        # 
        # Set the PDS handle for the Primo request.
        # 
        def pds_handle!(pds_handle)
          request_attributes[:pds_handle] = "#{pds_handle}"
          self
        end
        alias :pds_handle= :pds_handle!

        # 
        # Specifies that the Primo request is coming from on campus.
        # 
        def on_campus
          request_attributes[:on_campus] = "true"
          self
        end

        # 
        # Specifies that the Primo request is coming from off campus.
        # 
        def off_campus
          request_attributes[:on_campus] = "false"
          self
        end

        # 
        # Specifies that the Primo request user is logged in.
        # 
        def logged_in
          request_attributes[:is_logged_in] = "true"
          self
        end

        # 
        # Specifies that the Primo request user is logged out.
        # 
        def logged_out
          request_attributes[:is_logged_in] = "false"
          self
        end
      end
    end
  end
end