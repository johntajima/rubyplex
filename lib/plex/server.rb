module Plex

  class Server

    DEFAULT_HOST = '127.0.0.1'
    DEFAULT_PORT = 32400

    attr_accessor :host, :port, :token

    def initialize(options = Plex::DEFAULT_CONFIG)
      @host  = options.fetch(:host, DEFAULT_HOST)
      @port  = options.fetch(:port, DEFAULT_PORT)
      @token = options.fetch(:token, nil)
    end

    def libraries
      query('library/sections')
    end

    def library(id)
    end


    private


    def query(path, options: {})
      # build path
      url = ""
      # build options
      params = {}
      # get response
      opts = {}
      # parse response
      response = conn.get(url) do |req|

      end
      p response
    end


    def conn
      @conn ||= begin
        Faraday.new(
          url: base_url,
          params: {
            "X-Plex-Token" => token,
            :accept        => :json
          },
          headers: {'Content-Type': 'Application/json'}
        )
      end
    end

    def base_url
      url = host.start_with?("http") ? host.to_s : "http://#{host}"
      "#{url}:#{port}"
    end

  end

end