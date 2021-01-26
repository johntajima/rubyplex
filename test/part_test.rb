require "test_helper"

class PartTest < Minitest::Test
  
  def setup
    @server = Plex.server
    stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
    stub_request(:get, @server.query_path("/library/sections/1/all")).to_return(body: load_response(:library_1))
    @library = Plex.server.library(1)
    @movie = @library.all.first
    @media = @movie.medias.first
  end


  # has_file?

  def test_has_file_returns_true_if_file_matches
    @part = @media.parts.first

    assert @part.has_file?("/volume1/Media/Movies/2 Guns (2013)/2 Guns (2013) [1080p] [AAC 2ch].mp4")
    assert @part.has_file?("Movies/2 Guns (2013)/2 Guns (2013) [1080p] [AAC 2ch].mp4")
  end

  def test_has_file_returns_false_if_file_does_not_match
    @part = @media.parts.first

    assert !@part.has_file?("/volume1/Media/Movies/bad.mp4")
  end

end
