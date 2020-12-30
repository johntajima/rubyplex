# require "test_helper"

# class MediaTest < Minitest::Test
  
#   def setup
#     @server = Plex.server
#     stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
#     stub_request(:get, @server.query_path("/library/sections/1/all")).to_return(body: load_response(:library_1))
#     @library = Plex.server.library(1)
#     @movie = @library.all.first
#   end


#   # new

#   def test_new_media_parent_is_movie_if_from_movie
#     @media = @movie.medias.first
#     assert_equal @movie, @media.parent
#   end

#   def test_new_media_parent_is_episode_if_from_show
#     stub_request(:get, @server.query_path("/library/sections/2/all")).to_return(body: load_response(:library_2))
#     stub_request(:get, @server.query_path("/library/metadata/10401/allLeaves")).to_return(body: load_response(:show_1))
#     stub_request(:get, @server.query_path("/library/metadata/10320/allLeaves")).to_return(body: load_response(:show_2))
#     @library = Plex.server.library(2)
#     @media = @library.find_by_filename("/volume1/Media/TV/Band of Brothers/Band of Brothers S01/Band of Brothers S01E01 [1080p].mp4")

#     assert @media.is_a?(Plex::Media)
#     assert @media.parent.is_a?(Plex::Episode)
#   end


#   # attributes

#   def test_media_attributes
#     @media = @movie.medias.first
#     keys = [:audio_channels, :audio_codec, :duration, :height, :id, :resolution, :video_codec, :width]
#     assert_equal keys, @media.attributes.keys.sort
#     assert_equal 1, @media.parts.count    
#   end


#   # has_file?

#   def test_has_file_returns_true_if_exists
#     @media = @movie.medias.first
#     assert @media.has_file?("/volume1/Media/Movies/2 Guns (2013)/2 Guns (2013) [1080p] [AAC 2ch].mp4")
#   end

#   def test_has_file_returns_false_if_doesnt_exist
#     @media = @movie.medias.first
#     assert !@media.has_file?("/volume1/Media/TV/bad-file.mp4")
#   end


#   # part

#   def test_media_part
#     @media = @movie.medias.first
#     @part = @media.part
#     assert @part.is_a?(Plex::Part)
#   end


#   # to_hash

#   def test_to_hash_includes_parts
#     @media = @movie.medias.first
#     assert @media.to_hash.keys.include?(:parts)
#   end


#   # part 

#   def test_part_is_first_record_of_parts
#     @media = @movie.medias.first
#     @part = @media.part
#     @parts = @media.parts
#     assert_equal @parts.first, @part
#   end

# end
