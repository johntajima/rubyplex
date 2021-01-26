module Plex

# /library/metadata/9760/allLeaves
# [...
#  {"ratingKey"=>"9760",
#   "key"=>"/library/metadata/9760",
#   "parentRatingKey"=>"9759",
#   "grandparentRatingKey"=>"9758",
#   "guid"=>"com.plexapp.agents.thetvdb://343253/1/1?lang=en",
#   "studio"=>"Netflix",
#   "type"=>"episode",
#   "title"=>"Impact",
#   "grandparentKey"=>"/library/metadata/9758",
#   "parentKey"=>"/library/metadata/9759",
#   "grandparentTitle"=>"Lost in Space (2018)",
#   "parentTitle"=>"Season 1",
#   "contentRating"=>"TV-PG",
#   "summary"=>
#    "On the way to a space colony, a crisis sends the Robinsons hurtling towards an unfamiliar planet, where they struggle to survive a harrowing night.",
#   "index"=>1,
#   "parentIndex"=>1,
#   "rating"=>7.3,
#   "year"=>2018,
#   "thumb"=>"/library/metadata/9760/thumb/1577741714",
#   "art"=>"/library/metadata/9758/art/1575740056",
#   "parentThumb"=>"/library/metadata/9759/thumb/1577741715",
#   "grandparentThumb"=>"/library/metadata/9758/thumb/1575740056",
#   "grandparentArt"=>"/library/metadata/9758/art/1575740056",
#   "grandparentTheme"=>"/library/metadata/9758/theme/1575740056",
#   "duration"=>3816145,
#   "originallyAvailableAt"=>"2018-04-13",
#   "addedAt"=>1575740056,
#   "updatedAt"=>1577741714,
#   "Media"=>
#    [{"id"=>22948,
#      "duration"=>3816145,
#      "bitrate"=>3049,
#      "width"=>1280,
#      "height"=>640,
#      "aspectRatio"=>1.85,
#      "audioChannels"=>6,
#      "audioCodec"=>"eac3",
#      "videoCodec"=>"h264",
#      "videoResolution"=>"720",
#      "container"=>"mkv",
#      "videoFrameRate"=>"24p",
#      "videoProfile"=>"high",
#      "Part"=>
#       [{"id"=>22948,
#         "key"=>"/library/parts/22948/1523638734/file.mkv",
#         "duration"=>3816145,
#         "file"=>
#          "/volume1/Media/TV/Lost in Space/Lost in Space S01/Lost in Space S01E01 [720p].mkv",
#         "size"=>1455634887,
#         "container"=>"mkv",
#         "videoProfile"=>"high"}]}],
#   "Writer"=>[{"tag"=>"Burk Sharpless"}, {"tag"=>"Matt Sazama"}]
#  },
#  ...
# ]

  class Episode < Plex::Base


    def load_details!
      @hash = server.data_query(key).first
      @medias = nil
    end

    def show_title
      grandparent_title
    end

    def inspect
      "#<Plex::Episode id:#{rating_key} '#{grandparent_title}' #{label}>"
    end

    def medias
      @medias ||= hash.fetch("Media", []).map {|entry| Plex::Media.new(entry) }
    end

    def media_by_filename(filename, full_path: false)
      medias.detect {|media| media.has_file?(filename, full_path: full_path)}
    end

    def season
      parent_index
    end

    def episode
      index
    end

    def release_date
      originally_available_at
    end

    def label 
      "S#{"%02d" % season}E#{"%02d" % episode}"
    end

    def files
      medias.map(&:files).flatten
    end

  end

end