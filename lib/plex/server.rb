module Plex
  class Server

    DEFAULT_HOST = '127.0.0.1'
    DEFAULT_PORT = 32400

    VALID_PARAMS = %w| type year decade sort|

    attr_accessor :host, :port, :token

    def initialize(options = {})
      params = Plex::DEFAULT_CONFIG.merge(options)
      @host  = params.fetch(:host, DEFAULT_HOST)
      @port  = params.fetch(:port, DEFAULT_PORT)
      @token = params.fetch(:token, nil)
    end

    def libraries
      response = query('library/sections')
      data = response.fetch("Directory", [])
      data.map {|library| Plex::Library.new(library, server: self) }
    end

    def library(id)
      if id.is_a?(String)
        libraries.detect {|library| library.title == id }
      else
        libraries.detect {|library| library.id == id.to_i }
      end
    end

    def library_by_path(path)
      libraries.detect {|library| library.has_path?(path) }
    end


    def query(path, options: {})
      params = pagination_params(options)
      params.merge!(parse_query_params(options))
      # get response
      opts = {}
      # parse response
      response = conn.get(path) do |req|
        req.params = params
      end
      JSON.parse(response.body).fetch("MediaContainer", nil)
    end

    def data_query(path, options: {})
      response = query(path, options)
      response.fetch("Metadata", [])
    end


    private


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
      params
    end


    def conn
      Faraday.new(
        url: base_url,
        params: {},
        headers: {
          "X-Plex-Token" => token,
          "Accept"  => "application/json"
        }
      )
    end

    def base_url
      url = host.start_with?("http") ? host.to_s : "http://#{host}"
      "#{url}:#{port}"
    end

  end

end