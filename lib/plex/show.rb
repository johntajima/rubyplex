module Plex

# /library/sections/2/all
# [
#  {"ratingKey"=>"9758",
#   "key"=>"/library/metadata/9758/children",
#   "guid"=>"com.plexapp.agents.thetvdb://343253?lang=en",
#   "studio"=>"Netflix",
#   "type"=>"show",
#   "title"=>"Lost in Space (2018)",
#   "contentRating"=>"TV-PG",
#   "summary"=>
#    "After crash-landing on an alien planet, the Robinson family fight against all odds to survive and escape, but they're surrounded by hidden dangers. ",
#   "index"=>1,
#   "rating"=>8.6,
#   "year"=>2018,
#   "thumb"=>"/library/metadata/9758/thumb/1577741715",
#   "art"=>"/library/metadata/9758/art/1577741715",
#   "banner"=>"/library/metadata/9758/banner/1577741715",
#   "theme"=>"/library/metadata/9758/theme/1577741715",
#   "duration"=>3300000,
#   "originallyAvailableAt"=>"2018-04-13",
#   "leafCount"=>20,
#   "viewedLeafCount"=>0,
#   "childCount"=>2,
#   "addedAt"=>1575740056,
#   "updatedAt"=>1577741715,
#   "Genre"=>[{"tag"=>"Action"}, {"tag"=>"Drama"}],
#   "Role"=>
#    [{"tag"=>"Molly Parker"},
#     {"tag"=>"Toby Stephens"},
#     {"tag"=>"Maxwell Jenkins"}]
#  },
#  ...
# ]

  class Show
    include Plex::Base

    MAP = {
      id: 'ratingKey',
      title: 'title',
      year: 'year',
      rating: 'rating',
      release_date: 'originallyAvailableAt',
      total_seasons: 'childCount',
      total_episodes: 'leafCount',
      added_at: 'addedAt',
      updated_at: 'updatedAt',
      roles: 'Role',
      genres: 'Genre'
    }

    attr_reader :episodes

    def initialize(hash)
      init_attributes(hash)
      @episodes = load_episodes
      @hash     = hash.except('Media')
    end

    def tvdb
      #{}"guid"=>"com.plexapp.agents.thetvdb://279536?lang=en"
    end

    def to_hash
      attributes.merge(episodes: episodes.map(&:to_hash))
    end

    def inspect
      "#<Plex::Show:#{object_id} id:#{id} #{title} (#{year})>"
    end

    # return specific episode
    def episode(season, index)
      episodes.find {|e| e.season == season && e.episode == index }
    end

    # returns all episodes where season match
    def season(season)
      episodes.select {|e| e.season == season }
    end

    def by_file(file, full_path = false)
      episodes.find {|e| e.has_file?(file, full_path) }
    end


    private

    def load_episodes
      @episodes ||= begin
        list = server.query(episodes_path).fetch("Metadata")
        list.map {|entry| Plex::Episode.new(entry) }
      end
    end

    def episodes_path
      "/library/metadata/#{id}/allLeaves"
    end
  end

end