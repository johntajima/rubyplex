module Plex

   #  {"id"=>152424,
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

  class Stream < Plex::Base

    def inspect
      "#<Plex::Stream id:#{hash}>"
    end

  end
end