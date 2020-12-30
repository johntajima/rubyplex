module Plex
  class Server

    DEFAULT_HOST = '127.0.0.1'
    DEFAULT_PORT = 32400

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
      # build path
      url = path
      # build options
      params = {}
      # get response
      opts = {}
      # parse response
      response = conn.get(url) do |req|

      end
      JSON.parse(response.body).fetch("MediaContainer", nil)
    end


    private



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