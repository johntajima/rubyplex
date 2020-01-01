module Plex

# /library/sections 
# "Directory" => [
# { "allowSync"=>true,
#   "art"=>"/:/resources/movie-fanart.jpg",
#   "composite"=>"/library/sections/8/composite/1542179087",
#   "filters"=>true,
#   "refreshing"=>false,
#   "thumb"=>"/:/resources/movie.png",
#   "key"=>"8",
#   "type"=>"movie",
#   "title"=>"4K Movies",
#   "agent"=>"com.plexapp.agents.imdb",
#   "scanner"=>"Plex Movie Scanner",
#   "language"=>"en",
#   "uuid"=>"36b7bf82-784e-4c0c-a219-e51549ebc255",
#   "updatedAt"=>1536625963,
#   "createdAt"=>1512309737,
#   "scannedAt"=>1542179087,
#   "Location"=>
#    [{"id"=>17, "path"=>"/volume4/Media2/Movies_HQ"},
#     {"id"=>22, "path"=>"/volume4/Media2/hq_downloads"}]}
# ]

  class Library
    include Plex::Base
    include Plex::Sortable

    MAP = {
      id: 'key',
      type: 'type',
      title: 'title',
      agent: 'agent',
      updated_at: 'updatedAt',
      directories: 'Location'
    }

    def initialize(hash)
      init_attributes(hash)
      @hash = hash.except('Metadata')
    end

    def total_count(options = {})
      response = server.query(query_path('all'), options.merge(page: 1, per_page: 0))
      response.fetch('totalSize').to_i
    end

    def all(options = {})
      @all ||= begin
        get_entries('all', options)
      end
    end

    def unwatched(options = {})
      get_entries('unwatched', options)
    end

    def newest(options = {})
      get_entries('newest', options)
    end

    def updated_since(time, options = {})
      results = self.all(options.except('page', 'per_page', :page, :per_page))
      sorted_results = results.sort {|a, b| b.updated_at <=> a.updated_at }
      valid_results, _ = results.partition {|a| Time.at(a.updated_at) > Time.at(time) }
      valid_results
    end

    def recently_added(options = {})
      get_entries('recentlyAdded', options)
    end

    def recently_viewed(options = {})
      get_entries('recentlyViewed', options)
    end

    def by_year(year, options = {})
      params = options.merge({ "type" => 1, "year" => year })
      get_entries('all', params)
    end

    def by_decade(decade, options = {})
      params = options.merge({ "type" => 1, "decade" => decade })
      get_entries('all', params)
    end

    def find_by_filename(filename)
      result = all.detect {|entry| entry.by_file(filename)}
      movie_library? ? result : result.by_file(filename)
    end

    def search(query, options = {})
      # search by filename
      # search by title
      # search by year?
      # search by ?
    end

    def to_hash
      attributes.merge(total_count: total_count)
    end

    def inspect
      "#<Plex::Library:#{object_id}  id:#{id} #{title}>"
    end

    def movie_library?
      type == 'movie'
    end


    private

    def get_entries(path, options = {})
      params = sanitize_options(options)
      results = server.query(query_path(path), params).fetch('Metadata')
      model = movie_library? ? Plex::Movie : Plex::Show
      results.map {|e| model.new(e) }
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
      "/library/sections/#{id}/#{path}"
    end
  end

end