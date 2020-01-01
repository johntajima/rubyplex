module Plex

  # require 'plex/show'
  # require 'plex/episode'
  # require 'plex/media'

  class ShowLibrary < Library

    private

    def get_entries(path, options = {})
      params = sanitize_options(options)
      results = server.query(query_path(path), params).fetch('Metadata')
      p results.count
      results.map {|e| Plex::Show.new(e) }
    end

  end

end