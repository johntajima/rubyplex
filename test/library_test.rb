require "test_helper"

class LibraryTest < Minitest::Test
  
  def setup
    @server = Plex.server
    @library_params = {
      "allowSync"  => true,
      "art"        => "/:/resources/movie-fanart.jpg",
      "composite"  => "/library/sections/8/composite/1542179087",
      "filters"    => true,
      "refreshing" => false,
      "thumb"      => "/:/resources/movie.png",
      "key"        => "8",
      "type"       => "movie",
      "title"      => "4K Movies",
      "agent"      => "com.plexapp.agents.imdb",
      "scanner"    => "Plex Movie Scanner",
      "language"   => "en",
      "uuid"       => "36b7bf82-784e-4c0c-a219-e51549ebc255",
      "updatedAt"  => 1536625963,
      "createdAt"  => 1512309737,
      "scannedAt"  => 1542179087,
      "Location"   => [
        {"id"=>17, "path"=>"/volume4/Media2/Movies_HQ"},
        {"id"=>22, "path"=>"/volume4/Media2/hq_downloads"}
      ]
    }
    stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
  end


  # .new

  def test_new_library_creates_library_model
    @library = Plex::Library.new(@library_params)
    assert @library.is_a?(Plex::Library)
    assert_equal 8, @library.key.to_i
    assert_equal "4K Movies", @library.title
    assert_equal 2, @library.locations.count
  end


  # .total_count

  def test_total_returns_total_entries_in_library_for_movies
    stub_request(:get, @server.query_path("/library/sections/1/all?X-Plex-Container-Size=0&X-Plex-Container-Start=0")).to_return(body: load_response(:movie_count))

    @library = Plex.server.library(1)
    assert_equal "Movies", @library.title
    count = @library.total_count
    assert_equal 100, count
  end


  # .all

  def test_all_returns_all_movies
    stub_request(:get, @server.query_path("/library/sections/1/all")).to_return(body: load_response(:library_1))

    @library = Plex.server.library(1)
    @movies = @library.all

    assert_equal 5, @movies.count
    assert @movies.first.is_a?(Plex::Movie)
  end

  def test_all_with_pagination
    stub_request(:get, @server.query_path("/library/sections/1/all?X-Plex-Container-Size=10&X-Plex-Container-Start=10"))
      .to_return(body: load_response(:library_1))
      
    @library = Plex.server.library(1)
    @results = @library.all(options: {page: 2, per_page: 10})
  end


  # recentlyAdded

  def test_recentlyAdded
    stub_request(:get, @server.query_path("/library/sections/1/recentlyAdded")).to_return(body: load_response(:library_1))
    @library = Plex.server.library(1)
    @results = @library.recently_added
    assert_equal 5, @results.count
  end


  # .find_by_filename

  def test_find_by_filename_returns_movie_that_has_media_with_file
    stub_request(:get, @server.query_path("/library/sections/1/all")).to_return(body: load_response(:library_1))
    #stub_request(:get, @server.query_path("library/metadata/17911")).to_return(body: load_response(:movie1))
    filename = "/volume1/Media/Movies/2 Guns (2013)/2 Guns (2013) [1080p] [AAC 2ch].mp4"
    @library = Plex.server.library(1)
    movie = @library.find_by_filename(filename)
    assert movie.is_a?(Plex::Movie)
    assert_equal "2 Guns", movie.title
  end

  def test_find_by_filename_returns_nil_if_not_found
    stub_request(:get, @server.query_path("/library/sections/1/all")).to_return(body: load_response(:library_1))
    filename = "/volume1/Media/Movies/some_invalid_movie.mp4"
    @library = Plex.server.library(1)
    media = @library.find_by_filename(filename)
    assert_nil media
  end


  # .movie_library?
  
  def test_movie_library_returns_true_if_library_is_for_movies
    @library = Plex.server.library(3)
    assert @library.movie_library?
    assert_equal "movie", @library.type  
  end

  def test_movie_library_returns_false_if_library_is_for_shows
    @library = Plex.server.library(2)
    assert !@library.movie_library?
  end


  # show tests


  def test_all_returns_all_shows
    stub_request(:get, @server.query_path("/library/sections/2/all")).to_return(body: load_response(:library_2))
    stub_request(:get, @server.query_path("/library/metadata/10401/allLeaves")).to_return(body: load_response(:show_1))
    stub_request(:get, @server.query_path("/library/metadata/10320/allLeaves")).to_return(body: load_response(:show_2))
    @library = Plex.server.library(2)
    @results = @library.all

    assert_equal 2, @results.count
    assert @results.first.is_a?(Plex::Show)
  end

  def test_total_returns_total_entries_in_library_for_shows
    stub_request(:get, @server.query_path("/library/sections/2/all?X-Plex-Container-Size=0&X-Plex-Container-Start=0")).to_return(body: load_response(:show_count))
    
    @library = Plex.server.library(2)
    assert_equal "TV Shows", @library.title
    count = @library.total_count
    assert_equal 50, count
  end

  def test_show_library_returns_true_if_library_is_show
    @library = Plex.server.library(2)
    assert @library.show_library?
    assert_equal "show", @library.type
  end

  def test_find_by_filename_returns_media_model_for_show
    stub_request(:get, @server.query_path("/library/sections/2/all")).to_return(body: load_response(:library_2))
    stub_request(:get, @server.query_path("/library/metadata/10401/allLeaves")).to_return(body: load_response(:show_1))
    stub_request(:get, @server.query_path("/library/metadata/10320/allLeaves")).to_return(body: load_response(:show_2))
    @library = Plex.server.library(2)

    file = "/volume1/Media/TV/Band of Brothers/Band of Brothers S01/Band of Brothers S01E01 [1080p].mp4"
    show = @library.find_by_filename(file)
    assert show.is_a?(Plex::Show)
    assert_equal "Band of Brothers", show.title
  end

end
