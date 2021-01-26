require "test_helper"

class MovieTest < Minitest::Test
  
  def setup
    @server = Plex.server
    stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
    stub_request(:get, @server.query_path("/library/sections/1/all")).to_return(body: load_response(:library_1))
    @library = Plex.server.library(1)
  end


  # load_details!

  def test_load_details_loads_detail_metadata
    stub_request(:get, @server.query_path("library/metadata/17911")).to_return(body: load_response(:movie1))
    @movie = @library.all.first
    @movie.load_details!

  end



  # new

  def test_new_movie
    @movie = @library.all.first
    assert_equal "2 Guns", @movie.title
    assert @movie.is_a?(Plex::Movie)
    assert_equal 1, @movie.medias.count
  end


  # medias

  def test_medias_returns_array_of_medias_for_movie
    @movie = @library.all.first
    @medias = @movie.medias
    assert @medias.first.is_a?(Plex::Media)
  end

  # files

  def test_files_returns_array_of_media_files
    @movie = @library.all.first
    list = @movie.files
    assert_equal 1, list.size
    assert_equal "/volume1/Media/Movies/2 Guns (2013)/2 Guns (2013) [1080p] [AAC 2ch].mp4", list.first
  end


  # find_by_filename

  def test_find_by_filename_returns_media_that_has_file
    @movie = @library.all.first
    media = @movie.find_by_filename("2 Guns (2013) [1080p] [AAC 2ch].mp4")
    assert media.is_a?(Plex::Media)
  end

  def test_find_by_filename_returns_nil_if_path_doesnt_match_and_full_path_required
    @movie = @library.all.first

    media = @movie.find_by_filename("2 Guns (2013) [1080p] [AAC 2ch].mp4", full_path: true)
    assert_nil media
  end

  def test_find_by_filename_returns_nil_if_file_doesnt_exist
    @movie = @library.all.first

    media = @movie.find_by_filename("Some bad movie [AAC 2ch].mp4")
    assert_nil media
  end


  # imdb

  def test_imdb_loads_metadata_and_returns_imdb_if_found
    @movie = @library.all.first

    assert_equal "tt1272878", @movie.imdb
  end

  # release_date

  def test_release_date
    @movie = @library.all.first
    assert_equal @movie.release_date, @movie.originally_available_at
  end

  # id

  def test_id
    @movie = @library.all.first
    assert @movie.id.is_a?(Integer)
    assert_equal @movie.id, @movie.rating_key.to_i
  end

  # genre, director, role, country

  def test_tags
    @movie = @library.all.first
    genres = @movie.genre
    assert_equal 2, genres.size

    assert @movie.director.is_a?(Array)
    assert @movie.role.is_a?(Array)
    assert @movie.country.is_a?(Array)
  end

  def test_to_hash
    @movie = @library.all.first

    assert @movie.to_hash.is_a?(Hash)
    hash_keys = @movie.to_hash.keys.sort
    keys =  [
              "Country", "Director", "Genre", "Media", "Role", "Writer", 
              "addedAt", "art", "audienceRating", "audienceRatingImage", 
              "contentRating", "duration", "guid", "key", 
              "originallyAvailableAt", "primaryExtraKey", "rating", 
              "ratingImage", "ratingKey", "studio", "summary", "tagline", 
              "thumb", "title", "type", "updatedAt", "year"
            ]
    assert_equal keys, hash_keys
  end

  def test_to_json
    @movie = @library.all.first
    json = @movie.to_json
    assert json.is_a?(String)
  end

end
