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

  class Media
    include Plex::Base

    MAP = {
      id: 'id',
      duration: 'duration',
      width: 'width', 
      height: 'height', 
      resolution: 'videoResolution', 
      audio_channels: 'audioChannels', 
      audio_codec: 'audioCodec', 
      video_codec: 'videoCodec'
    }

    attr_reader :parts, :part

    def initialize(hash)
      init_attributes(hash)
      @parts ||= load_parts(hash.fetch('Part', []))
      @part  = @parts.first
      @hash  = hash.except("Part")
    end

    def has_file?(file, full_path = false)
      parts.any? {|part| part.has_file?(file, full_path) }
    end

    def to_hash
      attributes.merge(parts: parts.map(&:to_hash))
    end

    def inspect
      "#<Plex::Media:#{object_id} id:#{id}>"
    end


    private

    def load_parts(parts)
      parts.map {|p| Plex::Part.new(p) }
    end
  end

end
