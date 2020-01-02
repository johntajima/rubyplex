require "test_helper"

class LibraryTest < Minitest::Test
  
  def setup
    @server = Plex.server
    @library_params = {"allowSync"=>true,
      "art"=>"/:/resources/movie-fanart.jpg",
      "composite"=>"/library/sections/8/composite/1542179087",
      "filters"=>true,
      "refreshing"=>false,
      "thumb"=>"/:/resources/movie.png",
      "key"=>"8",
      "type"=>"movie",
      "title"=>"4K Movies",
      "agent"=>"com.plexapp.agents.imdb",
      "scanner"=>"Plex Movie Scanner",
      "language"=>"en",
      "uuid"=>"36b7bf82-784e-4c0c-a219-e51549ebc255",
      "updatedAt"=>1536625963,
      "createdAt"=>1512309737,
      "scannedAt"=>1542179087,
      "Location"=>
       [{"id"=>17, "path"=>"/volume4/Media2/Movies_HQ"},
        {"id"=>22, "path"=>"/volume4/Media2/hq_downloads"}]}
    
    stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
  end

  # .new
  def test_new_library_creates_library_model
    @library = Plex::Library.new(@library_params)
    assert @library.is_a?(Plex::Library)
    assert_equal 8, @library.id
    assert_equal "4K Movies", @library.title
    assert_equal 2, @library.directories.count
  end

  # .total_count
  def test_total_returns_total_entries_in_library_for_movies
    stub_request(:get, @server.query_path("/library/sections/1/all")).to_return(body: load_response(:movie_count))

    @library = Plex.server.library(1)
    assert_equal "Movies", @library.title
    count = @library.total_count
    assert_equal 100, count
  end

  def test_total_returns_total_entries_in_library_for_shows
    stub_request(:get, @server.query_path("/library/sections/2/all")).to_return(body: load_response(:show_count))
    
    @library = Plex.server.library(2)
    assert_equal "TV Shows", @library.title
    count = @library.total_count
    assert_equal 50, count
  end

  # .all
  def test_all_returns_all_movies
    stub_request(:get, @server.query_path("/library/sections/3/all")).to_return(body: load_response(:movie_all))

    @library = Plex.server.library(3)
    @movies = @library.all

    assert_equal 5, @movies.count
    assert @movies.first.is_a?(Plex::Movie)
  end

  def test_all_returns_all_shows
    stub_request(:get, @server.query_path("/library/sections/2/all")).to_return(body: load_response(:show_all))
    stub_request(:get, @server.query_path("/library/metadata/10401/allLeaves")).to_return(body: load_response(:show1))
    stub_request(:get, @server.query_path("/library/metadata/10320/allLeaves")).to_return(body: load_response(:show2))
    @library = Plex.server.library(2)
    @results = @library.all

    assert_equal 2, @results.count
    assert @results.first.is_a?(Plex::Show)
  end

  def test_all_with_per_page_options
  end

  def test_all_with_pagination
  end



  # various query methods
  def test_newest_sends_right_query_string_to_server
  end

  # .find_by_filename
  def test_find_by_filename_returns_media_model_for_movie
  end

  # .find_by_filename
  def test_find_by_filename_returns_media_model_for_show
  end


  # .to_hash
  def test_to_hash
  end

  # .movie_library?
  def test_movie_library_returns_true_if_library_is_for_movies
  end

  def test_movie_library_returns_false_if_library_is_for_shows
  end

end
