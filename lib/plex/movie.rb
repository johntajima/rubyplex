module Plex

   # {"ratingKey"=>"31448",
   #  "key"=>"/library/metadata/31448",
   #  "studio"=>"Universal Pictures",
   #  "type"=>"movie",
   #  "title"=>"2 Guns",
   #  "contentRating"=>"R",
   #  "summary"=>
   #   "Two hardened criminals get into trouble with the US border patrol after meeting with a Mexican drug lord, and then revelations start to unfold.",
   #  "rating"=>6.4,
   #  "audienceRating"=>6.6,
   #  "year"=>2013,
   #  "tagline"=>"2 Guns, 1 Bank.",
   #  "thumb"=>"/library/metadata/31448/thumb/1532271399",
   #  "art"=>"/library/metadata/31448/art/1532271399",
   #  "duration"=>6555370,
   #  "originallyAvailableAt"=>"2013-08-02",
   #  "addedAt"=>1523489564,
   #  "updatedAt"=>1532271399,
   #  "audienceRatingImage"=>"rottentomatoes://image.rating.spilled",
   #  "chapterSource"=>"agent",
   #  "primaryExtraKey"=>"/library/metadata/32224",
   #  "ratingImage"=>"rottentomatoes://image.rating.ripe",
   #  "Media"=>
   #   [{"videoResolution"=>"1080",
   #     "id"=>67507,
   #     "duration"=>6555370,
   #     "bitrate"=>2148,
   #     "width"=>1920,
   #     "height"=>800,
   #     "aspectRatio"=>2.35,
   #     "audioChannels"=>2,
   #     "audioCodec"=>"aac",
   #     "videoCodec"=>"h264",
   #     "container"=>"mp4",
   #     "videoFrameRate"=>"24p",
   #     "optimizedForStreaming"=>1,
   #     "audioProfile"=>"lc",
   #     "has64bitOffsets"=>false,
   #     "videoProfile"=>"high",
   #     "Part"=>
   #      [{"id"=>67782,
   #        "key"=>"/library/parts/67782/1383905481/file.mp4",
   #        "duration"=>6555370,
   #        "file"=>
   #         "/volume2/Media/Movies/2 Guns (2013) [1080p]/2 Guns (2013) [1080p] [AAC 2ch].mp4",
   #        "size"=>1760468767,
   #        "audioProfile"=>"lc",
   #        "container"=>"mp4",
   #        "has64bitOffsets"=>false,
   #        "optimizedForStreaming"=>true,
   #        "videoProfile"=>"high"}]}],
   #  "Genre"=>[{"tag"=>"Action"}, {"tag"=>"Comedy"}],
   #  "Director"=>[{"tag"=>"Baltasar Kormákur"}],
   #  "Writer"=>[{"tag"=>"Blake Masters"}],
   #  "Country"=>[{"tag"=>"USA"}],
   #  "Role"=>
   #   [{"tag"=>"Denzel Washington"},
   #    {"tag"=>"Mark Wahlberg"},
   #    {"tag"=>"Paula Patton"}]},

  class Movie < Plex::Base

    def load_details!
      @hash = server.data_query(key).first
      @medias = nil
    end

    def id
      rating_key.to_i
    end

    def imdb
      guids = @hash.fetch("Guid",[])
      guids.map {|x| x['id'].scan(/imdb\:\/\/(tt\d{3,})/).first }.flatten.compact.first
    end

    def tmdb
      guids = @hash.fetch("Guid",[])
      guids.map {|x| x['id'].scan(/tmdb\:\/\/(\d{1,})/).first }.flatten.compact.first
    end

    def release_date
      originally_available_at
    end

    def medias
      @medias ||= begin
        hash.fetch("Media", []).map {|entry| Plex::Media.new(entry) }
      end
    end

    def find_by_filename(filename, full_path: false)
      medias.detect {|m| m.has_file?(filename, full_path: full_path)}
    end

    def files
      medias.map(&:files).flatten
    end

    def inspect
      "#<Plex::Movie id:#{rating_key} '#{title}' (#{year}) #{files}>"
    end
  end

end
