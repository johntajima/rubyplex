module Plex
  class Section
    include Plex::Base
    include Plex::Sortable

    attr_reader :videos

    def initialize(hash)
      @attributes = hash.except('Metadata')
      add_accessible_methods
    end

    def locations
      attributes.fetch('Location').map {|l| l.fetch('path')}
    end

    def total_count(options = {})
      get_count('all', options)
    end

    def all(options = {})
      get_videos('all', options)
    end

    def unwatched(options = {})
      get_videos('unwatched', options)
    end

    def newest(options = {})
      get_videos('newest', options)
    end

    def updated_since(time, options = {})
      results = self.all(options.except('page', 'per_page', :page, :per_page))
      sorted_results = results.sort {|a, b| b.updated_at <=> a.updated_at }
      valid_results, _ = results.partition {|a| Time.at(a.updated_at) > Time.at(time) }
      valid_results
    end

    def recently_added(options = {})
      get_videos('recentlyAdded', options)
    end

    def recently_viewed(options = {})
      get_videos('recentlyViewed', options)
    end

    def by_year(year, options = {})
      params = options.merge({ "type" => 1, "year" => year })
      get_videos('all', params)
    end

    def by_decade(decade, options = {})
      params = options.merge({ "type" => 1, "decade" => decade })
      get_videos('all', params)
    end


    private

    def get_count(path, options = {})
      response = server.query(query_path(path), options.merge(page: 1, per_page: 0))
      response.fetch('totalSize').to_i
    end


    def get_videos(path, options = {})
      params = sanitize_options(options)
      response = server.query(query_path(path), params)
      results = response.fetch("Metadata")
      parse_results(results)
    end

    def parse_results(results)
      results.map do |entry|
        case self.type
        when 'movie'
          Plex::Movie.new(entry)
        when 'show'
          # todo
        else
          # todo
        end
      end
    end


    def sanitize_options(options)
      params = {}
      if options.key?(:sort)
        params['type'] = 1
        params['sort'] = SORT_ORDER.fetch(options[:sort], nil)
        if direction = options.fetch(:direction, nil)
          params['sort'] = params['sort'] + ":desc"
        end
      end
      params.merge(options.except(:sort, :direction))
    end

    def query_path(path)
      "/library/sections/#{key}/#{path}"
    end
  end
end