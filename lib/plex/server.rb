module Plex
  class Server

    VALID_PARAMS = %w| type year decade sort includeGuids|

    attr_accessor :host, :port, :token

    def initialize(params = {})
      @host  = params.fetch(:host, Plex::DFLT_HOST)
      @port  = params.fetch(:port, Plex::DFLT_PORT)
      @token = params.fetch(:token, Plex::DFLT_TOKEN)
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
        libraries.detect {|library| library.key.to_i == id.to_i }
      end
    end

    def library_by_path(path)
      # detect full path
      path = File.dirname(File.join(path, 'foo.bar'))
      if found = libraries.detect {|l| l.locations.include?(path) }
        return found
      end

      # detect subpaths
      path_chunks = path.split("/").reject(&:empty?)
      (path_chunks.length-1).downto(1).each do |i|
        subpath = path_chunks[i]
        if found = libraries.detect {|l| l.locations.any? {|d| d.end_with?(subpath) } }
          return found
        end
      end
      nil
    end

    def query(path, options: {})
      params = pagination_params(options)
      params.merge!(parse_query_params(options))
      response = request(query_path(path), params)
      JSON.parse(response.body).fetch("MediaContainer", {})
    end

    def data_query(path, options: {})
      response = query(path, options: options)
      response.fetch("Metadata", [])
    end

    def query_path(path)
      url = host.start_with?("http") ? host.to_s : "http://#{host}"
      File.join("#{url}:#{port}", path)
    end


    private


    def request(url, params)
      Faraday.get(url, params, req_headers)
    end

    def req_headers
      {
        "X-Plex-Token" => token,
        "Accept"  => "application/json",
      }
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
      params
    end

  end

end
