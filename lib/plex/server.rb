module Plex

  class Server

    attr_reader :base_url, :headers, :config, :params

    VALID_PARAMS = %w| type year decade sort|

    def initialize(config)
      @config   = config
    end

    # Public Methods

    # returns array of sections
    def sections(options: {})
      @sections ||= begin
        results = query("library/sections", options)
        results.fetch('Directory', []).map {|entry| Plex::Section.new(entry) }
      end
    end

    def section(query)
      section = if query.to_i.to_s == query || query.is_a?(Integer)
        sections.detect {|s| s.key.to_i == query.to_i }
      else
        sections.detect {|s| s.title == query }
      end
      raise NotFoundError, "Could not find Section with that ID or Name" if section.nil?
      section
    end

    def section_by_path(path)
      sections.detect {|section| section.locations.include?(path) }
    end

    def query(path, options = {})
      query_url     = query_path(path)
      query_params  = set_params(options)      
      response      = RestClient.get(query_url, query_params)
      response_hash = JSON.parse(response.body)
      response_hash.fetch('MediaContainer')
    rescue RestClient::Exception => e
      puts "Error: #{e.message}"
      puts "Url: #{query_url}"
      puts "query params: #{query_params}"
      puts response_hash
      raise
    # ensure
    #   p query_url, query_params
    end


    private

    def set_params(options)
      params = default_params.dup
      params.merge!(parse_query_params(options))
      params.merge!(pagination_params(options))
      params
    end

    def query_path(path)
      path = path.gsub(/\A\//, '')
      File.join("#{config[:host]}:#{config[:port]}", path)
    end

    def pagination_params(options)
      offset       = options.fetch(:page, 1).to_i - 1
      per_page     = options.fetch(:per_page, nil)
      return {} if per_page.nil?
        
      {
        "X-Plex-Container-Start" => offset * per_page,
        "X-Plex-Container-Size"  => per_page
      }
    end

    def parse_query_params(options)
      options = options.transform_keys(&:to_s)
      params = options.slice(*VALID_PARAMS)
      {"params" => params}
    end

    def default_params
      @default_params ||= {
        "X-Plex-Token" => config[:token],
        :accept        => :json
      }
    end

  end
end