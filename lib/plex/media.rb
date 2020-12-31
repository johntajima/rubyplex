module Plex

  # "videoResolution"=>"1080",
  # "id"=>67507,
  # "duration"=>6555370,
  # "bitrate"=>2148,
  # "width"=>1920,
  # "height"=>800,
  # "aspectRatio"=>2.35,
  # "audioChannels"=>2,
  # "audioCodec"=>"aac",
  # "videoCodec"=>"h264",
  # "container"=>"mp4",
  # "videoFrameRate"=>"24p",
  # "optimizedForStreaming"=>1,
  # "audioProfile"=>"lc",
  # "has64bitOffsets"=>false,
  # "videoProfile"=>"high",
  # "Part" => []

  class Media < Plex::Base

    def files
      parts.map(&:file).flatten
    end

    def has_file?(filename, full_path: false)
      parts.any? {|part| part.has_file?(filename, full_path: full_path) }
    end

    def parts
      @parts ||= begin
        hash.fetch("Part",[]).map do |entry|
          Plex::Part.new(entry)
        end
      end
    end

    def inspect
      h = @hash.dup
      h.delete("Part")
      h.merge("Part" => parts)
    end

  end
end
