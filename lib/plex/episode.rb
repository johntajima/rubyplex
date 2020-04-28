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
  class Episode
    include Plex::Base

    MAP = {
      id: 'ratingKey',
      episode: 'index',
      season: 'parentIndex',
      title: 'title',
      year: 'year',
      season_title: 'parentTitle',
      show_title: 'grandparentTitle',
      show_key: 'grandparentKey',
      duration: 'duration',
      release_date: 'originallyAvailableAt'
    }

    attr_reader :medias

    def initialize(hash)
      init_attributes(hash)
      @medias = load_medias(hash)
      @hash = hash.except('Media')
    end

    def show
      @show ||= begin
        response = server.query(show_key)
        data = response.fetch('Metadata', []).first
        Plex::Show.new(data)
      end
    end

    def parent
      show
    end

    def by_file(file, full_path = false)
      medias.find {|m| m.has_file?(file, full_path) }
    end

    def files
      medias.map {|m| m.files }.flatten
    end

    def to_hash
      attributes.merge(medias: medias.map(&:to_hash))
    end

    def inspect
      "#<Plex::Episode:#{object_id} id:#{id} #{show_title} #{label}>"
    end

    def label 
      "S#{"%02d" % season}E#{"%02d" % episode}"
    end


    private

    def key
      hash.fetch('key')
    end

    def load_medias(hash)
      medias = hash.fetch("Media", [])
      medias.map {|entry| Plex::Media.new(entry, self) }
    end
  end

end