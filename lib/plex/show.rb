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


  class Show < Plex::Base

    def seasons_count
      child_count
    end

    def episodes_count
      leaf_count
    end

    def episodes
      @episodes ||= begin
        list = server.data_query(episodes_path)
        list.map {|entry| Plex::Episode.new(entry, server: server)}
      end
    end

    def season(season)
      episodes.select {|e| e.season == season}
    end

    def episode(season, index)
      episodes.find {|e| e.season == season && e.episode == index }
    end

    def tvdb
      guid.scan(/thetvdb\:\/\/(\d{6,})/).last.first if guid.match('tvdb')
    end

    def inspect
      "#<Plex::Show id:#{rating_key} '#{title}' (#{year}) #{seasons_count}|#{episodes_count}>"
    end

    def find_by_filename(filename, full_path: false)
      episodes.detect {|e| e.media_by_filename(filename, full_path: full_path) }
    end

    def files
      episodes.map(&:files).flatten
    end


    private


    def episodes_path
      "/library/metadata/#{rating_key}/allLeaves"
    end

  end

end