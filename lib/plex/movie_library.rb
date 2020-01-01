module Plex

  class MovieLibrary < Library

    private

    def get_entries(path, options = {})
      params = sanitize_options(options)
      results = server.query(query_path(path), params).fetch('Metadata')
      results.map {|e| Plex::Movie.new(e) }
    end
  end

end