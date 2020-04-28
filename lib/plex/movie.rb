module Plex

# {"ratingKey"=>"31448",
#       "key"=>"/library/metadata/31448",
#       "studio"=>"Universal Pictures",
#       "type"=>"movie",
#       "title"=>"2 Guns",
#       "contentRating"=>"R",
#       "summary"=>
#        "Two hardened criminals get into trouble with the US border patrol after meeting with a Mexican drug lord, and then revelations start to unfold.",
#       "rating"=>6.4,
#       "audienceRating"=>6.6,
#       "year"=>2013,
#       "tagline"=>"2 Guns, 1 Bank.",
#       "thumb"=>"/library/metadata/31448/thumb/1532271399",
#       "art"=>"/library/metadata/31448/art/1532271399",
#       "duration"=>6555370,
#       "originallyAvailableAt"=>"2013-08-02",
#       "addedAt"=>1523489564,
#       "updatedAt"=>1532271399,
#       "audienceRatingImage"=>"rottentomatoes://image.rating.spilled",
#       "chapterSource"=>"agent",
#       "primaryExtraKey"=>"/library/metadata/32224",
#       "ratingImage"=>"rottentomatoes://image.rating.ripe",
#       "Media"=>
#        [{"videoResolution"=>"1080",
#          "id"=>67507,
#          "duration"=>6555370,
#          "bitrate"=>2148,
#          "width"=>1920,
#          "height"=>800,
#          "aspectRatio"=>2.35,
#          "audioChannels"=>2,
#          "audioCodec"=>"aac",
#          "videoCodec"=>"h264",
#          "container"=>"mp4",
#          "videoFrameRate"=>"24p",
#          "optimizedForStreaming"=>1,
#          "audioProfile"=>"lc",
#          "has64bitOffsets"=>false,
#          "videoProfile"=>"high",
#          "Part"=>
#           [{"id"=>67782,
#             "key"=>"/library/parts/67782/1383905481/file.mp4",
#             "duration"=>6555370,
#             "file"=>
#              "/volume2/Media/Movies/2 Guns (2013) [1080p]/2 Guns (2013) [1080p] [AAC 2ch].mp4",
#             "size"=>1760468767,
#             "audioProfile"=>"lc",
#             "container"=>"mp4",
#             "has64bitOffsets"=>false,
#             "optimizedForStreaming"=>true,
#             "videoProfile"=>"high"}]}],
#       "Genre"=>[{"tag"=>"Action"}, {"tag"=>"Comedy"}],
#       "Director"=>[{"tag"=>"Baltasar Kormákur"}],
#       "Writer"=>[{"tag"=>"Blake Masters"}],
#       "Country"=>[{"tag"=>"USA"}],
#       "Role"=>
#        [{"tag"=>"Denzel Washington"},
#         {"tag"=>"Mark Wahlberg"},
#         {"tag"=>"Paula Patton"}]},

  class Movie
    include Plex::Base

    attr_reader :medias, :media

    MAP = {
      id: 'ratingKey',
      title: 'title',
      rating: 'rating',
      year: 'year',
      type: 'type',
      duration: 'duration',
      release_date: 'originallyAvailableAt',
      added_at: 'addedAt',
      updated_at: 'updatedAt',
      genres: 'Genre',
      directors: 'Director',
      roles: 'Role',
      countries: 'Country'
    }

    def initialize(hash)
      init_attributes(hash)
      @medias = load_medias(hash)
      @hash   = hash.except('Media')
    end

    def imdb
      attributes.fetch(:imdb, load_imdb)
    end

    def tmdb
      attributes.fetch(:tmdb, load_tmdb)
    end

    def by_file(file, full_path = false)
      medias.find {|media| media.has_file?(file, full_path) }
    end

    def files
      medias.map {|m| m.files}.flatten
    end

    def to_hash
      attributes.merge(medias: medias.map(&:to_hash), imdb: imdb, tmdb: tmdb)
    end

    def inspect
      "#<Plex::Movie:#{object_id} id:#{id} #{title} (#{year})>"
    end

    private

    def key
      hash.fetch('key')
    end

    def load_medias(hash)
      list = hash.fetch('Media', [])
      list.map {|entry| Plex::Media.new(entry, self) }
    end

    def metadata
      @metadata ||= begin
        movie = Plex.server.query(key)
        movie.fetch("Metadata", []).first
      end
    end

    def load_imdb
      guid = metadata.fetch('guid', '')
      return unless guid.match('imdb')
      value = guid.scan(/tt\d{3,}/).first
      @attributes.merge!(imdb: value)
      value
    end

    def load_tmdb
      guid = metadata.fetch('guid', '')
      return unless guid.match('themoviedb')
      value = guid.scan(/themoviedb\:\/\/(\d{3,})/).first.first
      @attributes.merge!(tmdb: value)
      value
    end
  end
  
end