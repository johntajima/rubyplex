require "test_helper"

class MovieTest < Minitest::Test
  
  def setup
    @server = Plex.server
    stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
    stub_request(:get, @server.query_path("/library/sections/1/all")).to_return(body: load_response(:library_1))
    @library = Plex.server.library(1)
  end


  # new

  def test_new_movie
    @movie = @library.all.first
    assert_equal "2 Guns", @movie.title
    keys = [:added_at, :countries, :directors, :duration, :genres, :id, :rating, :release_date, :roles, :title, :type, :updated_at, :year]
    assert_equal keys, @movie.attributes.keys.sort
    
    assert_equal 1, @movie.medias.count
  end


  # to_hash

  def test_to_hash
    stub_request(:get, @server.query_path("/library/metadata/17911")).to_return(body: load_response(:movie1))
    @movie = @library.all.first

    assert @movie.to_hash.is_a?(Hash)
    assert @movie.to_hash.key?(:medias)
  end


  # by_file 

  def test_by_file_returns_media_if_found
    stub_request(:get, @server.query_path("/library/metadata/17911")).to_return(body: load_response(:movie1))
    @movie = @library.all.first

    media = @movie.by_file("/volume1/Media/Movies/2 Guns (2013)/2 Guns (2013) [1080p] [AAC 2ch].mp4")
    assert media.is_a?(Plex::Media)
  end

  def test_by_file_returns_nil_if_not_found
    stub_request(:get, @server.query_path("/library/metadata/17911")).to_return(body: load_response(:movie1))
    @movie = @library.all.first

    assert_nil @movie.by_file("/volume1/Media/Movies/bad_name.mp4")
  end


  # imdb

  def test_imdb_loads_metadata_and_returns_imdb_if_found
    stub_request(:get, @server.query_path("/library/metadata/17911")).to_return(body: load_response(:movie1))
    @movie = @library.all.first

    assert_equal "tt1272878", @movie.imdb
  end

  def test_tmdb_loads_metadata_and_return_tmdb_if_found
    stub_request(:get, @server.query_path("/library/metadata/17911")).to_return(body: load_response(:movie1))
    @movie = @library.all.first

    assert_nil @movie.tmdb
  end

end
