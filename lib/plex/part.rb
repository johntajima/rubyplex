module Plex


# [
  # { 
  #   "id"=>22948,
  #   "key"=>"/library/parts/22948/1523638734/file.mkv",
  #   "duration"=>3816145,
  #   "file"=>
  #    "/volume1/Media/TV/Lost in Space/Lost in Space S01/Lost in Space S01E01 [720p].mkv",
  #   "size"=>1455634887,
  #   "container"=>"mkv",
  #   "videoProfile"=>"high",
  #    "Stream"=>
         # [{"id"=>152424,
         #   "streamType"=>1,
         #   "default"=>true,
         #   "codec"=>"h264",
         #   "index"=>0,
         #   "bitrate"=>2051,
         #   "bitDepth"=>8,
         #   "chromaLocation"=>"left",
         #   "chromaSubsampling"=>"4:2:0",
         #   "colorPrimaries"=>"bt709",
         #   "colorRange"=>"tv",
         #   "colorSpace"=>"bt709",
         #   "frameRate"=>23.976,
         #   "hasScalingMatrix"=>false,
         #   "height"=>800,
         #   "level"=>41,
         #   "profile"=>"high",
         #   "refFrames"=>4,
         #   "streamIdentifier"=>"1",
         #   "width"=>1920,
         #   "displayTitle"=>"1080p (H.264)"},
         #  {"id"=>152425,
         #   "streamType"=>2,
         #   "selected"=>true,
         #   "default"=>true,
         #   "codec"=>"aac",
         #   "index"=>1,
         #   "channels"=>2,
         #   "bitrate"=>98,
         #   "language"=>"English",
         #   "languageCode"=>"eng",
         #   "audioChannelLayout"=>"stereo",
         #   "profile"=>"lc",
         #   "samplingRate"=>48000,
         #   "streamIdentifier"=>"2",
         #   "displayTitle"=>"English (AAC Stereo)"}]}]}]
#   ]
  # }
# ]

  class Part
    include Plex::Base

    MAP = {
      id: 'id',
      file: 'file',
      size: 'size',
      duration: 'duration'
    }

    attr_reader :streams
    
    def initialize(hash)
      init_attributes(hash)
      @hash = hash.except("Stream")
      @streams = load_streams(hash)
    end

    def to_hash
      @attributes.merge(streams: streams)
    end

    def inspect
      "#<Plex::Part #{id} #{file}>"
    end


    private

    def load_streams(hash)
      hash.fetch("Stream", []).map {|stream|
        stream.fetch('displayTitle',nil)
      }.compact
    end

  end
end